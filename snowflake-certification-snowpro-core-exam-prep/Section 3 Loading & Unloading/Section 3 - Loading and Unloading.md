# Stages
A **stage** is simply a **storage location** for files (like CSV, JSON, Parquet) before you **load** them into tables or after you **unload** data from tables.

---
# Types of Stages
#### **1. Internal Stages**
- Files are stored **inside Snowflake’s own managed storage**.
- You don’t need any external storage account.
- Fully managed, secure, and billed by Snowflake.
- Good for small to medium data volumes or when you want simplicity.

**Types of Internal Stages:**
1. **User Stage** – 
	- Each user has a personal stage (`@~`).
	- Created automatically for every user.
2. **Table Stage** – 
	- Each table has its own stage (`@%table_name`).
	- created when table is created.
	- cannot be dropped or altered.

3. **Named Internal Stage** – 
	- A stage you explicitly create and name.
	- referred by `@stage_name`
	- more flexible

#### **2. External Stages**

- Files are stored **outside Snowflake** in your own cloud storage (AWS S3, Azure Blob, or GCP Cloud Storage).
- Snowflake just connects to the location and reads/writes data.
- Good for large volumes or when data is already in cloud storage.
- You control and pay for the storage separately.