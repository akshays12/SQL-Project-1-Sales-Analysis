-- Create TABLE
create table retail_sales(
                        transactions_id	INT,
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

-- Basic Checks
select * from retail_sales;

select count(*) from retail_sales;

select count(gender) from retail_sales
where gender = 'Female'

select count(age) from retail_sales
where age > 20

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


-- Data Exploration

-- Number of retail sales
select * from retail_sales
select count(*) as total_sales from retail_sales

-- Number of unique customers
select count(distinct customer_id) as total_customers from retail_sales

-- Number of unique categories
select count(distinct category) as categories from retail_sales
select distinct category as categories from retail_sales


-- Data Analysis (Business Key Problems & Answers)

-- 1. Write a SQL query to retrieve all columns for sales made on 2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05'

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or more than 4 in the month of Nov-2022:
select transactions_id
from retail_sales
where category = 'Clothing' and quantiy >= 4 and to_char(sale_date, 'YYYY-MM') = '2022-11'

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select distinct category as category, sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
group by category

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age), 3) as avg_customer_age, sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
where category = 'Beauty'

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
from retail_sales
where total_sale > 1000

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select gender, count(transactions_id), category
from retail_sales
group by gender, category
order by category, gender

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
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

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales:
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id) as unique_customers, category
from retail_sales
group by category


-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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

-- End of Project



