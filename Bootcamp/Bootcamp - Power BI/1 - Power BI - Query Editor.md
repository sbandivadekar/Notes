## 1. Loading Data into Power BI

Power BI can connect to many sources (Excel, CSV, SQL Server, Snowflake, APIs, etc.).  
Let’s take a simple case: loading from **Excel/CSV** first.

### Steps:

1. Open **Power BI Desktop**.
2. On the Home ribbon → Click **Get Data**.
3. Choose your data source (e.g., _Excel_, _CSV_, _SQL Server_).
4. Navigate to your file / enter server connection details.
5. Select the **table/sheet** you want.
6. Before loading, you get two options:
    - **Load** → Directly loads into Power BI as-is.
    - **Transform Data** → Opens **Power Query Editor** (recommended, for cleaning).

👉 Example: If you pick an Excel file with _SalesData.xlsx_, it will show you all sheets/tables. You can select one and either **Load** or **Transform**.

## 2. Power Query Editor (Data Transformation)

This is where you shape your data before analysis.

When you click **Transform Data**, you’ll enter the **Power Query Editor**.

### Common Actions in Query Editor:
- **Remove unnecessary columns**: Right-click column header → Remove.
- **Filter rows**: Apply filters like in Excel.
- **Rename columns**: Double-click column name → rename.
- **Change data types**: Use the small icon in the column header (e.g., change text → number → date).
- **Split columns**: Useful for “Full Name” → “First” + “Last”.
- **Merge columns**: Combine two or more columns.
- **Replace values**: Replace errors/mistakes with correct data.
- **Remove duplicates**: Home tab → Remove Rows → Remove Duplicates.
- **Add custom columns**: Create new calculated columns with formulas (like Excel functions).
- **Group By**: Summarize data (e.g., total sales by region).
- **Append Queries**: Stack datasets on top of each other (like UNION in SQL).
- **Merge Queries**: Join tables (like SQL JOIN).

## 3. Apply & Load
- Once you’re done cleaning:
    - Click **Close & Load** → Data is loaded into Power BI model.
    - Now you can start creating **visuals and dashboards**.


---
# Exploring Power Query Editor Ribbons

## **HOME RIBBON**
### **1. Manage Queries**
- **New Source** → connect to a new data source (Excel, SQL Server, Web, etc.).
- **Recent Sources** → quickly reopen recently used data sources.
- **Enter Data** → manually type in data (like small lookup tables).
- **Data Source Settings** → manage permissions and credentials for data sources.
- **Manage Parameters** → create reusable values (like file path, database name).

### **2. Combine**
- **Append Queries** → stack tables (like UNION in SQL).
- **Merge Queries** → join tables together (like JOIN in SQL).

### **3. Parameters**
- **Manage Parameters** → define parameters (useful for dynamic paths).
- **What-If Parameters** (if enabled in Power BI Desktop).

### **4. Reduce Rows**
- **Remove Rows** → remove top rows, bottom rows, duplicates, or blank rows.
- **Keep Rows** → keep top rows, bottom rows, range of rows, or duplicates.

### **5. Sort & Filter**
- **Keep Top Rows / Keep Bottom Rows**
- **Sort Ascending / Descending**
- **Remove Duplicates**
- **Remove Blank Rows**
---
# 🔄 **Transform Ribbon in Power BI Query Editor**

### **Table section**
- Group by - works as group by from SQL
- Use First row as header - uses first row from table as header.
- Use Header as first row - use header as first row and assign field names as col1, col2.... col n
- Transpose - convert row to column.
- Reverse Rows - invert the ordering of rows.
- count rows - count rows and return single value.

### **Any Column Section**
- **Data Type** → change the column type (Whole Number, Decimal, Date, Text, etc.).
- **Replace Values** → replace a value (e.g., change “N/A” to null).
- **Detect Data Type** → auto-detect best type for each column.
- **Rename** - rename column.
- **replace Values** 
	- replace value - replace specific values.
	- replace error - replace error value with provided value.
- **Fill Down** → takes the value from the row above and fills into blank rows below.
- **Fill Up** → takes the value from the row below and fills into blank rows above.
- **convert to list** - convert selected column to list.
- **Pivot column** - It kind of make rows values as columns which result in wide table(horizontal) from long table(vertical).
- **unpivot columns** - opposite of pivot column
- **Move** - helps to move the position of columns in table.

### **Text Column Section**
- **Format** → clean text (Trim, Clean, UPPERCASE, lowercase, Capitalize Each Word).
- **Spilt Column** - split column.
- extract - extract info of selected column.
	- length - length of each value of the selected column
	- first-char - first n characters
	- last-char - last n characters
	- range - start index and no. of characters.
	- Text before delimiter , after and between delimiter.
	- 
### **Number Column Section**
- Statistic -
	- min, max, median, sum, avg, count , distinct count. standard deviation.
- Standard -
	- add, subtract, multiply and divide.
- scientific -
	- power, square, cube, square root...
- Information -
	- even - make all even no. from selected column `true` and odd `false`
	- odd - opposite of even.
	- sign

### **Date & time column Section**
- Date & time - convert to year month or day need to select date column from the table.

---
# ➕ Add Column Ribbon in Power BI Query Editor

### **General Section**
- **Custom Column** → write your own formula in M language (like Excel formulas, but Power Query syntax).
- **Invoke Custom Function** → call a function you created and apply it to each row.
- **Index Column** → adds a sequential column (0,1,2… or 1,2,3…). Useful for row IDs.
- **Duplicate Column** → makes a copy of an existing column.
- **Conditional Column** → rule-based column, like Excel’s IF.