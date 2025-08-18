
# Topics:

- Introduction to Agile process and JIRA boards.
- Introduction to Data Warehousing
- Overview of Snowflake
- Snowflake Architecture
- Setting up a Snowflake account
- Basic Snowflake operations: Data loading, unloading, and querying
- Hands-on lab: Basic operations in Snowflake

---

# Agile Process
It is a software deployment management frame where App is build in smaller chunk (like function by function) and after each function is build getting feedback from the customer and work on the other function and this process goes on till the end the final App is deployed. It is more flexible and can easily make changes to the plan. It is cost friendly as well.

---
# JIRA boards
**Jira** is a software tool made by Atlassian that teams use to **plan, track, and manage work** especially in Agile projects.

Think of it like a **digital whiteboard + to-do list** for the whole team, where you can:

- Create **tasks** (called issues in Jira)
- Assign them to people
- Track progress (e.g., _To Do → In Progress → Done_)
- See timelines, priorities, and who’s working on what
- Generate reports (like how fast the team is completing work)

---
# Introduction to Data Warehousing
A **data warehouse** is a big **storage system** where a company keeps **all its important data** from different sources in one place, so it can be analyzed easily for decision-making.

>In Short - DW stores data from different sources, in a proper and consistent way, for analysis. DB stores current operational data, mainly for day-to-day transactions.

### **Example**

Imagine you run a chain of **coffee shops**:

- Sales data comes from cash registers.
- Customer loyalty info comes from the app.
- Inventory data comes from suppliers.

Right now, all this data is in different systems — like separate boxes in different rooms.  
A **data warehouse** will:

1. **Gather** all that data into one central database.
2. **Clean it up** (make sure dates, currency, names are consistent).
3. **Organize it** so you can easily run queries like:
    - “Which city sold the most cappuccinos last month?”
    - “Which customers visit most often?”

---
# Overview of Snowflake
Snowflake is cloud based Data warehouse platform. Where companies can store large amount of data, analyze the data with managing the Hardware.

> Think of it as a **“data warehouse as a service”** — you just upload your data, and Snowflake handles the storage, organization, and processing for you.

### **Example**

Let’s say you run a **food delivery app** and collect:

- Orders data (from app)
- Customer data (from CRM)
- Marketing data (from Facebook Ads, Google Ads)
- Driver performance data

Normally, this data is scattered across different systems.  
With **Snowflake**, you can:

1. **Load** all that data into Snowflake from different sources.
2. **Clean and organize** it in one place.
3. **Run analysis** like:
    - Which city orders the most food at night?
    - Which marketing campaign brings the most loyal customers?
4. **Share** data securely with partners without sending actual files.

---
# Snowflake Architecture

![[Pasted image 20250811113751.png]]

#### **There are 3 Layers**
- **Storage Layer** – Stores all data in a compressed, encrypted format in the cloud (separate from compute).
- **Compute Layer** – Virtual Warehouses process queries; multiple warehouses can work on the same data without conflict.
- **Cloud Services Layer** – Coordinates everything: authentication, query parsing, optimization, metadata, and access control.
### **Traditional Architecture**
1. **Shared Disk Architecture**
	- Here Centralized storage is used.
2. **Nothing Shared**
	- Here For each node there will be sperate storage.

> Snowflake uses combination of both traditional architecture.
### **virtual warehouses**
It comes in size just like t-shirt (XS to XL, 2XL,3XL, 4XL).

![[Pasted image 20250811114604.png]]

### **Virtual Warehouses types**

1. **Standard**
	- Which has only one cluster and cannot scale out.
2. **Multi-Cluster Warehouse**
	- cluster scale out for concurrency needs.
### **Roles in snowflake**
- **SYSADMIN** → Creates and manages databases, schemas, and objects (tables, views, etc.).
- **USERADMIN** → Creates and manages users and roles.
- **SECURITYADMIN** → Manages security-related stuff like granting/revoking privileges.
- **ACCOUNTADMIN** → _Super boss_ — full control of the entire account (includes billing, global settings).
- **PUBLIC** → Default role everyone gets; has very limited access.
- **CUSTOM ROLES** → You can make your own with specific permissions for a team/project.

---
# Tables in Snowflake
#### **1. Permanent Table** 🏛
- Default table type.
- Stores data permanently until you delete it.
- Best for production data.
- Example: `CREATE TABLE sales (...);`
#### **2. Temporary Table** ⏳
- Exists only for your current session.
- Disappears automatically when you log out/close session.
- Good for short-term calculations or testing.
#### **3. Transient Table** 📦
  - Stays until you drop it, but **no fail-safe** (can’t recover after 1-day retention).
  - Cheaper storage, used for staging or intermediate data.
#### **4. External Table** 🌐
- Points to data stored outside Snowflake (like AWS S3, Azure Blob).
- Lets you query external files without loading them in.

---
# Recovery & fail safe in snowflake
#####  **1. Retention Time** ⏳
- The time period Snowflake keeps **historical data** (old versions of rows, dropped tables, etc.).
- Controls how far back you can use **Time Travel**.
- Example: Retention time = 1 day → you can recover yesterday’s data.
##### **2. Time Travel** 🔍
- Feature that lets you **query, clone, or restore** data from the past — within the retention time.
- Great for fixing mistakes (like accidental deletes or overwrites).
- Syntax example:

>SELECT * FROM my_table AT(TIMESTAMP => '2025-08-10 15:00:00');

##### **3. Fail-safe** 🛡
- Extra **7-day recovery period** _after_ retention time expires.
- **Only Snowflake** can restore data during this period (you can’t directly query it).
- Intended for emergencies, not regular backups.