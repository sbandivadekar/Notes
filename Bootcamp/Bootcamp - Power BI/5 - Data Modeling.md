## ⭐ What is a **Star Schema**?

A **Star Schema** is a way of organizing data for reporting and analytics.

- It has a **central fact table** (numbers, transactions, measures).
- It has **dimension tables** (descriptive info, categories, attributes).
- When drawn, the fact table sits in the middle and dimensions surround it like a star ✨.

---
## 🔹 Components

### 1. **Fact Table**
- Stores **business events/transactions**.
- Contains **numeric values (measures)** like: Sales, Quantity, Revenue, Profit.
- Contains **foreign keys** linking to dimensions.
### 2. **Dimension Tables**
- Store **descriptive details** about entities.
- Help you slice and dice the fact data.
- Example:
    - **DimDate** → Year, Month, Quarter

---
# Why Star Schema is Important?

1. **Performance** → Fast queries (facts are compact, dimensions are smaller).
2. **Simplicity** → Easy for analysts to understand ("Sales by Product by Region").
3. **Best practice in Power BI** → Star schema avoids relationship loops, simplifies DAX, and improves performance.
4. **Flexibility** → Dimensions can be reused across reports (e.g., same Date table works with multiple facts).

---
# 🔹 Star Schema vs Snowflake Schema

- **Star Schema** → Dimensions are denormalized (flattened, fewer joins).
- **Snowflake Schema** → Dimensions are normalized (split into multiple related tables).    
    - Example: In Snowflake, `Product` might link to `Category` and then to `Department`.
    - Star Schema usually performs better in BI tools.
 
✅ **Summary**:  
A **Star Schema** = **1 Fact Table + Multiple DimensionTables**.  It’s the recommended design for Power BI & modern analytics because it’s fast, clean, and user-friendly.

---
# 🔹 What is Cardinality?
Cardinality defines the **relationship type** between two tables — how many rows from one table can relate to how many rows in another table.

## 🔹 Types of Cardinality

### 1. **One-to-One (1:1)**
- Each row in Table A relates to exactly one row in Table B.
- Example: Employee ↔ EmployeeBadge.
- Rare in reporting, often indicates you could **merge both tables** into one.

### 2. **One-to-Many (1:_), or Many-to-One (_:1)**
- **Most common in Star Schema**.
- One row in a **dimension table** relates to many rows in the **fact table**.
- Example:
    - One Customer → Many Orders
    - One Product → Many Sales Transactions

👉 Power BI shows this as **1 → * relationship** (dimension → fact).

### 3. **Many-to-Many (_:_)**
- Rows in Table A relate to multiple rows in Table B, and vice versa.
- Example:
    - Students ↔ Courses (a student can enroll in many courses, a course has many students).
    - Sales ↔ Promotions (a sale can have multiple promotions applied).

👉 In Power BI, this is tricky — can create **ambiguous results**, **duplicate aggregations**, and **performance issues**. Usually avoided unless absolutely needed.

### **Why to avoid M:M**
- Takes lot of time for processing query as duplication values will create lot of data.
- may lead to wrong results for DAX as there will be duplicates values and no uniqueness in the related tables. 

### 🔹 Now (After July 2018 Update)

Power BI **directly supports many-to-many relationships** using a new relationship type called **"many-to-many cardinality"**.

👉 How it works:
- You can connect two tables without having a unique key column on either side.
- It internally creates a **virtual relationship** and uses DAX functions like `CROSSFILTER()` to control the filtering direction.
- Useful when dimensions don’t have unique values (like `ProductCategory` coming from two different systems).

---
# 🔹 Best Practices

1. ✅ **Prefer One-to-Many (1:*) relationships**    
    - Dimension tables (unique keys) on the **"one" side**.
    - Fact tables (transactions) on the **"many" side**.
2. 🚫 **Avoid Many-to-Many** unless required
    - Leads to **ambiguous results**.
    - If needed, resolve with a **bridge table** (junction table).
    - Example: For Student-Course, create an Enrollment table (fact).
3. 🚫 **Avoid One-to-One** unless modeling special cases
    - Usually signals unnecessary table splitting.
    - Better to merge the tables into one dimension/fact.
4. ✅ **Always use surrogate keys (like CustomerKey, ProductKey)**
    - Ensure uniqueness on the "one" side.
    - Prevent duplicate/mismatched relationships.

✅ **Summary**:

- **Most used** = **One-to-Many (1:*)** because it’s clean, supports star schema, and avoids ambiguity.
- **Many-to-Many** → Avoid, use only with bridge tables.
- **One-to-One** → Rare, usually merge tables.

---
# 🔹 What is Cross Filter Direction?

When you create a **relationship** between two tables, Power BI must decide **how filters flow** between them.  
This is called **Cross Filter Direction**.
## 🔹 Types of Cross Filter Directions

### 1. **Single Direction (Default)** ✅
- Filters flow **only one way** — from the **“one” side → many side**.
- Typical in **Star Schema** (Dimension → Fact).
- Example:
    - Filtering **Customer (India)** → shows only related **Orders**.
    - Filtering **Orders** → does NOT filter Customers.

👉 This is the **best practice** because it keeps the model simple and avoids ambiguity.


### 2. **Both Directions (Bi-directional)** ⚠️
- Filters flow **both ways**.
- Example:
    - Filtering **Customer** filters **Orders**.
    - Filtering **Orders** filters **Customer**.
- Useful for:
    - **Many-to-Many relationships** (via bridge tables).
    - Situations where you want slicers from either table to work both ways.

⚠️ **Risks:**

- Can cause **circular dependencies** (loops).
- Can lead to **ambiguous results** in DAX.
- May slow down performance on large models.

### **Best Practices**

1. ✅ **Use Single Direction** wherever possible (especially in Star Schema).
2. ✅ Use **Bi-directional only when needed**, like:
    - Many-to-Many relationships.
    - Complex reporting scenarios where filters must propagate in both directions.
3. 🚫 Don’t blindly turn everything bi-directional — it often signals **modeling issues**.

## 🔹 Example

Imagine **Customer** → **Sales**:
- *_Single-direction (1 → _)__
    - Customer slicer filters Sales.
    - Sales slicer does not filter Customers.
- **Bi-directional (↔)**
    - Customer slicer filters Sales.
    - Sales slicer also filters Customers.


✅ **Summary**:
- **Single-direction** = Best practice, clean star schema, avoids ambiguity.
- **Bi-directional** = Use sparingly, only when business logic requires both-way filtering.

---
# 🔹 What is RLS?

**Row Level Security (RLS)** restricts access to data at the **row level**, so users only see the data they are allowed to.

- **Static RLS** → Fixed filter rules (hardcoded).
- **Dynamic RLS** → Rules change depending on the logged-in user.

### **Best Practices for Static RLS**

1. ✅ Apply RLS on **dimension tables** (e.g., Country, Department), not fact tables → better performance.
    
2. ✅ Keep roles simple (too many roles can be hard to maintain).
    
3. ✅ Use **groups in Power BI Service** instead of assigning individual users → easier management.
    
4. 🚫 Avoid mixing Static & Dynamic RLS unless absolutely required (can get confusing).

---
# 🔹 Calculated Columns

- **Definition**: A new column added to a table, created with a DAX expression.
- **Evaluated row by row** (row context).
- **Stored in the model** (increases size).

```DAX
Profit = Sales[SalesAmount] - Sales[Cost]
```

Now every row in **Sales** table has a Profit value.

✅ **When to use**:
- Need row-level calculations.
- Need to create relationships or categories (e.g., AgeGroup, Segment).

🚫 **Avoid for aggregations** (better with measures).

---
# 🔹 Measures

- **Definition**: A calculation evaluated at query time (not stored).
- **Depends on filters and context**.
- More **efficient** and best for aggregations.

```DAX
Total Sales = SUM(Sales[SalesAmount])
```

✅ **When to use**:

- Aggregations (SUM, AVERAGE, COUNT, etc.).
- KPIs, ratios, percentages.
- Always preferable over calculated columns for aggregations.

|Feature|Calculated Column|Measure|
|---|---|---|
|**Storage**|Stored in model|Not stored|
|**Performance**|Slower (increases model size)|Faster|
|**Context**|Row Context|Filter/Query Context|
|**Use Case**|Categories, relationships|Aggregations, KPIs|

---
# 🔹Calculation Groups

### **Problem Without Calculation Groups**

Imagine you have a **Total Sales** measure:

```DAX
Total Sales = SUM(Sales[SalesAmount])
```

Now your boss asks:

- Show **Total Sales YTD**
- Show **Total Sales MTD**
- Show **Total Sales QTD**
- Show **Total Sales PY (previous year)**

👉 Normally, you’d create **4 more measures**:

```DAX
Sales YTD = CALCULATE([Total Sales], DATESYTD('Date'[Date]))
Sales MTD = CALCULATE([Total Sales], DATESMTD('Date'[Date]))
Sales QTD = CALCULATE([Total Sales], DATESQTD('Date'[Date]))
Sales PY  = CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Date'[Date]))
```

That’s already **5 measures** (1 base + 4 time versions).  
If you also want these for **Profit** and **Quantity**, you’ll end up with **15+ measures** 😩.

### **With Calculation Group**

A **calculation group** lets you create just **one set of logic** and reuse it across measures.

1. **Create a Calculation Group** (using Tabular Editor).  
	Name it: `Time Intelligence`.
	
2. **Add Calculation Items** (like rows in a virtual table):
	- YTD → `CALCULATE(SELECTEDMEASURE(), DATESYTD('Date'[Date]))`
	- MTD → `CALCULATE(SELECTEDMEASURE(), DATESMTD('Date'[Date]))`
	- QTD → `CALCULATE(SELECTEDMEASURE(), DATESQTD('Date'[Date]))`
	- PY → `CALCULATE(SELECTEDMEASURE(), SAMEPERIODLASTYEAR('Date'[Date]))`

👉 Here, `SELECTEDMEASURE()` means “whatever base measure you’re using” (Sales, Profit, Quantity, etc.).

3. **Use in Report**
	- Create a table with:
	    - Measure: `[Total Sales]`
	    - Field: `Time Intelligence[Name]` (the calculation group items).

You’ll see output like:

| Time Intelligence | Total Sales |
| ----------------- | ----------- |
| YTD               | 1,200,000   |
| MTD               | 300,000     |
| QTD               | 450,000     |
| PY                | 1,100,000   |
And the same group works automatically for **Profit, Quantity, etc.** 🎉

✅ **Summary in Simple Words**:  
A **Calculation Group** is like a **menu of reusable formulas** (YTD, MTD, PY, etc.) that you can apply to any measure (Sales, Profit, Quantity) without writing those formulas again and again.

---
# 🔹 What is an Active Relationship?

An **active relationship** is the **default connection** Power BI uses to filter and aggregate data between two tables.

- Shown as a **solid line** in **Model view**.
- Only **one active relationship** can exist between two tables at a time.
- When you drag fields into visuals, Power BI automatically uses the **active relationship**
### **Example**
Imagine you have:
- **Sales Table** (fact) → contains `OrderDate` and `ShipDate`.
- **Date Table** (dimension).
    
Relationships:

- `Sales[OrderDate]` → `Date[Date]` ✅ (active, solid line).
- `Sales[ShipDate]` → `Date[Date]` ⚪ (inactive, dotted line).

👉 By default, if you build a report with **Sales by Date**, Power BI will use the **OrderDate (active relationship)**.

If you want to analyze by **ShipDate**, you must explicitly activate that **inactive relationship** using `USERELATIONSHIP()`.

---
# 🔹 What are Inactive Relationships?

In Power BI, when you build a data model, sometimes **two tables can be related in more than one way**.
- Power BI allows only **one active relationship** at a time between two tables.
- The other(s) must remain **inactive**.

👉 An **inactive relationship** is shown as a **dotted line** in the Model view.  
👉 An **active relationship** is shown as a **solid line**.

### **Example**

Suppose we have:
- **Sales Table** (Fact)
- **Date Table** (Dimension)

In Sales, there are two date fields:
- `OrderDate`
- `ShipDate`

You want to relate both to the **Date Table**.
- Relationship 1: `Sales[OrderDate]` → `Date[Date]` ✅ (active)
- Relationship 2: `Sales[ShipDate]` → `Date[Date]` ⚪ (inactive)

Only one can be **active** at a time → usually, you choose `OrderDate` as active.

### **How to Use Inactive Relationships?**
Even though the `ShipDate` relationship is **inactive**, you can **activate it temporarily in a measure** using **DAX’s `USERELATIONSHIP()`** function.

### **Best Practices**

1. ✅ **Have only one active relationship** between two tables → keeps the model clean.
    
2. ✅ Use **inactive relationships + USERELATIONSHIP()** when multiple date fields exist (OrderDate, ShipDate, DueDate).
    
3. ✅ Mark one **Date Table as a proper Date Table** in Power BI → enables time intelligence functions.
    
4. 🚫 Don’t force multiple active relationships (not possible in Power BI). If you need multiple, use inactive + measures.

✅ **Summary**:
- Power BI allows only **1 active relationship** between two tables.
- The other(s) are **inactive** (dotted line).
- Use **`USERELATIONSHIP()` inside `CALCULATE()`** to activate them in measures when needed.
- Common use case: Multiple date fields (OrderDate, ShipDate, DueDate).