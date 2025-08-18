# 🌟 Incremental ETL for Dimension Tables

### 1. **Data Preparation**
- Get only the **new or updated records** from source systems (using timestamps, CDC, or audit columns).

- Example: Only pick students whose data changed since yesterday.
### 2. **Data Transformation**
- Clean and standardize the extracted records.

- Example: Fix inconsistent program names ("CS", "CompSci" → "Computer Science").
- Ensure formats (dates, names, IDs) match warehouse rules. 
### 3. **Process New Dimension Rows**
- If a student (or faculty, product, etc.) is **new**, insert a brand-new row into the dimension table.
- Assign a **surrogate key** for the new record.

- Example: A new student “Alice Brown” gets Student_Key = 1050.
### 4. **Process SCD Type 1 (Overwrite Updates)**
- If an attribute changes and we don’t need history → simply overwrite.

- Example: Correcting a misspelled name “Jhon” → “John”.
- No extra row is added, just update the existing row.
### 5. **Process SCD Type 2 (Track History)**
- If a change needs historical tracking → add a **new row** for the changed data.
- Update the **old row** with an expiry date (`Expiry_Date = yesterday`, Current_Flag = N).
- Insert the **new row** with today’s date as `Effective_Date` and Current_Flag = Y.

- Example: Student changes program from _Physics_ → _Computer Science_.
    - Old row (Physics) marked expired.
    - New row (CS) added with new surrogate key.

> Process of dimension table can happen in parallel and fact table processing can happen on parallel but once all the dimension table is created then only building of fact table starts.