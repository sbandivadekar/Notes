## 📝 Steps

⚠️ Notes:
- Use forward slashes `/` instead of backslashes `\` in Windows.
- I have used example code, It's for reference.

### **1. Install SQL Workbench**  
- Use **MySQL Workbench** to manage your database and tables.  

---

### **2. Create Database & Tables (MySQL)**  
Example
```sql
CREATE DATABASE employee_db;
USE database employee_db;

CREATE TABLE employees (
    emp_no INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    hire_date DATE
);
```

### **3. Execute Dump Files**

- Example (MySQL CLI):
	- Execute this in CMD 
	- If you face MYSQL not recognize then add the mysql server path in ENV variables.
```sql
mysql -u root -p
Enter your password
SOURCE C:/path/to/your/file.dump;
```

### **4. Export Data to CSV**

- Example (MySQL Workbench):
	⚠️ Notes:
		There is a issue where while exporting the data in csv from workbench it will only export only visible rows. need some additional setting to do.
	- execute (`Select * from table_name;`)
	- in the result section you will get the export button.
-  **Here is safe way to do it**
```sql
SELECT *
FROM pattern_salaries
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pattern_salaries.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

⚠️ Notes:
don't change to location of `OUTFILE` as mysql don't have permission to store outside `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads` this path. 

---
# 🗄️ Setup on Snowflake

###  **5. Create Database & Schemas**
Maintain Schema for EMP and Retail for organization.
example
```sql
CREATE OR REPLACE DATABASE pattern_db;
CREATE OR REPLACE SCHEMA emp;
CREATE OR REPLACE SCHEMA retail;
```

### **6. Create File Format & Stages**
File format and stages should go under respective schema for organization.
example
```sql
CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1;

CREATE OR REPLACE STAGE emp_stage FILE_FORMAT = my_csv_format;
CREATE OR REPLACE STAGE retail_stage FILE_FORMAT = my_csv_format;
```

### **7. Upload CSV Files via SnowSQL**

Example (from your local system) need to install snowsql:
https://www.snowflake.com/en/developers/downloads/snowsql/
```snowsql
snowsql -a <account_name> -u <user>
Enter your password
use database DB_Name;
use schema schema name

PUT 'file://C:/path/to/employees.csv' @emp_stage AUTO_COMPRESS=TRUE;
PUT 'file://C:/path/to/departments.csv' @emp_stage AUTO_COMPRESS=TRUE;
```

### **8. Copy Data into Tables**
Example
```sql
list @stage_name;

COPY INTO emp.employees
FROM @emp_stage/employees.csv.gz
FILE_FORMAT = (FORMAT_NAME = my_csv_format)
ON_ERROR = 'CONTINUE';

COPY INTO emp.departments
FROM @emp_stage/departments.csv.gz
FILE_FORMAT = (FORMAT_NAME = my_csv_format)
ON_ERROR = 'CONTINUE';
```

---
# Method 2
⚠️ Notes:
This method is not to lengthy but take time to upload data to snowflake
### **1. create table & schema on snowflake**
Example
```sql
CREATE OR REPLACE DATABASE pattern_db;
CREATE OR REPLACE SCHEMA emp;
CREATE OR REPLACE SCHEMA retail;
```

### **3. install snowsql**
https://www.snowflake.com/en/developers/downloads/snowsql/

Open CMD and login
```snowsql
snowsql -a account_name -u username
Enter your password
```

### **4. Execute dump files**
Example
```snowsql
use database DB_Name;
use schema schema name
!source C:/path/to/your/file.dump;
```

### **Start executing your SQL patterns**
