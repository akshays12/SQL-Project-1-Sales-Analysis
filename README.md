# SQL-Project-1-Sales-Analysis

## Project Overview
Project Title: Retail Sales Analysis
Level: Beginner
Database: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
```sql
create database p1_retail_db;
create table retail_sales(
      transactions_id	 INT,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(15),
			age INT,
			category VARCHAR(15),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
)
```
3. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.
```sql
-- Number of retail sales
select * from retail_sales
select count(*) as total_sales from retail_sales

-- Number of unique customers
select count(distinct customer_id) as total_customers from retail_sales

-- Number of unique categories
select count(distinct category) as categories from retail_sales
select distinct category as categories from retail_sales

-- Check for NULL values
select * from retail_sales
where transactions_id is NULL 
      or
      sale_date is NULL 
	  or
	  sale_time is NULL 
	  or
	  customer_id is NULL 
	  or
	  gender is NULL 
	  or
	  age is NULL 
	  or
	  category is NULL 
	  or
	  quantiy is NULL 
	  or
	  price_per_unit is NULL
	  or
	  cogs is NULL 
	  or
	  total_sale is NULL


-- Delete NULL values
delete from retail_sales
where transactions_id is NULL 
      or
      sale_date is NULL 
	  or
	  sale_time is NULL 
	  or
	  customer_id is NULL 
	  or
	  gender is NULL 
	  or
	  age is NULL 
	  or
	  category is NULL 
	  or
	  quantiy is NULL 
	  or
	  price_per_unit is NULL
	  or
	  cogs is NULL 
	  or
	  total_sale is NULL
```
5. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

Write a SQL query to retrieve all columns for sales made on 2022-11-05:
```sql
select * from retail_sales
where sale_date = '2022-11-05'
```

Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or more than 4 in the month of Nov-2022:
```sql
select transactions_id
from retail_sales
where category = 'Clothing' and quantiy >= 4 and to_char(sale_date, 'YYYY-MM') = '2022-11'

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
```sql
select distinct category as category, sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
group by category
```

Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
```sql
select round(avg(age), 3) as avg_customer_age, sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
where category = 'Beauty'
```

Write a SQL query to find all transactions where the total_sale is greater than 1000.:
```sql
select *
from retail_sales
where total_sale > 1000
```

Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
```sql
select gender, count(transactions_id), category
from retail_sales
group by gender, category
order by category, gender
```

Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```sql
with ranked_sales as (
select avg(total_sale) as avg_monthly_sales, 
       extract(month from sale_date) as mon,
	   extract(year from sale_date) as yr,
	   rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by extract(month from sale_date), extract(year from sale_date)
)
select avg_monthly_sales, mon, yr
from ranked_sales
where rnk = 1
```

Write a SQL query to find the top 5 customers based on the highest total sales:
```sql
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5
```

Write a SQL query to find the number of unique customers who purchased items from each category.:
```sql
select count(distinct customer_id) as unique_customers, category
from retail_sales
group by category
```


Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
with hourly_sale as(
select *,
       case when extract(hour from sale_time) < 12 then 'Morning'
	        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	   else 'Evening'
	   end as shift
from retail_sales
)
select count(transactions_id) as orders_count, shift
from hourly_sale
group by shift
```

## Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


