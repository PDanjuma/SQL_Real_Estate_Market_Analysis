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
FROM dbo.Real_Estate_Data_Clean
WHERE sale_Date IS NULL
	OR sale_Date > GETDATE();

-- Checking for unwanted spaces
-- expectation: No Result
SELECT
	Address
FROM dbo.Real_Estate_Data_Clean
WHERE Address != TRIM(Address);

SELECT
	Town
FROM dbo.Real_Estate_Data_Clean
WHERE Town != TRIM(Town);

SELECT
	Property_Type
FROM dbo.Real_Estate_Data_Clean
WHERE Property_Type != TRIM(Property_Type);

-- Data standardization and consistency
SELECT DISTINCT
	Bedrooms
FROM dbo.Real_Estate_Data_Clean
ORDER BY Bedrooms;

SELECT DISTINCT
	Town
FROM dbo.Real_Estate_Data_Clean
ORDER BY Bedrooms;

SELECT DISTINCT
	Property_Type
FROM dbo.Real_Estate_Data_Clean
ORDER BY Bedrooms;

-- Check for nulls or negative numbers
-- Expectation: No Results
SELECT
	Square_Feet
FROM dbo.Real_Estate_Data_Clean
WHERE Square_Feet IS NULL 
	OR Square_Feet <= 0;

SELECT
	Sale_Price
FROM dbo.Real_Estate_Data_Clean
WHERE Sale_Price IS NULL 
	OR Sale_Price <= 0;
