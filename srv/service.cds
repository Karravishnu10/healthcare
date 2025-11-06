using health as health from '../db/health';

service HealthService @(path:'/health') {

  // Core entities
  entity Patients              as projection on health.Patient;
  entity PatientIdentifiers    as projection on health.PatientIdentifier;
  entity ConsentRecords        as projection on health.ConsentRecord;

  entity Devices               as projection on health.Device;
  entity DeviceAssignments     as projection on health.DeviceAssignment;
  entity VitalReadings         as projection on health.VitalReading;

  entity Encounters            as projection on health.Encounter;
  entity EncounterObservations as projection on health.EncounterObservation;

  entity Alerts                as projection on health.Alert;
  entity AlertHistory          as projection on health.AlertHistory;

  entity AuditLogs             as projection on health.AuditLog;
}
