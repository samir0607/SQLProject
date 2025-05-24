/*
===============================================================================
DML Script: Ranking Analysis
===============================================================================
Script Purpose:
    This script performs ranking analysis in the Gold layer of the data 
		warehouse. It provides insights into the performance of products and customers
		by ranking them based on revenue and order counts.

Usage:
    - This script can be executed to retrieve key ranking-related metrics
===============================================================================
*/

-- Top 5 products with highest revenue (BEST performing)[can perform same for category and subcategory]
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- More complex version
SELECT 
* 
FROM(
    SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f 
    LEFT JOIN gold.dim_products p 
    ON p.product_key = f.product_key
    GROUP BY p.product_name
)t WHERE rank_products <= 5;

-- Worst performing
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p 
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue

-- Top 10 Most Valuable Customers
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key, 
c.first_name, 
c.last_name
ORDER BY total_revenue DESC

-- Worst 3 Customers with least orders
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT ) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key, 
c.first_name, 
c.last_name
ORDER BY total_revenue DESC