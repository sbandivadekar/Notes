# **1. Import Mode**

- **How it works:**
    - Data is imported and stored **inside the Power BI file (.pbix)**.
    - A copy of the data is taken into Power BI’s in-memory storage (VertiPaq engine).
- **Performance:**
    - Very **fast** for analysis because data is in memory.
- **Refresh:**
    - Needs to be refreshed manually or scheduled to get updated data from the source.
- **File size:**
    - Increases with the amount of imported data (limit is **1 GB per dataset** in Power BI Service free version, 10 GB with Pro).
- **Best used when:**
    - Data is not too large.
    - Data does not change frequently.
    - You want **fast reports** and ability to use full Power BI features (DAX, transformations).

### **Steps:**

1. Open Power BI Desktop → **Home → Get Data → Choose source** (Excel, CSV, SQL DB, etc.).
2. Select the table(s) you want → click **Load**.
3. Power BI imports a copy of the data into your `.pbix` file.
4. Use it in visuals, apply transformations, etc.

✅ **Best for:** Small/medium datasets where performance is important.

# **2. DirectQuery Mode**

- **How it works:**
    - No data is stored in Power BI.
    - Queries are sent **directly to the source database** whenever you interact with visuals.
- **Performance:**
    - Depends on source database speed and network.
    - Slower than Import mode for complex reports.
- **Refresh:**
    - Always shows **real-time data**, no need for scheduled refresh.
- **File size:**
    - PBIX file is small because no data is imported.
- **Limitations:**
    - Some DAX functions and features may not be available.
    - Performance tuning required (indexes, query optimization at source).
- **Best used when:**
    - Data is **very large** (e.g., billions of rows).
    - You need **up-to-date / real-time reports**.

### **Steps:**

1. **Home → Get Data → Choose source** (SQL Server, Snowflake, etc.).
2. When prompted in the connection window, select **DirectQuery** (instead of Import).
3. Connect → data is not loaded, only metadata is imported.
4. Build visuals → queries go back to the database live.
    

✅ **Best for:** Very large datasets or when you need near real-time data.
⚠️ Limitations: Some DAX functions and transformations aren’t available.
# **3. Live Connection**

✅ **How it works:**
- Similar to DirectQuery, but instead of connecting to a raw database, Power BI connects **directly to another BI model** (like **SQL Server Analysis Services (SSAS), Azure Analysis Services, or a published Power BI dataset**).
- You don’t import data into Power BI Desktop — you’re just using the pre-built data model.

### **Key Points about Live Connection**

- **No data stored** in the PBIX file (like DirectQuery).
- You **can’t create new tables or relationships** in Power BI Desktop — the model is fully controlled in the source (SSAS or Power BI Service dataset).
- You can only create **measures, visuals, and reports** on top of the existing model.
- **Performance** depends on the SSAS/Power BI dataset engine (usually very optimized).
- **Security & Governance:** Good for large organizations, since the IT/data team manages one central model, and all report developers connect to it.

|Feature|Import Mode|DirectQuery Mode|Live Connection|
|---|---|---|---|
|Data stored in PBIX?|✅ Yes|❌ No|❌ No|
|Source|Any DB/file|Any DB|SSAS / Power BI dataset|
|Real-time data|❌ No (needs refresh)|✅ Yes|✅ Yes|
|Modeling flexibility|✅ Full|⚠️ Limited|❌ Not allowed|
|Performance|✅ Fast (in-memory)|⚠️ Depends on DB|✅ Depends on source model|
|Best for|Small/medium datasets|Large DBs needing real-time|Centralized, enterprise BI models|
# **4. Direct Lake Mode**

✅ **What it is:**

- A new storage mode in **Power BI + Fabric** that combines the **speed of Import** with the **real-time freshness of DirectQuery**.
- It works with data stored in a **Fabric OneLake Lakehouse** (or Delta tables in OneLake).
- Instead of importing the data into PBIX or sending live queries every time, Power BI **directly reads parquet/Delta files from OneLake in memory format (VertiPaq engine)**.

### **Key Features**

- **No data movement** → Data stays in **OneLake**.
- **No scheduled refresh** needed → Data is always **up-to-date**.
- **Performance is very fast** → Queries are executed with **in-memory speed**, unlike DirectQuery which depends on database performance.
- **Scalability** → Handles **very large datasets** (billions of rows) without the file-size limitation of Import.
- **Best of both worlds** → Import-like speed + DirectQuery-like freshness.

| Feature              | Import                        | DirectQuery               | Live Connection           | Direct Lake                   |
| -------------------- | ----------------------------- | ------------------------- | ------------------------- | ----------------------------- |
| Data stored in PBIX? | ✅ Yes                         | ❌ No                      | ❌ No                      | ❌ No (in OneLake)             |
| Data movement        | Copied into PBIX              | Queries sent to DB        | Queries sent to model     | Reads files directly          |
| Performance          | ✅ Very fast                   | ⚠️ Slower (depends on DB) | ✅ Depends on source model | ✅✅ Very fast                  |
| Data freshness       | ❌ Needs refresh               | ✅ Always up-to-date       | ✅ Always up-to-date       | ✅ Always up-to-date           |
| Max dataset size     | Limited (~1–10 GB in Service) | Unlimited                 | Unlimited                 | Practically unlimited         |
| Use case             | Small/medium static data      | Large DB, real-time       | Enterprise BI model       | Very large **lakehouse** data |