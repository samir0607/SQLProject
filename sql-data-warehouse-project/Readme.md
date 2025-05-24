Here’s a complete `README.md` for your SQL Server Docker project — cross-platform compatible with **macOS, Windows, and Linux**.

---

## 📘 README.md

```markdown
# SQL Server Docker Project (Cross-Platform)

This project sets up a local SQL Server instance using Docker, with support for `BULK INSERT` from a mounted dataset. It works seamlessly across **macOS**, **Windows**, and **Linux**.

---

## 🧱 Folder Structure

```

sql-server-project/
├── docker-compose.yml
├── .env
├── README.md
└── datasets/
		└── source_crm/
				└── cust_info.csv
		└── source_erp/
				└── CUST_AZ12.csv
````

---

## ⚙️ Setup Instructions

### 1. Clone this repository

```bash
git clone https://github.com/samir0607/SQLProject
cd sql-server-project
````

---

### 2. Rename `$.env` to `.env` File

Update a file named `.env` in the project root:

```env
SA_PASSWORD=password
```

You can change the password, but it must meet SQL Server's complexity rules.

---

### 3. Place Your CSV File

Put your data file at:

```
datasets/source_crm/cust_info.csv
```

Make sure the file exists before running the container.

---

### 4. Start SQL Server

```bash
docker-compose up -d
```

This will:

* Pull the official SQL Server image (Linux-based)
* Expose it on port `1433`
* Mount your `datasets/` folder to `/data/` inside the container

---

### 5. Connect to SQL Server

Use any SQL client (e.g. Azure Data Studio, DBeaver) or `sqlcmd`:

```bash
Server: localhost
Port: 1433
Username: sa
Password: MySQL@1234
```

---

### 6. Verify File Exists Inside Container

```bash
docker exec -it sql_server /bin/bash
```
```bash
ls /data/source_crm
ls /data/source_erp
```
---

### 7. Example `BULK INSERT` Query

```sql
BULK INSERT bronze.load_bronze
FROM '/data/source_crm/cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
```

---

## 🧼 Cleanup

To stop and remove the container:

```bash
docker-compose down
```

---

## 📌 Notes

* `.env` file is used to keep secrets/config separate.
* Uses `linux/amd64` platform for broader compatibility.
* No custom Dockerfile needed — everything runs from `docker-compose.yml`.

---

## 🧩 Optional: Customize with a Dockerfile

If you need extra setup like running SQL scripts or installing tools inside the container, consider adding a `Dockerfile`.

Let us know if you want that added!

```

---

Let me know if you'd like badges (Docker, SQL Server, etc.) or instructions to auto-run SQL scripts on startup!
```
