# 🔹 What is DAX?

- **DAX = Data Analysis Expressions**
- It’s a **formula language** in Power BI (also used in Excel Power Pivot, SSAS).
- Used to create **measures**, **calculated columns**, and **calculated tables**.
- Works on data **after it’s loaded into the model**.

---
# 🔹 Where do we use DAX?

1. **Calculated Columns** → Adds new column in your table.  
    Example: Full Name = `FirstName & " " & LastName`
2. **Measures** → Calculations used in visuals (aggregation like SUM, AVERAGE, etc.).  
    Example: Total Sales = `SUM(Sales[SalesAmount])`
3. **Calculated Tables** → Creates a new table from existing tables.  
    Example: `Sales_2024 = FILTER(Sales, Sales[Year] = 2024)`

---
# 🔹 Basic DAX Functions (must-know)

### 1. **Aggregation Functions**

- `SUM(Sales[SalesAmount])` → Adds all sales.
- `AVERAGE(Sales[SalesAmount])` → Finds average sales.
- `COUNT(Customer[CustomerID])` → Counts rows.
- `MAX(Sales[SalesAmount])` → Highest sale.
- `MIN(Sales[SalesAmount])` → Lowest sale.

### 2. **FILTER Functions**

- `CALCULATE(SUM(Sales[SalesAmount]), Sales[Year] = 2024)`  
    👉 Changes the filter context to only year 2024.
- `FILTER(Sales, Sales[Region] = "East")`  
    👉 Returns a table with only East region sales.

### 3. **Time Intelligence Functions** (very important for trends)

- `TOTALYTD(SUM(Sales[SalesAmount]), Date[Date])` → Year-to-Date sales.
- `SAMEPERIODLASTYEAR(Date[Date])` → Shifts date to last year.
- `DATEADD(Date[Date], -1, MONTH)` → Previous month

### 4. **Logical Functions**

- `IF(Sales[SalesAmount] > 1000, "High", "Low")`  
    👉 Classifies sales as High or Low.    
- `SWITCH(MONTH(Date[Date]), 1, "Jan", 2, "Feb", ..., "Dec")`  
    👉 Converts month numbers into names.

---
# 🔹 Learning Path

1. Start with **basic aggregations** → SUM, COUNT, AVERAGE.
2. Learn **CALCULATE** (the most powerful DAX function).
3. Explore **time intelligence** (YTD, MTD, previous year).
4. Practice building measures for **KPIs (Sales, Profit, Growth, % Change)**.

---
# Calculated v/s Measure

|Feature|Calculated Column|Measure|
|---|---|---|
|Storage|Stored in model (takes space)|No storage (calculated on demand)|
|Row vs Filter Context|Row by row (row context)|Aggregates depending on filters (filter context)|
|Performance|Slower for large data (uses memory)|Faster, lightweight|
|Use cases|Derived fields needed in model (e.g., Profit per row, Category flag)|KPIs, totals, averages, % growth, etc.|
|Example|Profit = Sales - Cost|Total Sales = SUM(Sales[SalesAmount])|

# 🔹 Rule of Thumb

- Use **Measures** for almost everything (performance + flexibility).
- Use **Calculated Columns** only when you need the result **for every row** and it must be stored (like creating a key, classification, or join condition).