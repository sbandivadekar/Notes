
# Transformation function during loading and unloading
### ✅ Allowed in `COPY INTO` transformations

- **Column reordering** → change column order.
- **Column removal/subset** → select only needed cols.
- **Cast/truncate** → change data types or shorten length.
- **Basic SQL functions** → `SUBSTR`, `TRIM`, `UPPER`, `TO_DATE`, `ROUND`, `COALESCE`.
- **Filters/expressions** → `WHERE`, simple calculations, string concat.
---
# Functions
##  **1. Scalar Functions**
- Operate on **one row at a time**.
- Return a **single value per row**.
- Examples:
    - String: `UPPER()`, `SUBSTR()`, `TRIM()`
    - Numeric: `ROUND()`, `ABS()`
    - Date/Time: `CURRENT_DATE()`, `DATEADD()`
##  **2. Aggregate Functions**
- Operate on **multiple rows**.
- Return **one result for the group/set**.
- Examples: `SUM()`, `COUNT()`, `AVG()`, `MIN()`, `MAX()`
## **3. Window Functions (Analytic)**
- Similar to aggregates, but work **over a defined window/partition of rows** while still returning a value **for each row**.
- Examples:
    - Ranking: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`
    - Analytics: `LAG()`, `LEAD()`, `NTILE()`, `SUM() OVER(...)`
## **4. Table Functions**
- Return a **set of rows** (like a virtual table).
- Used in the `FROM` clause.
- Examples:
    - `FLATTEN()` (expands semi-structured data like JSON/ARRAY).
    - `SPLIT_TO_TABLE()`.
## **5. System Functions**
- Provide info about Snowflake environment, metadata, or session. 
- Examples:
    - `CURRENT_USER()`, `CURRENT_ROLE()`, `CURRENT_TIMESTAMP()`.
    - `SYSTEM$WAIT()`, `SYSTEM$STREAM_HAS_DATA()`.
## **6. UDF (User-Defined Functions)**
- Functions you create yourself in SQL/JavaScript/Java/Python.
- Extend Snowflake with **custom logic**.
## **7. External Functions**
- Let you call **external services/APIs** from Snowflake.
- Example: calling a REST API for currency conversion inside SQL.
- Requires **API integration**.

|Function Type|Returns|Works On|Example|
|---|---|---|---|
|Scalar|Single value|One row|`UPPER(name)`|
|Aggregate|Single value|Many rows|`AVG(salary)`|
|Window|Value per row|Partition/window of rows|`ROW_NUMBER() OVER(...)`|
|Table|Set of rows|Input table/array|`FLATTEN(json_col)`|
|System|Value/meta info|Session/system|`CURRENT_USER()`|
|UDF|Custom value|Defined by user|`my_func(10)`|
|External Function|Value (from API)|External service|API call|

