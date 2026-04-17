/*
==========================================================================================
Stored Procedure: load_real_estate_clean
==========================================================================================

Purpose:
    This stored procedure creates and loads a cleaned version of the real estate dataset.

    It performs both:
    - DDL (Data Definition Language): 
        * Drops existing table
        * Creates a new clean table

    - DML (Data Manipulation Language):
        * Inserts cleaned and transformed data into the table

    The cleaning process includes:
    - Standardizing town names
    - Calculating price per square foot
    - Handling division by zero

	Usage Example:
	EXEC dbo.load_real_estate_clean;

==========================================================================================
*/

IF OBJECT_ID('dbo.load_real_estate_clean', 'P') IS NOT NULL
    DROP PROCEDURE dbo.load_real_estate_clean;
GO

CREATE PROCEDURE dbo.load_real_estate_clean
AS
BEGIN
	DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time DATETIME;
	BEGIN TRY

        SET @batch_start_time = GETDATE();

        -- Loading dbo.Real_Estate_Data_Clean table
        SET @start_time = GETDATE();
        PRINT '>> Dropping Table: dbo.Real_Estate_Data_Clean';
		PRINT '>> Creating Table: dbo.Real_Estate_Data_Clean';

IF OBJECT_ID ('dbo.Real_Estate_Data_Clean', 'U') IS NOT NULL
	DROP TABLE dbo.Real_Estate_Data_Clean;
GO

CREATE TABLE dbo.Real_Estate_Data_Clean(
	Sale_Date DATE,
	Address NVARCHAR (50),
	Town NVARCHAR (50),
	Property_Type NVARCHAR (50),
	Bedrooms TINYINT,
	Square_Feet SMALLINT,
	Sale_Price MONEY,
	Price_per_Sqft MONEY
);


 PRINT '>> Inserting Data Into: dbo.Real_Estate_Data_Clean';

INSERT INTO dbo.Real_Estate_Data_Clean (
	Sale_Date,
	Address,
	Town,
	Property_Type,
	Bedrooms,
	Square_Feet,
	Sale_Price,
	Price_per_Sqft
)
SELECT 
	Sale_Date,
	Address,
	CASE WHEN UPPER(TRIM(Town)) = 'NewHaven' THEN 'New Haven'
		WHEN UPPER(TRIM(Town)) = 'Hartfrod' THEN 'Hartford'
		WHEN UPPER(TRIM(Town)) = 'Bridge port' THEN 'Bridgeport'
	ELSE Town 
	END AS Town,
	Property_Type,
	Bedrooms,
	Square_Feet,
	Sale_Price,
	ROUND(Sale_Price / NULLIF(Square_Feet, 0), 2) AS Price_per_Sqft
FROM dbo.Real_Estate_Data;

SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) 
              + ' seconds';
        PRINT '>> --------------------';

        SET @batch_end_time = GETDATE();

        PRINT '=========================================================';
        PRINT 'Loading Clean Real Estate Table is Completed';
        PRINT ' - Total Load Duration: ' 
              + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) 
              + ' seconds';
        PRINT '=========================================================';

    END TRY
    BEGIN CATCH
        PRINT '==================================================';
        PRINT 'ERROR OCCURRED DURING DATA CLEANING';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================================';
    END CATCH

END;
