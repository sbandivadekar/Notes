# Centralized Data Warehouse
A **Centralized Data Warehouse** is a single, unified storage system where **all organizational data** from different sources is collected, integrated, and stored in one location for analysis.

---
# Data marts
A **Data Mart** is a **smaller, specialized section of a Data Warehouse** that’s designed for a specific business area, team, or purpose.

> It's a end point for the end user.

### **Example**
A central DWH has all company data.
- **Sales Data Mart** → only sales transactions, customer info, revenue metrics.
- **HR Data Mart** → only employee records, payroll, attendance.

### **Types of data marts**
### **1. Dependent Data Mart** 🛠
- **Built from a central Data Warehouse** (DWH).
- Gets **cleaned, transformed, and integrated** data from the DWH.
### **2. Independent Data Mart** 🏝
- Created **without a central DWH** — gets data directly from source systems.
- Faster to build but can cause **data silos** and inconsistencies.

### **3. Hybrid Data Mart** 🔄
- Combines data from the **central DWH** and **other sources**.
- Useful when some data is in the warehouse, and some is in external systems.

| **Data Warehouse**           | **Independent Data Mart**    |
| ---------------------------- | ---------------------------- |
| Many sources                 | one or multiple sources      |
| ETL from sources             | ETL from sources             |
| Probably large volume        | Possibly large volume        |
| Dimensionally organized data | Dimensionally organized data |

---
# Data warehouse Architecture
There are 2 architecture
1. Centralized
2. Component based.

|Aspect|Centralized 🏛|Component-Based 🧩|
|---|---|---|
|**Data Storage**|One large repository|Multiple smaller stores|
|**Data Consistency**|Very high|Depends on integration|
|**Scalability**|Vertical scaling|Easier horizontal scaling|
|**Speed to Build**|Slower|Faster for each part|
|**Governance**|Easier|More complex|
|**Best For**|Enterprise-wide, consistent analytics|Large orgs with varied, independent departments|
![[Pasted image 20250812121417.png]]

---
# Cubes - multi dimensional DB
A **Cube** in a **Multidimensional Database (MDDB)** is a way of storing and organizing data so it can be analyzed **across multiple dimensions** quickly
Data isn’t just in rows and columns — it’s arranged in **dimensions** (like _Product_, _Time_, _Region_).

### **Example**
Let’s say you want to analyze **sales**:

**Dimensions**:
- Time (Year, Month, Day)
- Product (Category, Item)
- Region (Country, City)

---
# ODS
An **ODS** is like a **staging+reporting area** where fresh, real-time or near-real-time data from operational systems is stored **before** it goes into the Data Warehouse.

---
# Staging Layer in Data warehouse
The **staging layer** in a **data warehouse** plays a very important role in the **ETL (Extract, Transform, Load)** process.  
It acts as a **temporary storage area** where raw data from multiple source systems is first collected before being cleaned, transformed, and loaded into the warehouse.

### **Types of staging layer**
#### **1. Non-Persistent**
- Data is **temporary** and is **deleted after loading** into the warehouse.
- Saves storage space and is faster since it only acts as a short-term buffer.
- Usually used when:
    - Source systems are reliable.
    - Reprocessing is not often needed.

**Example:**  
Daily transactional data is extracted, transformed, and loaded to the DWH. After successful load, the staging data is **dropped** automatically.

#### **Persistent**
- Data **remains stored** in the staging layer even after it has been loaded into the warehouse.
- Useful when you want to keep a **history of raw data** for auditing, reprocessing, or recovery.
- Can be queried if you need to re-run ETL or debug issues.

**Example:**  
If a sales file was corrupted and wrong data was loaded, you can reload the correct version from the **persistent staging area** without going back to the source system.