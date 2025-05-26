/*
===============================================================================
DML Script: Dimension Exploration
===============================================================================
Script Purpose:
    This script performs dimension exploration in the Gold layer of the data 
		warehouse. It provides insights into the dimensions such as customers and 
		products, which are essential for analytics and reporting.
Usage:
    - This script can be executed to retrieve key dimension-related metrics
===============================================================================
*/

-- Explore All Countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories "The Major Division"
SELECT DISTINCT category, sub_category, product_name FROM gold.dim_products
ORDER BY 1, 2, 3
