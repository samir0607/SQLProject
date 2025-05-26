/*
===============================================================================
DML Script: Measure Exploration
===============================================================================
Script Purpose:
    This script performs measure exploration in the Gold layer of the data 
		warehouse. It provides insights into key business metrics such as total sales, 
		revenue, average product price, and customer orders.

Usage:
    - This script can be executed to retrieve key measure-related metrics
===============================================================================
*/

-- Find total sold items
SELECT SUM(quantity) AS total_sales FROM gold.fact_sales 

-- Find total revenue
SELECT SUM(sales_amount) AS total_revenue FROM gold.fact_sales 

-- Find Average product price
SELECT AVG(price) AS average_price FROM gold.fact_sales 

-- Total Number of Orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales

-- Total Number of Products
SELECT COUNT(product_key) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_key) AS total_products FROM gold.dim_products

-- Total Number of Customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

-- Total Customers that placed order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales

-- Report that shows all key metrics of the Business
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales 
UNION ALL
SELECT 'Total Revenue' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers
