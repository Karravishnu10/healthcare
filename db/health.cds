namespace health;

using { cuid } from '@sap/cds/common';

/*
  SQLite-safe version:
  - Removed all "default cuid()" from keys (SQLite can't use function defaults).
  - Kept @(cds.on.insert:$now) — CAP runtime will populate on insert.
  - All fields required (no '?').
*/

/* ---------------------------
   Patient
   --------------------------- */
@(odata.draft.enabled:true)
@(cds.persistence.table:true)
@(UI.headerInfo:{ typeName:'Patient', title:'lastName, firstName', description:'ID' })
entity Patient {
  key ID              : UUID    @(title:'Patient UUID');   // <- no default cuid()
  firstName           : String(100);
  lastName            : String(100);
  middleName          : String(100);
  gender              : String(16);
  dateOfBirth         : Date;

  /* Contact info */
  phone               : String(50);
  email               : String(254);
  address             : String(1024);
  primaryLanguage     : String(50);

  /* Audit info */
  createdBy           : String(100);
  createdAt           : DateTime    @(readonly:true);
  modifiedBy          : String(100);
  modifiedAt          : DateTime    @(readonly:true);
  sourceSystem        : String(100);

  /* Owned children */
  identifiers         : Composition of many PatientIdentifier on identifiers.patient = $self;
  consents            : Composition of many ConsentRecord on consents.patient = $self;
}

/* PatientIdentifier (owned by Patient) */
@(cds.persistence.table:true)
@(UI.lineItem:[{position:10,label:'ID Type'},{position:20,label:'ID Value'}])
entity PatientIdentifier {
  key ID              : UUID;                     // <- no default cuid()
  patient             : Association to Patient;
  idType              : String(50);
  idValue             : String(200);
  issuingAuthority    : String(200);
  validFrom           : DateTime;
  validTo             : DateTime;
}

/* ConsentRecord (owned by Patient) */
@(cds.persistence.table:true)
@(UI.lineItem:[{position:10,label:'Consent Type'},{position:20,label:'Granted'}])
entity ConsentRecord {
  key ID              : UUID;                     // <- no default cuid()
  patient             : Association to Patient;
  consentType         : String(100);
  consentGranted      : Boolean;
  grantedBy           : String(200);
  grantedAt           : DateTime;
  expiresAt           : DateTime;
  scope               : String(1000);
  version             : String(50);
  revokedAt           : DateTime;
  revokedBy           : String(200);
  note                : String(2000);
}

/* ---------------------------
   Device + children
   --------------------------- */
@(cds.persistence.table:true)
@(UI.headerInfo:{ title:'deviceId', typeName:'Device' })
entity Device {
  key deviceId        : String(100);
  model               : String(100);
  manufacturer        : String(100);
  deviceType          : String(50);
  firmwareVersion     : String(50);
  registeredAt        : DateTime;
  lastSeenAt          : DateTime;
  status              : String(50);
  metadata            : String(2000);

  assignments         : Composition of many DeviceAssignment on assignments.device = $self;
  readings            : Composition of many VitalReading on readings.device = $self;
}

/* DeviceAssignment (owned by Device) */
@(cds.persistence.table:true)
entity DeviceAssignment {
  key ID              : UUID;                     // <- no default cuid()
  device              : Association to Device;
  patient             : Association to Patient;
  assignedBy          : String(200);
  assignedAt          : DateTime;
  unassignedAt        : DateTime;
  assignmentStatus    : String(50);
  purpose             : String(200);
  notes               : String(2000);
}

/* VitalReading (owned by Device; refs Patient) */
@(cds.persistence.table:true)
@(UI.lineItem:[{position:10,label:'patient'},{position:20,label:'measurementType'},{position:30,label:'valueNumeric'}])
entity VitalReading {
  key ID              : UUID;                     // <- no default cuid()
  patient             : Association to Patient;
  device              : Association to Device;
  recordedAt          : DateTime;
  measurementType     : String(50);
  valueNumeric        : Decimal(18,6);
  valueText           : String(500);
  unit                : String(50);
  rawPayload          : String(2000);
  ingestionSource     : String(200);
  createdAt           : DateTime  @(cds.on.insert:$now);
}

/* ---------------------------
   Encounter + observations
   --------------------------- */
@(odata.draft.enabled:true)
@(cds.persistence.table:true)
@(UI.headerInfo:{ title:'encounterType, startAt', typeName:'Encounter' })
entity Encounter {
  key ID              : UUID;                     // <- no default cuid()
  patient             : Association to Patient;
  encounterType       : String(100);
  startAt             : DateTime;
  endAt               : DateTime;
  clinicianId         : String(100);
  facilityId          : String(100);
  reason              : String(1000);
  status              : String(50);
  notes               : String(4000);

  observations        : Composition of many EncounterObservation on observations.encounter = $self;

  /* Audit */
  createdBy           : String(100);
  createdAt           : DateTime    @(readonly:true);
  modifiedBy          : String(100);
  modifiedAt          : DateTime    @(readonly:true);
  sourceSystem        : String(100);
}

/* EncounterObservation (owned by Encounter) */
@(cds.persistence.table:true)
entity EncounterObservation {
  key ID              : UUID;                     // <- no default cuid()
  encounter           : Association to Encounter;
  observationType     : String(100);
  observationAt       : DateTime;
  valueText           : String(4000);
  valueNumeric        : Decimal(18,6);
  unit                : String(50);
  performedBy         : String(200);
  attachmentRef       : String(200);
}

/* ---------------------------
   Alert + history
   --------------------------- */
@(cds.persistence.table:true)
@(UI.headerInfo:{ title:'severity, createdAt', typeName:'Alert' })
entity Alert {
  key ID              : UUID;                     // <- no default cuid()
  patient             : Association to Patient;
  relatedEncounter    : Association to Encounter;
  createdAt           : DateTime    @(cds.on.insert:$now);
  severity            : String(20);
  ruleId              : String(200);
  message             : String(2000);
  status              : String(50);
  acknowledgedBy      : String(200);
  acknowledgedAt      : DateTime;
  clearedAt           : DateTime;
  externalRef         : String(200);

  history             : Composition of many AlertHistory on history.alert = $self;

  /* Audit-lite */
  createdBy           : String(100);
  modifiedBy          : String(100);
  modifiedAt          : DateTime    @(readonly:true);
}

/* AlertHistory (owned by Alert) */
@(cds.persistence.table:true)
entity AlertHistory {
  key ID              : UUID;                     // <- no default cuid()
  alert               : Association to Alert;
  changedAt           : DateTime    @(cds.on.insert:$now);
  changedBy           : String(200);
  fromStatus          : String(50);
  toStatus            : String(50);
  note                : String(2000);
}

/* ---------------------------
   AuditLog (append-only)
   --------------------------- */
@(cds.persistence.table:true)
entity AuditLog {
  key ID              : UUID;                     // <- no default cuid()
  eventAt             : DateTime    @(cds.on.insert:$now);
  userId              : String(200);
  action              : String(200);
  targetEntity        : String(200);
  targetId            : String(200);
  details             : String(4000);
  sourceIp            : String(100);
  reason              : String(4000);
}
