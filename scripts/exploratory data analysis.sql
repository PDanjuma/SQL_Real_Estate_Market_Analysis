/*
===========================================================================================
Exploratory Data Analysis: Database Exploration
===========================================================================================

Script Purpose:
	This script performs initial exploration of the real estate database.
	It helps understand the structure, tables, and columns for analysis.

	The exploration include:
	- Identifying the tables in the database
	- Examining column structures and data types

Usage:
	- Run this script first to get familiar with the database structure.
	- Use the results to inform subsequent analysis queries

============================================================================================
*/

-- ==========================================================================================
-- Explore Objects in the Database
-- ==========================================================================================

SELECT *
FROM INFORMATION_SCHEMA.TABLES;

-- ==========================================================================================
-- Explore All Columns in the Database
-- ==========================================================================================
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS;

/*
==========================================================================================
Exploratory Data Analysis: Dimension Exploration
==========================================================================================

Script Purpose:
  This section explores key categorical fields in the real estate dataset
  to identify the distinct values and understand how the data is structured.

  The exploration covers:
  - Distinct list of towns in the dataset
  - Property types available
  - Total number of property for each bedroom value

==========================================================================================
*/
-- =========================================================================================
-- Explore all towns in the dataset
-- =========================================================================================
SELECT DISTINCT
	Town
FROM dbo.Real_Estate_Data_Clean;

-- =========================================================================================
-- Explore all property type in the dataset
-- =========================================================================================
SELECT DISTINCT
	Property_Type
FROM dbo.Real_Estate_Data_Clean
ORDER BY Property_Type;

-- =========================================================================================
-- How many distinct bedroom values exist in the dataset?
-- =========================================================================================
SELECT DISTINCT
	Bedrooms,
	COUNT(*) AS Total_Bedrooms
FROM dbo.Real_Estate_Data_Clean
GROUP BY Bedrooms
ORDER BY Total_Bedrooms;

/*
==========================================================================================
Exploratory Data Analysis: Date Exploration
==========================================================================================

Script Purpose:
  This section analyzes time-related aspect of the dataset to understand how sales and 
  prices vary over time.

The exploration covers:
  - Counting the number of sales in each year
  - Identifying the first and last sale dates, and the gap between them
  - Calculating the average sale price for each year
==========================================================================================
*/
-- =======================================================================================
-- Number of property sales per year
-- =======================================================================================
SELECT
	YEAR(Sale_Date) AS Sales_Year,
	COUNT(*) AS Total_no_Property_Sales
FROM dbo.Real_Estate_Data_Clean
GROUP BY YEAR(Sale_Date)
ORDER BY Total_no_Property_Sales DESC;

-- =======================================================================================
-- Find the date of the first and last sale
-- How many years gap betweeen the first sale date and last ´sale date
-- ========================================================================================
SELECT
	MIN(Sale_Date) AS First_Sales_Date,
	MAX(Sale_Date) AS Last_Sales_Date,
	DATEDIFF(year, MIN(Sale_Date), MAX(Sale_Date))
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Average price per year
-- =======================================================================================
SELECT 
	YEAR(Sale_Date)AS Sale_Year,
	FORMAT(ROUND(AVG(Sale_Price), 2), 'N2') AS Avg_Price
FROM dbo.Real_Estate_Data_Clean
GROUP BY YEAR(Sale_Date);

/*
==========================================================================================
Exploratory Data Analysis: Measure Analysis
==========================================================================================

Script Purpose:
  This section focuses on key numerical metrics in the dataset to get a clear
  summary of sales performance and property values.

  The analysis calculates totals, counts, averages, and price extremes
  to understand overall market behavior.

  The exploration covers:
  - Total sales value
  - Total number of properties sold
  - Number of unique property types
  - Number of unique towns
  - Average property price
  - Average price per square foot
  - Lowest and highest property prices
  
==========================================================================================
*/

-- =======================================================================================
-- Find the total sales
-- =======================================================================================
SELECT
	FORMAT(SUM(Sale_Price), 'N2') AS Total_Sales
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the total number property type
-- =======================================================================================
SELECT
	COUNT(DISTINCT Property_Type) AS Num_of_PropertyType
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the total number towns
-- =======================================================================================
SELECT
	COUNT(DISTINCT Town) AS Num_of_Towns
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the average property price 
-- =======================================================================================
SELECT
	FORMAT(AVG(Sale_Price), 'N2') AS Avg_Price
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the total houses sold
-- =======================================================================================
SELECT
 COUNT(*) AS Total_Houses_Sold
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the lowest property price
-- =======================================================================================
SELECT
	FORMAT(MIN(Sale_Price), 'N2') AS Lowest_Price
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the highest property price
-- =======================================================================================
SELECT
	FORMAT(MAX(Sale_Price), 'N2') AS Highest_Price
FROM dbo.Real_Estate_Data_Clean;

-- =======================================================================================
-- Find the average price per sq ft
-- =======================================================================================
SELECT 
	AVG(Price_per_Sqft) AS Avg_Price_per_sqft
FROM dbo.Real_Estate_Data_Clean
ORDER BY Avg_Price_per_sqft DESC;

-- =============================================================================================
-- Generate a Report that shows all key metrics of the business
-- ==============================================================================================
SELECT 'Total Sales' AS measure_name, SUM(Sale_Price) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Total Houses Sold' AS measure_name, AVG(Sale_Price) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Total Num. Property Type' AS measure_name, COUNT(DISTINCT Property_Type) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Total Num. Towns' AS measure_name, COUNT(DISTINCT Town) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Avg. Property Price' AS measure_name, AVG(Sale_Price) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Avg. Price per Sq ft' AS measure_name, AVG(Sale_Price / NULLIF(Square_Feet, 0)) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Lowest Property Price' AS measure_name, MIN(Sale_Price) AS measure_value FROM dbo.Real_Estate_Data_Clean
UNION ALL
SELECT 'Highest Property Price' AS measure_name, MAX(Sale_Price) AS measure_value FROM dbo.Real_Estate_Data_Clean

/*
==========================================================================================
Exploratory Data Analysis: Magnitude Analysis
==========================================================================================

Script Purpose:
  This section compares values across different groups to understand
  the size and scale of market activity.

  The exploration covers:
    - Number of property sales by town and property type
    - Total revenue contribution by town and property type
    - Average price per square foot across categories
    - Market concentration and comparison across groups

==========================================================================================
*/

-- =======================================================================================
-- Find number of property sales by town
-- =======================================================================================
SELECT
	Town,
	COUNT(*) Total_Sales_by_Town
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town
ORDER BY Total_Sales_by_Town DESC;

-- =======================================================================================
-- Find number of property sales by property type
-- =======================================================================================
SELECT
	Property_Type,
	COUNT(*) Total_Sales_by_Property_Type
FROM dbo.Real_Estate_Data_Clean
GROUP BY Property_Type
ORDER BY Total_Sales_by_Property_Type DESC;

-- =======================================================================================
-- Find the average price per sqft by each town
-- =======================================================================================
SELECT
	Town,
	AVG(Price_Per_Sqft) Avg_Town_Price_per_Sqft
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town
ORDER BY Avg_Town_Price_per_Sqft DESC;

-- =======================================================================================
-- Find the average price per sqft by each property type
-- =======================================================================================
SELECT
	Property_Type,
	AVG(Price_Per_Sqft) Avg_PropertyType_Price_per_Sqft
FROM dbo.Real_Estate_Data_Clean
GROUP BY Property_Type
ORDER BY Avg_PropertyType_Price_per_Sqft DESC;

-- =======================================================================================
-- Find total revenue generated by each town
-- =======================================================================================
SELECT
	Town,
	SUM(Sale_Price) Total_Town_Revenue
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town
ORDER BY Total_Town_Revenue DESC;

-- =======================================================================================
-- Find total revenue generated by each property type
-- =======================================================================================
SELECT
	Property_Type,
	SUM(Sale_Price) Total_PropertyType_Revenue
FROM dbo.Real_Estate_Data_Clean
GROUP BY Property_Type
ORDER BY Total_PropertyType_Revenue DESC;

/*
==========================================================================================
Exploratory Data Analysis: Ranking Analysis
==========================================================================================

Script Purpose:
    This section ranks different segments of the real estate market
    to identify high-performing and low-performing areas based on sales activity,
    pricing, and property characteristics.

    The analysis focuses on:
    - Ranking towns by total sales and revenue
    - Ranking property types by market demand and revenue
    - Identifying most expensive and least expensive markets
    - Ranking properties by bedroom categories and pricing levels
    - Understanding which segments dominate the real estate market

==========================================================================================
*/

-- =======================================================================================
-- Find town with highest and lowest number of sales
-- =======================================================================================
SELECT
	Town,
	COUNT(*) Total_Sales_by_Town,
	RANK() OVER(ORDER BY COUNT(*) DESC) AS Town_Rank
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town
ORDER BY Total_Sales_by_Town DESC;

-- =======================================================================================
-- Find town with highest and lowest revenue
-- =======================================================================================
SELECT 
	Town,
	SUM(Sale_Price) Total_Town_Revenue,
	RANK() OVER(ORDER BY SUM(Sale_Price) DESC) AS Town_Rank
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town;

-- =======================================================================================
-- Rank property type by total number of sales and total revenue
-- =======================================================================================
SELECT
    Property_Type,
    COUNT(*) AS Total_no_Sales,
    SUM(Sale_Price) AS Total_Revenue,
	RANK() OVER (ORDER BY COUNT(*) DESC) AS Demand_Rank,
    RANK() OVER (ORDER BY SUM(Sale_Price) DESC) AS Revenue_Rank
FROM dbo.Real_Estate_Data_Clean
GROUP BY Property_Type;

-- =======================================================================================
-- Identify most and least expensive markets based on price per sqft
-- =======================================================================================
SELECT
    Town,
    AVG(Price_per_Sqft) AS Avg_Price_per_Sqft,
    RANK() OVER (ORDER BY AVG(Price_per_Sqft) DESC) AS Market_Rank
FROM dbo.Real_Estate_Data_Clean
GROUP BY Town;

-- =======================================================================================
-- Ranking properties by bedroom categories and pricing levels
-- =======================================================================================
SELECT
    Bedrooms,
    COUNT(*) AS Total_Properties_Sold,
    AVG(Sale_Price) AS Avg_Price,
    AVG(Price_per_Sqft) AS Avg_Price_per_Sqft,
	RANK() OVER (ORDER BY AVG(Sale_Price) DESC) AS Price_Rank,
    RANK() OVER (ORDER BY AVG(Price_per_Sqft) DESC) AS Price_per_Sqft_Rank
FROM dbo.Real_Estate_Data_Clean
WHERE Bedrooms IS NOT NULL
GROUP BY Bedrooms
ORDER BY Price_Rank;
