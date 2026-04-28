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
  npm install -g @sap/cds-dk
```
- SAP BTP account (for cloud deployment)
- Cloud Foundry CLI (`cf`) — for BTP deployment

---

## 📦 Installation

1. **Clone the repository:**
```bash
   git clone https://github.com/Karravishnu10/healthcare.git
   cd healthcare
```

2. **Install dependencies:**
```bash
   npm install
```

---

## ▶️ Running Locally

Start the CAP development server with live reload:

```bash
cds watch
```

> In VS Code: go to **Terminal → Run Task → cds watch**

The application will be available at: **`http://localhost:4004`**

The local SQLite database (`my.db`) will be created and used automatically during development.

---

## 🗄️ Database

This project uses **SQLite** for local development (files: `my.db-shm` and `my.db-wal`).

To reset or reinitialize the local database:

```bash
cds deploy --to sqlite:my.db
```

For production on SAP BTP, the application connects to **SAP HANA Cloud**.

---

## 🏗️ Build for Production

```bash
npm ci
npx cds build --production
```

---

## ☁️ Deploying to SAP BTP (Cloud Foundry)

1. **Login to Cloud Foundry:**
```bash
   cf login -a <CF_API_ENDPOINT> -o <ORG> -s <SPACE>
```

2. **Build and deploy:**
```bash
   npx cds build --production
   cf push
```

   Or using MTA (if `mta.yaml` is configured):
```bash
   mbt build
   cf deploy mta_archives/<your-archive>.mtar
```

---

## 📂 Key Files Explained

| File/Folder        | Purpose                                                       |
|--------------------|---------------------------------------------------------------|
| `app/`             | HTML5 frontend — SAPUI5 views, controllers, manifest         |
| `db/`              | CAP CDS entities (e.g., Patients, Doctors, Appointments)      |
| `srv/`             | OData service definitions and custom business logic handlers  |
| `my.db-shm/wal`    | Local SQLite database files for development                   |
| `package.json`     | Node.js dependencies and CAP project configuration            |
| `eslint.config.mjs`| Linting rules for JavaScript code quality                     |

---

## 📖 Learn More

- [SAP CAP Documentation](https://cap.cloud.sap/docs/get-started/)
- [SAP BTP Developer Guide](https://developers.sap.com/tutorials/btp-cockpit-setup.html)
- [SAPUI5 Documentation](https://ui5.sap.com/)
- [SAP HANA Cloud](https://www.sap.com/products/technology-platform/hana.html)

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is open source. Feel free to use and modify it for your own learning and projects.

---

## 👤 Author

**Karravishnu10**  
GitHub: [@Karravishnu10](https://github.com/Karravishnu10)
