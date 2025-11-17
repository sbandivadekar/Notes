# Introduction to Data Warehouse
### **1. Database (DB)** 📚

- **Purpose:** Stores current, detailed operational data.
- **Use case:** Daily business operations (transactions, app data).
- **Data type:** Mostly raw, real-time, structured.
- **Design:** Optimized for _OLTP_ (Online Transaction Processing) → fast inserts/updates.
- **Example:** Banking app storing account balances, transactions.
### **2. Data Warehouse (DW)** 🏛

- **Purpose:** Store processed, structured, historical data for analytics.
- **Data:** Mostly structured (tables, rows, columns).
- **Schema:** **Schema-on-write** → data is cleaned and structured _before_ storing.
- **Performance:** Very fast for analytical queries (OLAP).
- **Users:** Business analysts, data analysts.
- **Example:** Snowflake, Amazon Redshift, Google BigQuery.

> Basically DWH is large storage where most of the time build upon some DB which means It is a simple kind of DB where we can scale up/down or query execution.
### **3. Data Lake (DL)** 🌊

- **Purpose:** Store _all_ types of data (raw or processed) at low cost.
- **Data:** Structured, semi-structured (JSON, Parquet), unstructured (images, videos, logs).
- **Schema:** **Schema-on-read** → store raw data, structure it _when you query_.
- **Performance:** Slower unless combined with a query engine.
- **Users:** Data engineers, data scientists.
- **Example:** AWS S3 + Athena, Azure Data Lake, Hadoop HDFS.

> In the traditional DHW, DW was build upon DB but, in modern DWH DB engine is integrated so that data can we processed via DB operation.

---
# Data Virtualization
**Data Virtualization** is a technology that lets you **access and query data from multiple different sources without actually moving or copying it** into one place.

### **How it works**
- Instead of physically storing all the data in a single database or warehouse, a **virtualization layer** connects to your sources (databases, APIs, files, data lakes).
- When you run a query, it **fetches data in real time** from each source, combines it, and shows it as if it were coming from one database.
- You see a **unified view**, but the data stays where it originally lives.

|Feature / Aspect|**Data Warehouse (DW)** 🏛|**Data Virtualization (DV)** 🪞|**Data Lake (DL)** 🌊|
|---|---|---|---|
|**Stores Data?**|✅ Yes (copied from sources after ETL/ELT)|❌ No (data stays at source)|✅ Yes (raw or processed data)|
|**Data Type**|Structured (tables, rows, columns)|Any (depends on source)|Structured, Semi-structured, Unstructured|
|**Schema Approach**|Schema-on-write (clean & structure before storing)|No fixed schema (depends on query)|Schema-on-read (organize when you query)|
|**Best For**|Historical analysis, aggregated reporting|Real-time integration without moving data|Storing large amounts of raw, mixed-format data|
|**Performance**|Very fast (optimized storage, indexes, columnar format)|Depends on source system speed|Slower unless optimized with query engines|
|**Data Freshness**|Slight delay (due to ETL/ELT load process)|Real-time or near real-time|Depends on ingestion frequency|
|**Cost**|Higher (storage + compute)|Lower (no duplicate storage)|Low storage cost, compute cost varies|
|**Examples**|Snowflake, Amazon Redshift, Google BigQuery|Denodo, Dremio, Starburst|AWS S3 + Athena, Azure Data Lake, Hadoop|

---
# Life cycle of Data

> sources ➡️ ETL/ELT ➡️ Data Lakes | Data Warehouses ➡️ Data Modeling ➡️ Data marts ➡️ BI | Dashboards

![[Pasted image 20250812113359.png | 250]]

