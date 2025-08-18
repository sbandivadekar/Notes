# ETL v/s ELT
| Feature                          | **ETL (Extract – Transform – Load)**                                                     | **ELT (Extract – Load – Transform)**                                                                                       |
| -------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Process Order**                | Data is extracted → transformed in **staging/ETL tool** → then loaded into DW            | Data is extracted → loaded into DW → transformed **inside the DW**                                                         |
| **Where Transformation Happens** | In an external **ETL engine/tool** (e.g., Informatica, Talend)                           | Inside the **target system (DW/DB)** (e.g., Snowflake, BigQuery, Redshift)                                                 |
| **Best For**                     | Traditional on-premise systems, small–medium data                                        | Modern cloud-based DWH handling **big data**                                                                               |
| **Performance**                  | Transformation happens **before load**, so DW gets clean data, but process can be slower | Faster load (raw data first), but transformations may be heavy on DW                                                       |
| **Storage Requirement**          | Needs extra staging storage for transformations                                          | Needs larger DW storage (raw + transformed data)                                                                           |
| **Flexibility**                  | Less flexible – transformations must be defined in ETL tool                              | More flexible – raw data is available, different transformations can be applied later                                      |
| **Tools / Tech**                 | Informatica, SSIS, Talend, DataStage                                                     | Snowflake, BigQuery, Azure Synapse, Redshift                                                                               |
| **Use Case Example**             | University loads cleaned admissions data into DW after transforming in staging           | University loads **all raw student, faculty, facilities data** into DW, and then uses SQL in DW to transform for analytics |

---
# ETL Loading Types
### **1. Initial (Full) ETL Load**

- **Definition:** Loading **all data from source systems** into the Data Warehouse for the very first time.
- **When Used:** At the start of a new data warehouse project or when a new table/data mart is created.
- **Process:**
    - Extract everything from the source (entire student, faculty, facility data).
    - Transform (clean, standardize).
    - Load into target warehouse.
- **Disadvantage:** Can be **time-consuming & resource-heavy** because it moves the full dataset.
### **2. Incremental ETL Load**

- **Definition:** Loading only the **new or changed data** since the last ETL run.
- **When Used:** For daily/weekly refresh after the initial load.
- **Process:**
    - Identify deltas (new students admitted today, grades updated, new classroom schedules).
    - Extract only those.
    - Transform & Load into DW.
- **Advantage:** Much **faster and efficient** than full load.
- **Challenge:** Needs good change tracking (timestamps, CDC – Change Data Capture, triggers).

---
# Role of **Data Transformation** in ETL

Data **transformation** is the **middle step** of ETL (Extract → **Transform** → Load).  
Its role is to **convert raw, inconsistent, and heterogeneous data** from multiple sources into a **clean, standardized, and meaningful format** that fits into the data warehouse model.
### Example in University Scenario

- **Extracted Data:**
    - Campus A stores grades as `A, B, C`
    - Campus B stores grades as `90–100, 80–89…`
- **Transformation:** Convert all to a single **GPA scale**.
- **Loaded Result:** Warehouse stores one consistent grading system for analysis.

## **Common Data Transformation Models**

### **1. Data Value Unification**

- **Meaning:** Standardize values that represent the same thing but are stored differently.
- **Example (University):**
    - Campus A stores gender as `M/F`
    - Campus B stores gender as `Male/Female`
    - **Unify →** store all as `Male / Female`

### **2. Data Type and Size Unification**
- **Meaning:** Convert columns to a common data type/size across systems.
- **Example:**
    - `Date` stored as `VARCHAR` in Campus A and as `DATE` in Campus B
    - **Unify →** convert both to `DATE` type in the DW.
    - Student_ID may be `INT(4)` in one system and `INT(8)` in another → standardize.

### **3. De-duplication**
- **Meaning:** Remove duplicate records.
- **Example:**
    - Same student applied on two campuses with the same details → keep one unique record in the DW.

### **4. Dropping Columns (Vertical Slicing)**
- **Meaning:** Remove unnecessary attributes not needed in the DW.
- **Example:**
    - Source system has a column `Temp_Password` for students → not needed in analytics → drop it.

### **5. Value-based Row Filtering (Horizontal Slicing)**
- **Meaning:** Load only relevant rows based on conditions.
- **Example:**
    - Only include **active students** in reporting, exclude those with `Status = Withdrawn`.

### **6. Correcting Known Errors**
- **Meaning:** Fix common, predictable mistakes in source data.
- **Example:**
    - If `Grade = 105` (beyond valid range), correct it to `100`.        
    - If `Campus Code` is missing, fill with default.

---
## What is **Mix & Match Incremental ETL**?

👉 It’s a **hybrid loading strategy** where:
- **Some tables** are always fully refreshed (full load).
- **Some tables** are updated incrementally (only changes are loaded).

This approach is chosen based on **table size, change frequency, and business rules**.

