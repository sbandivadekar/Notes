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

---
# 📥 Bulk Loading with COPY INTO in Snowflake

## 🔹 What is Bulk Loading?
Bulk loading is the process of **loading large volumes of data** from staged files into Snowflake tables using the `COPY INTO` command.  

It is optimized for **high performance parallel loading**.

---

## 📌 Syntax
```sql
COPY INTO <table_name>
FROM @<stage_name>/<path>
FILE_FORMAT = (TYPE = CSV)
ON_ERROR = CONTINUE;
```

| Option            | Description                                                                |
| ----------------- | -------------------------------------------------------------------------- |
| `FILE_FORMAT`     | Defines the format of files (CSV, JSON, Parquet, etc.)                     |
| `ON_ERROR`        | How to handle errors (`ABORT_STATEMENT`, `CONTINUE`, `SKIP_FILE`)          |
| `PATTERN`         | Load only files matching a regex pattern                                   |
| `FORCE = TRUE`    | Reload files even if already marked as loaded                              |
| `VALIDATION_MODE` | Dry-run validation (`RETURN_ERRORS`, `RETURN_ALL_ERRORS`, `RETURN_N_ROWS`) |

---
# 📌 Storage Integration in Snowflake

## 🔹 Definition

A **storage integration** is a **Snowflake object** that stores **connection information and credentials** for accessing **external cloud storage** (S3, Azure Blob, GCS).

It’s mainly used for **external stages** so that Snowflake can read/write files securely without exposing your credentials in SQL.
## 🔹 Why do we need it?

- Without storage integration → you’d have to put **access keys/secrets** in `CREATE STAGE` statements ❌ (not secure).
    
- With storage integration → credentials are stored **securely in Snowflake**, managed by **account admins**, and linked with cloud IAM roles/service principals. ✅

---
# 🌐 What is Snowpipe?

**Snowpipe** is a **continuous data ingestion service** in Snowflake that **automatically loads data** from a stage (internal or external) into a Snowflake table **as soon as the files are available**.
## ⚙️ How Snowpipe Works
1. **Data arrives** in a stage (internal stage, S3, Azure Blob, GCP bucket, etc.).
2. **Snowpipe detects new files** (using event notifications or manual trigger).
3. **COPY INTO command runs automatically** (behind the scenes).
4. Data is **loaded into the target table**.

## Methods in snowpipe
## **1. Snowpipe using REST API (Programmatic Method)**

- You call the **Snowpipe REST API** from your application or script.
- Typically used when:
    - You want to control ingestion from your app.
    - Event notifications aren’t available (or you don’t want them).
- API call tells Snowflake **which files to load** from the stage.
- Snowflake then loads those files asynchronously.

### **Example Flow:**

1. Application uploads a file to S3 (or another stage).    
2. Application calls Snowpipe **REST API**:
3. Snowpipe queues the files and ingests them into the table.
## **2. Snowpipe using Cloud Messaging (Event-driven / Auto-ingest)**

- Uses **cloud event notifications**:
    - AWS → **S3 event notifications → SNS → SQS → Snowflake**
    - Azure → **Event Grid → Snowflake**
    - GCP → **Pub/Sub → Snowflake**
- Whenever a new file lands in storage, the message is pushed to Snowflake.
- Snowpipe automatically picks up the file and loads it.
- No need for your app to call APIs.

|**Aspect**|**Messaging (Auto-ingest)**|**REST API**|
|---|---|---|
|**Trigger**|Cloud storage events (SNS/Event Grid/PubSub)|Application calls API|
|**Use case**|Fully automated ingestion|Custom control by app|
|**Latency**|Near real-time|Near real-time (depends on app call)|
|**Setup**|Needs integration with cloud event services|Needs API client (Python, Java, etc.)|
|**Cost**|Same Snowpipe compute cost + minimal cloud notification cost|Same Snowpipe compute cost|

---
# Validation Mode
**Validation mode** lets you **check files before loading them** into a table.  
Instead of actually inserting rows, Snowflake validates them against the **table schema + file format**

> 👉 This is useful to **detect data quality issues** (bad rows, type mismatches, etc.) before real loading.


⚙️ Syntax
```sql
COPY INTO target_table
FROM @stage_name/file.csv
FILE_FORMAT = (TYPE = 'CSV')
VALIDATION_MODE = RETURN_ALL_ERRORS;
```

## **🛠️ Types of Validation Mode**

### **1. RETURN_ERRORS**
- Returns a **sample of up to 100 errors** found in the data files.
- Useful for quick debugging.

Example:
```sql
COPY INTO my_table
FROM @my_stage
FILE_FORMAT = (TYPE=CSV)
VALIDATION_MODE = RETURN_ERRORS;
```

### **2. RETURN_ALL_ERRORS**
- Returns **all errors** found (not limited to 100).
- Helpful for full data quality check, but can be slower if files are large.

Example
```sql
COPY INTO my_table
FROM @my_stage
FILE_FORMAT = (TYPE=CSV)
VALIDATION_MODE = RETURN_ALL_ERRORS;
```
### Options:
1. **`ON_ERROR = CONTINUE`**
    - Snowflake loads the **valid rows**.
    - Skips (ignores) rows with errors.
    - Example: If file has 100 rows, 2 are bad → 98 are inserted, 2 skipped.
2. **`ON_ERROR = ABORT_STATEMENT`** (default)
    - If **any error occurs**, the whole load fails ❌.
    - No rows are inserted.
3. **`ON_ERROR = SKIP_FILE`**
    - If errors are found in a file, the **entire file is skipped**.
    - Other files in the same COPY command still load.
4. **`ON_ERROR = SKIP_FILE_<num>`**
    - Skip file only if errors exceed `<num>` rows.
    - Example: `ON_ERROR = SKIP_FILE_5` → If ≤ 5 errors, load valid rows. If > 5 errors, skip whole file.

---
# ❄️ Unloading Data in Snowflake
**Unloading = Exporting data from Snowflake tables into external files**  
(usually into cloud storage like S3, Azure Blob, or GCP buckets).

Think of it as the **reverse of `COPY INTO` loading**:
- **Loading** → `COPY INTO <table> FROM @stage`
- **Unloading** → `COPY INTO @stage FROM <table>`

```sql
COPY INTO @my_stage/unload_dir/
FROM my_table
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"')
HEADER = TRUE;
```


### **🛠️ Example Scenarios**

 1. Unload to CSV
 ```sql
COPY INTO @my_stage/sales_export/
FROM sales
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"')
HEADER = TRUE;
```
