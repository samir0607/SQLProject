/*
===============================================================================
DML Script: Database Exploration
===============================================================================
Script Purpose:
    This script performs database exploration in the Gold layer of the data 
		warehouse. It provides insights into the structure and contents of the 
		database, including tables and columns.
Usage:
    - This script can be executed to retrieve metadata about the database
===============================================================================
*/

-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All the Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
