/*
==========================================================================================
Quality Checks
==========================================================================================
Sript Purpose:
  This script performs various quality checks for data consistency, accuracy, and 
  standardization across the data. It includes checks for:
	- Invalid date ranges.
	- Unwanted spaces in string fields.
	- Data standardization and consistency
	- Null or negative numbers.

Usage Notes:
  - Run this script on the dataset to perform quality checks before analysis.
  - Investigate and resolve any discrepancies found during the checks.
  - Intended for verifying data quality before analysis or reporting.
===========================================================================================
*/

-- Checking for invalid sales date
-- Expectation: No Result
SELECT 
	sale_Date
FROM dbo.Real_Estate_Data
WHERE sale_Date IS NULL
	OR sale_Date > GETDATE();

-- Checking for unwanted spaces
-- expectation: No Result
SELECT
	Address
FROM dbo.Real_Estate_Data
WHERE Address != TRIM(Address);

-- Checking for unwanted spaces
-- expectation: No Result
SELECT
	Town
FROM dbo.Real_Estate_Data
WHERE Town != TRIM(Town);

-- Checking for unwanted spaces
-- expectation: No Result
SELECT
	Property_Type
FROM dbo.Real_Estate_Data
WHERE Property_Type != TRIM(Property_Type);

-- Data standardization and consistency
SELECT DISTINCT
	Bedrooms
FROM dbo.Real_Estate_Data
ORDER BY Bedrooms;

-- Check for nulls or negative numbers
-- Expectation: No Results
SELECT
	Square_Feet
FROM dbo.Real_Estate_Data
WHERE Square_Feet IS NULL 
	OR Square_Feet <= 0;

-- Check for nulls or negative numbers
-- Expectation: No Results
SELECT
	Sale_Price
FROM dbo.Real_Estate_Data
WHERE Sale_Price IS NULL 
	OR Sale_Price <= 0;
