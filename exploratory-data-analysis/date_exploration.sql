/*
===============================================================================
DML Script: Date Exploration
===============================================================================
Script Purpose:
    This script performs date-related explorations in the Gold layer of the data 
		warehouse.
		It provides insights into the order dates and customer birth dates to 
		understand the business timeline and customer demographics.

Usage:
    - This script can be executed to retrieve key date-related metrics
===============================================================================
*/

-- Find the Dates of first and last orders
-- Find How many years did the business sold
-- Find the Dates of first and last orders
-- Find How many years did the business sold
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_ranges_months
FROM gold.fact_sales

-- Find yongest and oldest customer age range
SELECT
MIN(birth_date) AS youngest_customer_birthdate,
DATEDIFF(YEAR, MIN(birth_date), GETDATE()) AS current_oldest_age,
MAX(birth_date) AS oldest_customer_birthdate,
DATEDIFF(YEAR, MAX(birth_date), GETDATE()) AS current_youngest_age
FROM gold.dim_customers
