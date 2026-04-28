# 🏥 Healthcare Application — SAP BTP

A **Healthcare Management** web application built on **SAP Business Technology Platform (BTP)** using the **SAP Cloud Application Programming Model (CAP)**. It features a rich HTML5/SAPUI5 frontend for healthcare data management with a CDS-based OData backend.

---

## 📁 Project Structure

---

## 🚀 Tech Stack

| Layer        | Technology                                  |
|--------------|----------------------------------------------|
| Frontend     | HTML5 (74%), SAPUI5 / Fiori Elements         |
| Backend      | Node.js + SAP CAP (CDS Services)             |
| Data Model   | CAP CDS (25%) + SQLite (local) / HANA (prod) |
| Platform     | SAP Business Technology Platform (BTP)       |

---

## ✨ Features

- 🏥 Healthcare domain data model (Patients, Doctors, Appointments, etc.)
- 📋 OData-based REST API services via SAP CAP
- 🌐 Rich HTML5 / SAPUI5 frontend for healthcare data management
- 🗄️ SQLite (`my.db`) for local development
- ☁️ Ready for deployment to SAP BTP Cloud Foundry

---

## 🛠️ Prerequisites

- [Node.js](https://nodejs.org/) (v18 or higher)
- [SAP CAP CLI](https://cap.cloud.sap/docs/get-started/) — install globally:
```bash
