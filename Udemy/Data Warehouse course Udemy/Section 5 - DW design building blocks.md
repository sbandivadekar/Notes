# What is Dimensional Context?

> Fact = numerical business data.

In **data warehousing**, the **dimensional context** means looking at data in terms of **facts (measurable events)** and the **dimensions (descriptive attributes)** that give meaning to those facts.

It’s basically the **framework** that allows analysts to answer business questions.

#### **Example: Tuition Payment**
- **Fact (event):** A student pays tuition of **$10,000**.    
- **Dimensions (context that describes the fact):**    
    - **Student Dimension** → John Smith, Full-time, Good standing        
    - **Campus Dimension** → Main Campus, State University        
    - **Date Dimension** → 15-Aug-2025, Fall Semester
    - **Payment Method Dimension** → Credit Card

Here, the **fact ($10,000 payment)** only makes sense when you put it in the **dimensional context** (Who paid? At which campus? When? Using what method?).

## **“By” and “For” in Dimensional Context**

When we analyze data in a **data warehouse (DW)**, we usually phrase business questions in terms of:
- **Facts (what we’re measuring)**
- **Dimensions (how we want to look at it)**
And that’s where **“by”** and **“for”** come in:
### **“By” → Grouping Dimension**
- Means **break down the fact according to a dimension**.    
- Example: _“Total tuition **by campus**”_    
    - Fact = Tuition Amount        
    - Dimension (By) = Campus
### **“For” → Filtering Dimension**
- Means **restrict or filter the analysis to a certain dimension value**.    
- Example: _“Total tuition **for Fall 2025**”_    
    - Fact = Tuition Amount        
    - Dimension (For) = Date (Fall 2025 semester)

**NOTE**
> Fact = Measurements (usually numeric like salary, distance).
> Dimension = context for fact.

---
# Fact Table

- A **fact table** stores the **measurable, quantitative data** of the business.    
- It answers: **“What happened?”**    
- Usually contains **numeric values (measures)** like revenue, sales, counts, GPA, tuition amount.    
- Always linked to **dimension tables** using foreign keys.

Example (Fact_Student_Enrollment):

| Student_Key | Course_Key | Campus_Key | Date_Key | Credits_Taken | Tuition_Amount |
| ----------- | ---------- | ---------- | -------- | ------------- | -------------- |
| 101         | 501        | 10         | 20250815 | 3             | 1500           |
| 102         | 502        | 12         | 20250815 | 4             | 2000           |

# Dimension Table

- A **dimension table** stores **descriptive, textual, categorical information** that gives **context** to the facts.    
- It answers: **“Who, What, Where, When, How?”**    
- Usually contains attributes like names, categories, descriptions.    

**Examples:**
**Dim_Student**

| Student_Key | Name       | Status    | Academic_Status |
| ----------- | ---------- | --------- | --------------- |
| 101         | John Smith | Full-time | Good standing   |
| 102         | Mary Lee   | Part-time | Probation       |

---
# Additivity in Facts
In a **fact table**, measures (numeric values) can behave differently when you **aggregate (sum up) across dimensions**.

## **Types of Additivity**
###  **1. Additive Facts**
- Can be summed up across **all dimensions**.
- Example:
	- **Tuition Amount** → You can sum tuition **by student**, **by campus**, **by semester**, etc.
	- $10,000 (Main Campus) + $12,000 (North Campus) = $22,000 Total.
            
### **2. Semi-Additive Facts**
- Can be summed up across **some dimensions**, but **not all**.
- Example:
	- **Account Balance** → You can sum balances **across students** at a point in time, but you **cannot sum over time** (because balance is already a point-in-time snapshot).
### **3. Non-Additive Facts**
- Cannot be summed up across any dimensions.
- Example:
	- **GPA (Grade Point Average)** → Adding GPAs of students doesn’t make sense.    
	- Instead, you calculate an **average**, **min**, or **max**.

---
# What is a Star Schema?

A **Star Schema** is the **simplest and most common data warehouse schema**.

- It organizes data into **fact tables** (numbers) and **dimension tables** (context).
- The structure looks like a **star**:
    - The **fact table** is in the **center**.
    - The **dimension tables** surround it like the points of a star.

# What is a Snowflake Schema?

- A **Snowflake Schema** is a **more normalized form** of the **Star Schema**.    
- In this model, **dimension tables are split into multiple related tables** to reduce redundancy.
- The structure looks like a **snowflake** because dimensions branch out into sub-dimensions.

|Feature|**Star Schema ⭐**|**Snowflake Schema ❄️**|
|---|---|---|
|**Structure**|Fact table in center, dimension tables directly connected|Fact table in center, dimensions split into multiple related sub-dimensions|
|**Design Style**|Denormalized|Normalized|
|**Storage**|More storage (duplicate data in dimensions)|Less storage (reduces redundancy)|
|**Query Performance**|Faster (fewer joins)|Slower (more joins)|
|**Ease of Use**|Simple and easy for reporting|More complex to understand|
|**Best For**|Dashboards, OLAP, quick analytics|Large, complex data warehouses with storage optimization needs|

---
# Database keys in data warehouse
### **Primary Key (PK)**
- A **unique identifier** for each record in a table.
- Ensures **no duplicates** in the table.
- In **dimension tables**, the **Primary Key** is usually a **Surrogate Key**.
### **Foreign Key (FK)**
- A field in one table that **links to the Primary Key** of another table.
- Creates a **relationship between Fact and Dimension tables**.
### **Natural Key**
- A key that comes directly from the source system (like Student_ID, SSN, Email).
- Not always reliable in DW (different systems may use different formats).
### **Surrogate Key**
- An **artificial/auto-generated key** (usually an integer) used instead of natural keys.
- Ensures consistency across multiple source systems.
- Common in **dimension tables**.

**Example:**
- Student_ID from one system = "S123", another system = "STU-456".
- Create a **Surrogate Key (e.g., 101)** in DW to unify them.


