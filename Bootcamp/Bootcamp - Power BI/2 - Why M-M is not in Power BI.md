# Many-to-Many and Concatenated Keys in Power BI

## 🔹 Problem: Many-to-Many

In a **Many-to-Many (M:M)** situation, neither side has a unique key.


| Cust_Id | Customer |
| ------- | -------- |
| 1       | A        |
| 2       | B        |
Customer Table


| Pro_Id | Product |
| ------ | ------- |
| 10     | keyword |
| 20     | mouse   |
Product Table

| cust_Id | Pro_Id | amt | uni  |
| ------- | ------ | --- | ---- |
| 1       | 10     | 200 | 1-10 |
| 1       | 20     | 300 | 1-20 |
| 2       | 10     | 200 | 2-10 |
Sales (Fact Table)
## Issue here is 
- One customer can buy many products
- One product can be bought by many customers
- Direct Customer ↔ Product creates **M:M relationship** → Power BI gives wrong results.
### 🔹 Correct Connection (Star Schema)
In Power BI **Model view**:
- Connect `Customer[CustomerID]` → `Sales[CustomerID]`
- Connect `Product[ProductID]` → `Sales[ProductID]`

Now when you build visuals:
- Show Sales by Customer → it sums correctly from Sales
- Show Sales by Product → it sums correctly
- Show Customer × Product matrix → works fine ✅

### 🔹 Wrong Connection (Direct Many-to-Many)

If you **skip the Sales table** and connect:
- `Customer[CustomerID]` ↔ `Product[ProductID]`

👉 Problem:
- CustomerID values are **1, 2**
- ProductID values are **10, 20**
- They don’t match at all!
- Power BI has no way to know: _“Which customer bought which product?”_
- Results will show blanks or wrong totals.

### 🔹 Simple Analogy

Think of **Sales** as the “linking table” (like a receipt).
- Without the receipt, you can’t prove who bought what.
- If you connect Customer directly to Product, it’s like saying:  
    _“Every customer is connected to every product”_ → wrong and confusing.