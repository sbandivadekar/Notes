--- Pattern: Projection with new column (hard coded value):
// 1. Employee data is being sourced from own HR system as well as from vendor, there is
// a need to tag company employees as “EMP” and vendor employees as “CONTRACTOR”. Write a
// query to add new hard coded column emp_type

select * , 'EMP' as emp_type from pattern_employees limit 10;

-----------------------------------------------------------------------

--- 2. Pattern: Filter (simple filter pattern)
// Problem: display employee information for all the employees with employee id less than 10011.

select * from pattern_employees;
select * from pattern_employees where emp_no < 10011;

-----------------------------------------------------------------------

--- 3. Pattern: Join
// Problem : Display department name, name of the manager and date from which manager has
// taken over that particular department.

select concat(pe.first_name, ' ', pe.last_name ) as manager, pdm.from_date from pattern_departments pd 
JOIN pattern_dept_manager pdm 
on pd.dept_no = pdm.dept_no
JOIN pattern_employees pe
on pdm.emp_no = pe.emp_no
where to_date = '9999-01-01';

-- or

select pe.first_name || ' ' || pe.last_name  as manager, pdm.from_date from pattern_departments pd 
JOIN pattern_dept_manager pdm 
on pd.dept_no = pdm.dept_no
JOIN pattern_employees pe
on pdm.emp_no = pe.emp_no
where to_date = '9999-01-01';

-----------------------------------------------------------------------

--- 4. Pattern: New column with expression (function on existing columns)
// Problem : employee table has first name and last name stored in two different columns. Write a sql to display the full name in a separate column. Select with new column using expression/function using two or more columns

select emp_no, concat(first_name, ' ', last_name) as emp_full_name, gender, hire_date from pattern_employees limit 10;

-----------------------------------------------------------------------

--- 5. Pattern: New column (flag) derived from Logical condition on one or more columns
// Problem : add a new column “current_ind” to table dept_manager, this field should have two values 1. Y for the latest record for every dept - manager combination 2. N for all records other than latest records identified

select dept_no, emp_no as manager, from_date, to_date, 
case
when to_date = '9999-01-01' then 'y'
else 'n'
end as current_ind
from pattern_dept_manager 
order by dept_no
limit 10;

-----------------------------------------------------------------------

--- 6. Pattern: Transpose: convert rows into columns
// Select new column (flag column) based on value of some categorical column. For example: Lets add two flag columns (male - y/n and female - y/n) in a select query for our employees table.

select 
    *, 
    CASE 
    when gender = 'M' then 'Y'
    else 'N' end as Male_Employee,

    case 
    when gender = 'F' then 'Y'
    else 'N' end as Female_employee
from pattern_employees
limit 10;

-----------------------------------------------------------------------
--- 7. Pattern: Transpose. This is another example of the pattern explained in the previous case (case 6).

// Select emp_no, gender, salary from salary table and employees table; and add two new columns as male_salary and female_salary as shown below:

select 
pe.emp_no, pe.gender, salary, 
case 
when pe.gender = 'M' then ps.salary
else 0 end as Male_Salary,

case 
when pe.gender = 'F' then ps.salary
else 0 end as Female_Salary,

ps.from_date, ps.to_date

from pattern_employees as pe 
join pattern_salaries as ps 
on pe.emp_no = ps.emp_no
limit 50;

-----------------------------------------------------------------------
--- 8. Pattern: Categorization (rather discretization) of a continuous variable value.

// problem : Select with a new column derived from the expression on value in the other column. For example: Add a new column exp_level, this should have three values A, B and C ( A for experience less than 10 years, be for experience between 10 and 15 years and C for experience 15 and above).

select 
    e.emp_no, e.birth_date, e.first_name, e.last_name,e.gender,
    case
    when e.exp_years < 10 then 'A'
    when e.exp_years >= 10 and e.exp_years < 15 then 'B'
    else  'C' end as exp_level
from (
select 
* , floor(DATEDIFF(year, hire_date, current_date())) as exp_years
from pattern_employees 
) e
limit 10;

-----------------------------------------------------------------------
--- 9. Pattern: Transpose using discrete categories identified in case 8.
// Select with more than one new column created for analytics (cross tabulation). For example: let's create three new columns each representing salary values as per salary range. This is very useful in analytics and a very typical requirement of any reporting/ETL project.

select
* ,
case 
when salary < 60000 then salary
else 0 end as exp_code_a,

case
when salary >= 60000 and salary < 80000 then salary
else 0 end as exp_code_b,

case
when salary >= 80000 then salary
else 0 end as exp_code_c

from pattern_salaries
limit 50;

-----------------------------------------------------------------------
--- 10. Pattern: Simple aggregation
// problem : Get Sum of salary for every employee

select 
emp_no, sum(salary)
from pattern_salaries
group by emp_no
limit 10;

-----------------------------------------------------------------------
--- 11. Pattern: Aggregation query with grouping on derived column:

// problem : Extract year from “ from_date” and extract total salary by year

select year(from_date) as year, sum(salary)
from pattern_salaries
group by year(from_date)
order by year asc;

select * from dept_year_salary;

-- or

select extract(year from from_date) as year, sum(salary)
from pattern_salaries
group by extract(year from from_date);
order by year asc;

-----------------------------------------------------------------------
--- 12. Pattern: Transpose and Aggregation:
select 
year(new_sal.from_date) as year,
sum(new_sal.salary),
sum(new_sal.exp_code_a),
sum(new_sal.exp_code_b),
sum(new_sal.exp_code_c)
from(

select
* ,
case 
when salary < 60000 then salary
else 0 end as exp_code_a,

case
when salary >= 60000 and salary < 80000 then salary
else 0 end as exp_code_b,

case
when salary >= 80000 then salary
else 0 end as exp_code_c

from pattern_salaries

) as new_sal
group by year;

-----------------------------------------------------------------------
--- 13. Pattern: Running total. There are different ways to get running total
// Problem: display total salary by department and add one column that shows cumulative total.

// for reference
SELECT 
    pd.dept_no,
    EXTRACT(YEAR FROM ps.to_date) AS year,
    SUM(ps.salary) AS total_salary
FROM pattern_salaries ps
JOIN pattern_dept_emp pd
    ON ps.emp_no = pd.emp_no
GROUP BY 
    pd.dept_no,
    EXTRACT(YEAR FROM ps.to_date)
order by pd.dept_no, year;


create or replace table dept_year_salary as (select s.dept_no,s.year,sum(s.salary) as yr_sal from
(select salary,
EXTRACT(YEAR from ps.to_date) as year,
dept_no FROM pattern_salaries ps
JOIN pattern_dept_emp pd
ON ps.emp_no=pd.emp_no) as s
group by s.dept_no, s.year
);

SELECT
  dept_no,
  year,
  yr_sal,
  SUM(yr_sal) OVER (PARTITION BY dept_no ORDER BY year) AS cumulative_sal
FROM (
    SELECT
      dept_no,
      year,
      SUM(yr_sal) AS yr_sal
    FROM
      dept_year_salary
    GROUP BY dept_no, year
) t
ORDER BY dept_no, year;

-----------------------------------------------------------------------
--- 14. Pattern: Additional categorical column (based on discretization of a continuous variable)

// Write a query to classify these 50 products in LOW_PRICE, MEDIUM_PRICE and HIGH_PRICE range. (clue you can find max and min price and divide range in three parts.
// a. Final result should have one additional column with price_category;
// b. Write a query to list price_category and count of products belonging to that category.

SELECT *,
CASE
WHEN price < 3 THEN 'low_price'
WHEN price >= 3
AND price < 7 THEN 'medium_price'
WHEN price >= 7 THEN 'high_price'
END AS Price_Cat
FROM product_master ;

-- and

SELECT count(*),
CASE
WHEN price < 3 THEN 'low_price'
WHEN price >= 3
AND price < 7 THEN 'medium_price'
WHEN price >= 7 THEN 'high_price'
END AS Price_Cat
FROM product_master
group by Price_Cat;

-----------------------------------------------------------------------
--- 15. Pattern: Simple aggregation
// problem : Aggregate the transaction sale amount at transaction level.


create table tran_total_sale as 
select 
tran_id, tran_date, sum(product_qty) as total_qty, sum(sales_amt) as total_sale
from sale_transaction
group by tran_id, tran_date;


select * from tran_total_sale;

-----------------------------------------------------------------------
--- 16. Pattern: Special Case (Transpose)
// Classify transaction in High, low or medium value transaction based on total sale amt for that transaction.

select 
*, 
case 
when total_sale < 50 then 'low'
when total_sale >= 50 and total_sale < 150 then 'medium'
when total_sale >=150 then 'high'
end as tran_cat
from tran_total_sale
limit 50;


-----------------------------------------------------------------------
--- 17. Pattern: Transpose data for example explained in case 16.
// Create a report where add three additional columns Low, Medium and High to the report. Any sale that comes from low value basket should go to Low, medium value basket should go to medium and so on.


SELECT 
    t.*,
    CASE 
        WHEN tt.tran_cat = 'low' THEN t.sales_amt 
        ELSE 0 
    END AS low_value_basket,
    CASE 
        WHEN tt.tran_cat = 'medium' THEN t.sales_amt 
        ELSE 0 
    END AS medium_value_basket,
    CASE 
        WHEN tt.tran_cat = 'high' THEN t.sales_amt 
        ELSE 0 
    END AS high_value_basket
FROM sale_transaction t
JOIN (
    SELECT 
        tran_id,
        tran_date,
        total_sale,
        CASE 
            WHEN total_sale < 50 THEN 'low'
            WHEN total_sale >= 50 AND total_sale < 150 THEN 'medium'
            WHEN total_sale >= 150 THEN 'high'
        END AS tran_cat
    FROM tran_total_sale
) tt
    ON t.tran_id = tt.tran_id
   AND t.tran_date = tt.tran_date;


-----------------------------------------------------------------------
--- 18. Pattern: Categorize, Transpose and Aggregate

SELECT 
    t.product_id,
    EXTRACT(YEAR FROM t.tran_date) AS year,
    EXTRACT(MONTH FROM t.tran_date) AS month,
    ROUND(SUM(t.sales_amt), 2) AS total_sales,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'low' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS low_value_basket,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'medium' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS medium_value_basket,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'high' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS high_value_basket

FROM sale_transaction t
JOIN (
    SELECT 
        tran_id,
        tran_date,
        total_sale,
        CASE 
            WHEN total_sale < 50 THEN 'low'
            WHEN total_sale >= 50 AND total_sale < 150 THEN 'medium'
            WHEN total_sale >= 150 THEN 'high'
        END AS tran_cat
    FROM tran_total_sale
) tt 
    ON t.tran_id = tt.tran_id
   AND t.tran_date = tt.tran_date
GROUP BY 
    t.product_id,
    EXTRACT(YEAR FROM t.tran_date),
    EXTRACT(MONTH FROM t.tran_date)

order by t.product_id, month;


select * from tran_total_sale;

WITH tran_total_sale_cat AS (
    SELECT 
        tran_id,
        tran_date,
        total_sale,
        CASE 
            WHEN total_sale < 50 THEN 'low'
            WHEN total_sale >= 50 AND total_sale < 150 THEN 'medium'
            WHEN total_sale >= 150 THEN 'high'
        END AS tran_cat
    FROM tran_total_sale
)

SELECT 
    t.product_id,
    EXTRACT(YEAR FROM t.tran_date) AS year,
    EXTRACT(MONTH FROM t.tran_date) AS month,
    ROUND(SUM(t.sales_amt), 2) AS total_sales,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'low' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS low_value_basket,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'medium' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS medium_value_basket,

    ROUND(
        SUM(
            CASE WHEN tt.tran_cat = 'high' THEN t.sales_amt ELSE 0 END
        ), 2
    ) AS high_value_basket
    
FROM sale_transaction t
join tran_total_sale_cat as tt
ON t.tran_id = tt.tran_id
   AND t.tran_date = tt.tran_date
GROUP BY 
    t.product_id,
    EXTRACT(YEAR FROM t.tran_date),
    EXTRACT(MONTH FROM t.tran_date)

order by t.product_id, month;







-----------------------------------------------------------------------
--- 19. Pattern: Transpose data for categorical columns
// Convert rows in columns (display monthly or quarterly sale on columns:

select 
product_id,
extract(year from tran_date) as year,
extract(month from tran_date) as month,

round(
case 
when extract(month from tran_date) < 4 
then sales_amt
else 0 end , 2
) as Q1_sales,

round(
case 
when extract(month from tran_date) > 3 and extract(year from tran_date) < 7
then sales_amt
else 0 end , 2
) as Q2_sales,

round(
case
when extract(year from tran_date) > 6 and extract(year from tran_date) < 10
then sales_amt
else 0 end , 2
) as Q3_sales,

round(
case
when extract(year from tran_date) > 9
then sales_amt
else 0 end , 2
) as Q4_sales,

from sale_transaction
limit 50;


SELECT product_id ,
Extract (year FROM tran_date) AS year ,
Extract (month FROM tran_date) AS month ,
Round ( CASE
WHEN Extract (month FROM tran_date) < 4 THEN sales_amt
ELSE 0
end , 2 ) AS "Q1_sales" ,
Round ( CASE
WHEN Extract (month FROM tran_date) > 3
AND Extract (month FROM tran_date) < 7 THEN
sales_amt
ELSE 0
end , 2 ) AS "Q2_sales" ,
Round ( CASE
WHEN Extract (month FROM tran_date) > 6
AND Extract (month FROM tran_date) < 10 THEN
sales_amt
ELSE 0
end , 2 ) AS "Q3_sales" ,
Round ( CASE
WHEN Extract (month FROM tran_date) > 9 THEN sales_amt
ELSE 0
end , 2 ) AS "Q4_sales"
FROM sale_transaction;


-----------------------------------------------------------------------
--- 20. Pattern: Aggregate transposed data to show total yearly sale and distribution across quarters by product and year.


SELECT
    t.product_id,
    t.year,
    SUM(t.sale_amt) AS total_sales,
    SUM(t.Q1_sales) AS Q1_sales,
    SUM(t.Q2_sales) AS Q2_sales,
    SUM(t.Q3_sales) AS Q3_sales,
    SUM(t.Q4_sales) AS Q4_sales
FROM (
    SELECT 
        product_id,
        EXTRACT(YEAR FROM tran_date) AS year,
        EXTRACT(MONTH FROM tran_date) AS month,
        ROUND(sales_amt, 2) AS sale_amt,

        ROUND(
            CASE 
                WHEN EXTRACT(MONTH FROM tran_date) BETWEEN 1 AND 3 THEN sales_amt
                ELSE 0 
            END, 2
        ) AS Q1_sales,

        ROUND(
            CASE 
                WHEN EXTRACT(MONTH FROM tran_date) BETWEEN 4 AND 6 THEN sales_amt
                ELSE 0 
            END, 2
        ) AS Q2_sales,

        ROUND(
            CASE 
                WHEN EXTRACT(MONTH FROM tran_date) BETWEEN 7 AND 9 THEN sales_amt
                ELSE 0 
            END, 2
        ) AS Q3_sales,

        ROUND(
            CASE 
                WHEN EXTRACT(MONTH FROM tran_date) BETWEEN 10 AND 12 THEN sales_amt
                ELSE 0 
            END, 2
        ) AS Q4_sales

    FROM sale_transaction
) AS t
GROUP BY t.year, t.product_id;

-----------------------------------------------------------------------
--- 21. Pattern: Transpose - convert columns into rows
// Product hierarchy product⇒ category=> department or time hierarchy day=>month=>year is generally shown on columns (separate column for each row). In certain situations though more than one hierarchy levels are to be shown on rows with additional identifier columns and are to be stored in one table. This is observed quite a few times while transforming the data.

CREATE OR REPLACE TABLE member_product_month_sale AS
SELECT 
    product_id,
    EXTRACT(MONTH FROM tran_date) AS month,
    SUM(sales_amt) AS month_sales
FROM sale_transaction
GROUP BY EXTRACT(MONTH FROM tran_date), product_id;

select * from member_product_month_sale;

SELECT 
    p.category AS retail_item,
    'category' AS level,
    SUM(m.month_sales) AS total_sale
FROM product_master p
JOIN member_product_month_sale m
    ON p.product_id = m.product_id
GROUP BY p.category

union all

select 
p.description,
'line_item' as level,
SUM(m.month_sales) AS total_sale
from member_product_month_sale m
join product_master p
ON p.product_id = m.product_id
GROUP BY p.description;

-----------------------------------------------------------------------
--- 22. Pattern: Aggregation at multiple levels of hierarchy
// Calculate monthly sale by product and on the same report display sale by year or quarter etc.

create or replace table year_month_quarter_sales as
select 
product_id,
extract (month from tran_date) as month,
case
when extract (month from tran_date) < 4 then 'Q1'
when extract (month from tran_date) < 7 then 'Q2'
when extract (month from tran_date) < 10 then 'Q3'
else 'Q4'
end as Quarter,
extract(year from tran_date) as year,
round(sum(sales_amt),2) as month_sale
from sale_transaction
group by product_id,
month, Quarter, year;


select 
product_id, month, year, month_sale,
sum(month_sale) over (partition by product_id, quarter) as quarter_total_sales,
sum(month_sale) over (partition by product_id, year) as year_total_sales
from year_month_quarter_sales
order by product_id, month, year;

-----------------------------------------------------------------------
--- 23. Pattern: Running Totals (year till date, month till date, week till date etc.)
// Calculate daily sale by product and generate a report showing daily sale of product and running total that shows total sale till date.

create or replace table product_day_sales as
select 
product_id, tran_date,
round(sum(sales_amt), 2) as day_sales
from sale_transaction
group by product_id, tran_date;

select *,
sum(day_sales) over(partition by product_id order by tran_date) as sales_till_date
from product_day_sales
where product_id in (1,2,34)
order by product_id, tran_date; 

-----------------------------------------------------------------------
--- 24. Pattern: Running Total
// Get running total of monthly sale for a product; To take a simple approach create a aggregate table first that stores monthly sale by product;

create or replace table product_month_sales as
select 
product_id, 
extract(month from tran_date) as month,
sum(sales_amt) as month_sales
from sale_transaction
group by product_id, month;


select 
product_id,
month,
month_sales,
sum(month_sales) over (partition by product_id order by  month) as sales_till_month
from product_month_sales order by product_id, month;


-----------------------------------------------------------------------
--- 25. Pattern: Running total with Moving window (any size window)
// display total sale for each product using window of size 4;

WITH product_day_sales AS (
    SELECT 
        product_id,
        tran_date,
        EXTRACT(DAY FROM tran_date) AS day,
        SUM(sales_amt) AS day_sale
    FROM sale_transaction
    GROUP BY product_id, EXTRACT(DAY FROM tran_date), tran_date
)
SELECT 
    product_id, 
    tran_date,
    day_sale,
    SUM(day_sale) OVER (
        PARTITION BY product_id 
        ORDER BY tran_date 
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ) AS sales_till_date
FROM product_day_sales
WHERE product_id IN (1,2,34)
ORDER BY product_id, tran_date;


-----------------------------------------------------------------------
--- 26. Pattern: Running total with moving window

WITH member_product_day_sale AS (
    SELECT 
        st.product_id,
        sth.member_id,
        st.tran_date,
        EXTRACT(day FROM st.tran_date) AS day,
        SUM(st.sales_amt) AS day_sales
    FROM sale_transaction AS st
    JOIN sale_transaction_header AS sth
        ON st.tran_id = sth.tran_id
    GROUP BY st.product_id, sth.member_id, EXTRACT(day FROM st.tran_date), st.tran_date
    order by product_id, tran_date, day, member_id
)

select 
member_id,
month,
month_sales,
last_three_months,
case
when last_three_months < 1200 then 'silver'
when last_three_months >= 1200 and last_three_months< 1800 then 'gold'
when last_three_months >= 1800 then 'platinum'
end as loyalty_level

from (

select 
member_id,
month, 
month_sales,
sum(month_sales) over (partition by member_id order by month rows between 2 preceding and current row) as last_three_months

from (

select 
member_id,
extract(month from tran_date) as month,
sum(day_sales) as month_sales
from member_product_day_sale
where member_id in (87,121, 89)
group by member_id, month

) ) ;

-----------------------------------------------------------------------
--- 27. a. Pattern: Rank data to know top n good or bad performing dimensions
// Find 5 top favorite products for each member for every month

WITH member_product_day_sale AS (
    SELECT 
        st.product_id,
        sth.member_id,
        st.tran_date,
        EXTRACT(DAY FROM st.tran_date) AS day,
        SUM(st.sales_amt) AS day_sales
    FROM sale_transaction AS st
    JOIN sale_transaction_header AS sth
        ON st.tran_id = sth.tran_id
    GROUP BY st.product_id, sth.member_id, st.tran_date, EXTRACT(DAY FROM st.tran_date)
),
member_product_month_sale AS (
    SELECT 
        member_id, 
        product_id, 
        EXTRACT(MONTH FROM tran_date) AS month, 
        EXTRACT(YEAR FROM tran_date)  AS year, 
        SUM(day_sales) AS month_sale 
    FROM member_product_day_sale 
    GROUP BY member_id, product_id, EXTRACT(MONTH FROM tran_date), EXTRACT(YEAR FROM tran_date)
)
SELECT 
    member_id, 
    product_id, 
    year, 
    month, 
    month_sale, 
    RANK() OVER (
        PARTITION BY member_id, month 
        ORDER BY month_sale DESC
    ) AS rank_prd
FROM member_product_month_sale 
WHERE member_id = 10
order by  member_id, month, rank_prd;

-----------------------------------------------------------------------
--- 28. Pattern: Bucketting Case-1
// Classify products in 5 groups as per the popularity. One of the ways to quantify popularity is total_sale amount (total of one year sale). 


SELECT product_id, 
       total_sale, 
       Ntile(5) 
         OVER ( 
           ORDER BY total_sale DESC) AS store_popularity_bucket 
FROM   (SELECT product_id, 
               Round(Sum(sales_amt), 2) AS total_sale 
        FROM   sale_transaction
        GROUP  BY product_id) a; 

-----------------------------------------------------------------------
--- 29. Pattern: Bucketing Case-2
// Classify products into 5 buckets for every member based on purchases done by members over a year.


WITH member_product_day_sale AS (
    SELECT 
        st.product_id,
        sth.member_id,
        st.tran_date,
        EXTRACT(DAY FROM st.tran_date) AS day,
        SUM(st.sales_amt) AS day_sales
    FROM sale_transaction AS st
    JOIN sale_transaction_header AS sth
        ON st.tran_id = sth.tran_id
    GROUP BY st.product_id, sth.member_id, st.tran_date, EXTRACT(DAY FROM st.tran_date)
),
member_product_month_sale AS (
    SELECT 
        member_id, 
        product_id, 
        EXTRACT(MONTH FROM tran_date) AS month, 
        EXTRACT(YEAR FROM tran_date)  AS year, 
        SUM(day_sales) AS month_sale 
    FROM member_product_day_sale 
    GROUP BY member_id, product_id, EXTRACT(MONTH FROM tran_date), EXTRACT(YEAR FROM tran_date)
)
SELECT 
    member_id,
    product_id,
    year,
    total_sales,
    NTILE(5) OVER (
        PARTITION BY member_id, year 
        ORDER BY total_sales DESC
    ) AS member_pref_bucket
FROM (
    SELECT 
        member_id, 
        product_id, 
        year, 
        SUM(month_sale) AS total_sales
    FROM member_product_month_sale
    GROUP BY member_id, product_id, year
) a
WHERE member_id = 10;

-----------------------------------------------------------------------
--- 30. Pattern: Bucketing Case-3
// Generate a report that displays global popularity for a product  and member pref side by side.

WITH member_product_year_sale AS (
    SELECT 
        member_id, 
        product_id, 
        year, 
        SUM(month_sale) AS total_sale
    FROM member_product_month_sale
    GROUP BY member_id, product_id, year
),
member_product_ranked AS (
    SELECT 
        member_id, 
        product_id, 
        year, 
        total_sale,
        NTILE(5) OVER (
            PARTITION BY member_id, year
            ORDER BY total_sale DESC
        ) AS member_pref_bucket
    FROM member_product_year_sale
),
store_product_sale AS (
    SELECT 
        product_id, 
        ROUND(SUM(sales_amt), 2) AS total_sale
    FROM sale_transaction
    GROUP BY product_id
),
store_product_ranked AS (
    SELECT 
        product_id, 
        total_sale,
        NTILE(5) OVER (
            ORDER BY total_sale DESC
        ) AS store_popularity_bucket
    FROM store_product_sale
)
SELECT 
    mp.member_id,
    mp.product_id,
    mp.year,
    mp.total_sale,
    gp.total_sale AS store_total_sale,
    mp.member_pref_bucket,
    gp.store_popularity_bucket
FROM member_product_ranked mp
JOIN store_product_ranked gp
    ON mp.product_id = gp.product_id
WHERE mp.member_id = 10
order by member_id, product_id;


-----------------------------------------------------------------------
---  32. Pattern: Lead and Lag
// Display member, product, month sale data with one additional column that shows sale value for previous month.

SELECT 
    member_id,
    product_id,
    month,
    LAG(month_sale, 3) OVER (PARTITION BY member_id, product_id ORDER BY month) AS prev_3,
    LAG(month_sale, 2) OVER (PARTITION BY member_id, product_id ORDER BY month) AS prev_2,
    LAG(month_sale, 1) OVER (PARTITION BY member_id, product_id ORDER BY month) AS prev_1,
    month_sale,
    LEAD(month_sale, 1) OVER (PARTITION BY member_id, product_id ORDER BY month) AS next_1,
    LEAD(month_sale, 2) OVER (PARTITION BY member_id, product_id ORDER BY month) AS next_2,
    LEAD(month_sale, 3) OVER (PARTITION BY member_id, product_id ORDER BY month) AS next_3
FROM member_product_month_sale
WHERE year = 2018
  AND member_id = 10
  AND product_id IN (20,21,22,23);

SELECT member_id, 
       product_id, 
       year, 
       month, 
       month_sale, 
       Lag(month_sale) 
         OVER( 
           partition BY member_id, product_id 
           ORDER BY month) AS previous_month_sale 
FROM   member_product_month_sale 
WHERE  member_id = 10 
       AND product_id IN ( 20, 21, 22, 23 ); 

-----------------------------------------------------------------------
--- 33. Pattern: Nth Value In List
select 
    member_id, 
    product_id, 
    total_sale, 
    NTH_VALUE(total_sale, 3) OVER (ORDER BY total_sale DESC) AS max_ignoring_outlier

    from (
        select
        member_id, product_id, 
        sum(month_sale) as total_sale
        from member_product_month_sale
        group by member_id,
         product_id
         order by total_sale
    )
limit 100;











