-- Create Database
CREATE DATABASE SupplyChainFinanceManagement;
GO

USE SupplyChainFinanceManagement;
GO

-- =========================
-- Create Tables
-- =========================
CREATE TABLE dim_customer (
    customer_code INT PRIMARY KEY,
    customer NVARCHAR(150),
    platform NVARCHAR(45),
    channel NVARCHAR(45),
    market NVARCHAR(45),
    sub_zone NVARCHAR(45),
    region NVARCHAR(45)
);

CREATE TABLE dim_product (
    product_code NVARCHAR(45) PRIMARY KEY,
    division NVARCHAR(45),
    segment NVARCHAR(45),
    category NVARCHAR(45),
    product NVARCHAR(200),
    variant NVARCHAR(45)
);

CREATE TABLE fact_forecast_monthly (
    [date] DATE,
    fiscal_year INT CHECK (fiscal_year BETWEEN 2000 AND 2100),
    product_code NVARCHAR(45),
    customer_code INT,
    forecast_quantity INT,
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);

CREATE TABLE fact_freight_cost (
    market NVARCHAR(45),
    fiscal_year INT CHECK (fiscal_year BETWEEN 2000 AND 2100),
    freight_pct DECIMAL(5,4),
    other_cost_pct DECIMAL(5,4)
);

CREATE TABLE fact_gross_price (
    product_code NVARCHAR(45),
    fiscal_year INT CHECK (fiscal_year BETWEEN 2000 AND 2100),
    gross_price DECIMAL(15,4),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_manufacturing_cost (
    product_code NVARCHAR(45),
    cost_year INT CHECK (cost_year BETWEEN 2000 AND 2100),
    manufacturing_cost DECIMAL(15,4),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_post_invoice_deductions (
    customer_code INT,
    product_code NVARCHAR(45),
    [date] DATE,
    discounts_pct DECIMAL(5,4),
    other_deductions_pct DECIMAL(5,4),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT,
    fiscal_year INT CHECK (fiscal_year BETWEEN 2000 AND 2100),
    pre_invoice_discount_pct DECIMAL(5,4),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);

CREATE TABLE fact_sales_monthly (
    [date] DATE,
    product_code NVARCHAR(45),
    customer_code INT,
    sold_quantity INT,
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);

-- =========================
-- Insert Data
-- =========================

-- Insert into dim_customer 
INSERT INTO dim_customer VALUES
(70020104, 'Atliq e Store', 'E-Commerce', 'Direct', 'Austria', 'NE', 'EU'),
(70021096, 'Atliq e Store', 'E-Commerce', 'Direct', 'United Kingdom', 'NE', 'EU'),
(70022084, 'Atliq Exclusive', 'Brick & Mortar', 'Direct', 'USA', 'NA', 'NA'),
(70022085, 'Atliq e Store', 'E-Commerce', 'Direct', 'USA', 'NA', 'NA'),
(70023031, 'Atliq Exclusive', 'Brick & Mortar', 'Direct', 'Canada', 'NA', 'NA'),
(70023032, 'Atliq e Store', 'E-Commerce', 'Direct', 'Canada', 'NA', 'NA'),
(70026206, 'Atliq e Store', 'E-Commerce', 'Direct', 'Mexico', 'LATAM', 'LATAM'),
(70027208, 'Atliq e Store', 'E-Commerce', 'Direct', 'Brazil', 'LATAM', 'LATAM'),
(80001019, 'Neptune', 'Brick & Mortar', 'Distributor', 'China', 'ROA', 'APAC'),
(80006154, 'Synthetic', 'Brick & Mortar', 'Distributor', 'Philippines', 'ROA', 'APAC'),
(80006155, 'Novus', 'Brick & Mortar', 'Distributor', 'Philippines', 'ROA', 'APAC'),
(70002017, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70002018, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70003181, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70003182, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70006157, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70006158, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70007198, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70007199, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70008169, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70008170, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown'),
(70011193, 'Unknown Customer', 'E-Commerce', 'Direct', 'Unknown', 'Unknown', 'Unknown');

-- Insert into dim_product 
INSERT INTO dim_product VALUES
('A1919150403', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito', 'Plus 2'),
('A1920150404', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito', 'Premium'),
('A2020150501', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito 2', 'Standard'),
('A2020150502', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito 2', 'Plus 1'),
('A2021150503', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito 2', 'Plus 2'),
('A2021150504', 'P & A', 'Peripherals', 'MotherBoard', 'AQ MB Lito 2', 'Premium'),
('A2118150101', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Standard 1'),
('A2118150102', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Standard 2'),
('A2118150103', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Plus 1'),
('A2118150104', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Plus 2'),
('A2118150105', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Premium 1'),
-- Missing products for fact tables
('A0118150101', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Standard 1'),
('A0118150102', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Standard 2'),
('A0118150103', 'P & A', 'Accessories', 'Mouse', 'AQ Master wired x1 Ms', 'Plus 1');

-- Insert into fact_freight_cost
INSERT INTO fact_freight_cost VALUES
('Germany', 2020, 0.0226, 0.0060),
('Germany', 2021, 0.0226, 0.0060),
('Germany', 2022, 0.0226, 0.0060),
('India', 2018, 0.0244, 0.0026),
('India', 2019, 0.0219, 0.0057),
('India', 2020, 0.0309, 0.0029),
('India', 2021, 0.0309, 0.0029),
('India', 2022, 0.0309, 0.0029),
('Indonesia', 2018, 0.0190, 0.0042),
('Indonesia', 2019, 0.0187, 0.0052);

-- Insert into fact_gross_price
INSERT INTO fact_gross_price VALUES
('A0118150101', 2018, 15.3952),
('A0118150101', 2019, 14.4392),
('A0118150101', 2020, 16.2323),
('A0118150101', 2021, 19.0573),
('A0118150102', 2018, 19.5875),
('A0118150102', 2019, 18.5595),
('A0118150102', 2020, 19.8577),
('A0118150102', 2021, 21.4565),
('A0118150103', 2018, 19.3630),
('A0118150103', 2019, 19.3442),
('A0118150103', 2020, 22.1317);

-- Insert into fact_manufacturing_cost
INSERT INTO fact_manufacturing_cost VALUES
('A0118150101', 2018, 4.6190),
('A0118150101', 2019, 4.2033),
('A0118150101', 2020, 5.0207),
('A0118150101', 2021, 5.5172),
('A0118150102', 2018, 5.6036),
('A0118150102', 2019, 5.3235),
('A0118150102', 2020, 5.7180),
('A0118150102', 2021, 6.2835),
('A0118150103', 2018, 5.9469),
('A0118150103', 2019, 5.5306),
('A0118150103', 2020, 6.3264);

-- Insert into fact_post_invoice_deductions
INSERT INTO fact_post_invoice_deductions VALUES
(70002017, 'A0118150101', '2017-09-01', 0.2660, 0.0719),
(70002017, 'A0118150101', '2017-10-01', 0.3090, 0.0976),
(70002017, 'A0118150101', '2017-11-01', 0.3313, 0.0752),
(70002017, 'A0118150101', '2018-01-01', 0.2958, 0.0720),
(70002017, 'A0118150101', '2018-02-01', 0.3208, 0.0793),
(70002017, 'A0118150101', '2018-03-01', 0.2635, 0.1007),
(70002017, 'A0118150101', '2018-05-01', 0.2231, 0.0820),
(70002017, 'A0118150101', '2018-06-01', 0.3020, 0.0791),
(70002017, 'A0118150101', '2018-07-01', 0.3123, 0.0929),
(70002017, 'A0118150101', '2018-09-01', 0.1530, 0.1288),
(70002017, 'A0118150101', '2018-10-01', 0.1363, 0.1542);

-- Insert into fact_pre_invoice_deductions
INSERT INTO fact_pre_invoice_deductions VALUES
(70002017, 2018, 0.0824),
(70002017, 2019, 0.0777),
(70002017, 2020, 0.0735),
(70002017, 2021, 0.0703),
(70002017, 2022, 0.1057),
(70002018, 2018, 0.2956),
(70002018, 2019, 0.2577),
(70002018, 2020, 0.2255),
(70002018, 2021, 0.2061),
(70002018, 2022, 0.2931),
(70003181, 2018, 0.0536);

-- Insert into fact_sales_monthly
INSERT INTO fact_sales_monthly VALUES
('2017-09-01', 'A0118150101', 70002017, 51),
('2017-09-01', 'A0118150101', 70002018, 77),
('2017-09-01', 'A0118150101', 70003181, 17),
('2017-09-01', 'A0118150101', 70003182, 6),
('2017-09-01', 'A0118150101', 70006157, 5),
('2017-09-01', 'A0118150101', 70006158, 7),
('2017-09-01', 'A0118150101', 70007198, 29),
('2017-09-01', 'A0118150101', 70007199, 34),
('2017-09-01', 'A0118150101', 70008169, 22),
('2017-09-01', 'A0118150101', 70008170, 5),
('2017-09-01', 'A0118150101', 70011193, 10);
/*
Q1) Assume calendar_date is '2023-07-15'. Apply the function to
this date and explain what value it will return as the fiscal year.
Q2) Analyzing Gross Sales: Monthly Product Transactions
Report
Write a Query for making report on monthly product
transactions, including details such as date, product code,
product name, variant, sold quantity, gross price, and gross price
total. The query should involves joining several tables and
filtering results based on customer code and fiscal year.
*/

CREATE FUNCTION dbo.GetFiscalYear (@calendar_date DATE)
RETURNS INT
AS
BEGIN
    DECLARE @month INT = MONTH(@calendar_date);
    DECLARE @year INT = YEAR(@calendar_date);

    IF @month >= 9
        SET @year = @year + 1;

    RETURN @year;
END;
SELECT dbo.GetFiscalYear('2023-07-15') AS FiscalYear;

SELECT
    fsm.[date],
    fsm.product_code,
    dp.product AS product_name,
    dp.variant,
    fsm.sold_quantity,
    fgp.gross_price,
    (fsm.sold_quantity * fgp.gross_price) AS gross_price_total
FROM fact_sales_monthly AS fsm
INNER JOIN dim_product AS dp
    ON fsm.product_code = dp.product_code
INNER JOIN fact_gross_price AS fgp
    ON fsm.product_code = fgp.product_code
    AND fgp.fiscal_year = CASE 
                              WHEN MONTH(fsm.[date]) >= 9 THEN YEAR(fsm.[date]) + 1
                              ELSE YEAR(fsm.[date])
                          END
WHERE fsm.customer_code = 70002017  -- Example filter
  AND fgp.fiscal_year = 2018        -- Example fiscal year filter
ORDER BY fsm.[date], fsm.product_code;
/*
Sales Trend Analysis:
Query the fact_monthly_sales table to identify the monthly sales
trend for each product. How do the sales volumes fluctuate over
time?
*/
SELECT
    FORMAT([date], 'yyyy-MM') AS Month,
    product_code,
    SUM(sold_quantity) AS Total_Sales
FROM fact_sales_monthly
GROUP BY FORMAT([date], 'yyyy-MM'), product_code
ORDER BY Month, product_code;

/*
Utilizing the dim_customer table, segment customers based on
their purchasing behavior. Which customer segments contribute
the most to sales revenue?*/SELECT
    dc.customer_code,
    dc.customer,
    dc.platform,
    dc.channel,
    SUM(fsm.sold_quantity * fgp.gross_price) AS Total_Revenue
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
    AND fgp.fiscal_year = CASE WHEN MONTH(fsm.[date]) >= 9 THEN YEAR(fsm.[date]) + 1 ELSE YEAR(fsm.[date]) END
GROUP BY dc.customer_code, dc.customer, dc.platform, dc.channel
ORDER BY Total_Revenue DESC;

/*
Compare the performance of products in terms of sales quantity
and revenue generated. Which products are the top performers,
and which ones need improvement?
*/

SELECT
    dp.product_code,
    dp.product,
    SUM(fsm.sold_quantity) AS Total_Quantity,
    SUM(fsm.sold_quantity * fgp.gross_price) AS Total_Revenue
FROM fact_sales_monthly fsm
JOIN dim_product dp ON fsm.product_code = dp.product_code
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
    AND fgp.fiscal_year = CASE WHEN MONTH(fsm.[date]) >= 9 THEN YEAR(fsm.[date]) + 1 ELSE YEAR(fsm.[date]) END
GROUP BY dp.product_code, dp.product
ORDER BY Total_Revenue DESC;

/*
Analyze the fact_forecast_monthly table to identify potential
market expansion opportunities. Which markets show the highest
forecasted demand growth?
*/

SELECT
    dc.market,
    SUM(ffm.forecast_quantity) AS Total_Forecast
FROM fact_forecast_monthly ffm
JOIN dim_customer dc ON ffm.customer_code = dc.customer_code
GROUP BY dc.market
ORDER BY Total_Forecast DESC;
/*
1. Define a user-defined function to calculate the total
forecasted quantity for a given product and fiscal year.*/

CREATE FUNCTION dbo.GetTotalForecastQuantity
(@product_code NVARCHAR(45), @fiscal_year INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;
    SELECT @total = SUM(forecast_quantity)
    FROM fact_forecast_monthly
    WHERE product_code = @product_code AND fiscal_year = @fiscal_year;
    RETURN ISNULL(@total, 0);
END;
GO

-- Test:
SELECT dbo.GetTotalForecastQuantity('A0118150101', 2018) AS TotalForecast;
/*
2. Write a query to find the customers who made purchases
exceeding the average monthly sales quantity across all
products
*/
SELECT customer_code, SUM(sold_quantity) AS Total_Sales
FROM fact_sales_monthly
GROUP BY customer_code
HAVING SUM(sold_quantity) > (
    SELECT AVG(sold_quantity) FROM fact_sales_monthly
);
/*
Create a stored procedure to update the gross price of a
product for a specific fiscal year.
*/

CREATE PROCEDURE dbo.UpdateGrossPrice
    @product_code NVARCHAR(45),
    @fiscal_year INT,
    @new_price DECIMAL(15,4)
AS
BEGIN
    UPDATE fact_gross_price
    SET gross_price = @new_price
    WHERE product_code = @product_code AND fiscal_year = @fiscal_year;
END;
GO

-- Execute:
EXEC dbo.UpdateGrossPrice 'A0118150101', 2018, 20.5000;
/*
Implement a trigger that automatically inserts a record into
the audit log table whenever a new entry is added to the
sales table.
*/

CREATE TABLE audit_log (
    log_id INT IDENTITY PRIMARY KEY,
    action NVARCHAR(50),
    product_code NVARCHAR(45),
    customer_code INT,
    sold_quantity INT,
    action_date DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_AuditSalesInsert
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (action, product_code, customer_code, sold_quantity)
    SELECT 'INSERT', product_code, customer_code, sold_quantity FROM inserted;
END;
/*
5. Use a window function to rank products based on their
monthly sales quantity, partitioned by fiscal year.
*/
SELECT
    product_code,
    SUM(sold_quantity) AS Total_Sales,
    RANK() OVER (PARTITION BY YEAR([date]) ORDER BY SUM(sold_quantity) DESC) AS RankInYear
FROM fact_sales_monthly
GROUP BY product_code, YEAR([date]);
/*
Utilize the STRING_AGG function to concatenate the
names of all customers who purchased a specific product
within a given timeframe.
*/
SELECT
    product_code,
    STRING_AGG(dc.customer, ', ') AS Customers
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
WHERE product_code = 'A0118150101'
GROUP BY product_code;

/*
Develop a user-defined function that calculates the total
manufacturing cost for a product over a specified range of
years, using a subquery to retrieve the necessary data.
*/
CREATE FUNCTION dbo.GetTotalManufacturingCost
(@product_code NVARCHAR(45), @start_year INT, @end_year INT)
RETURNS DECIMAL(15,4)
AS
BEGIN
    DECLARE @total DECIMAL(15,4);
    SELECT @total = SUM(manufacturing_cost)
    FROM fact_manufacturing_cost
    WHERE product_code = @product_code AND cost_year BETWEEN @start_year AND @end_year;
    RETURN ISNULL(@total, 0);
END;
/*
Design a stored procedure to insert new records into the
sales table and use a trigger to enforce constraints on the
quantity sold, ensuring it doesn't exceed the available
inventory.
*/
CREATE TRIGGER trg_CheckQuantity
ON fact_sales_monthly
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE sold_quantity > 1000)
    BEGIN
        RAISERROR('Quantity exceeds allowed limit!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO fact_sales_monthly SELECT * FROM inserted;
    END
END;
/*
9. Apply the LEAD or LAG function to compare monthly
sales quantities of a product with the previous month's
sales.
*/
SELECT
    product_code,
    [date],
    sold_quantity,
    LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date]) AS PreviousMonthSales,
    (sold_quantity - LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date])) AS Difference
FROM fact_sales_monthly;

/*
10. Create a query to identify the top-selling products in
each market based on their total sales quantity, utilizing
subqueries and window functions.
*/
SELECT
    dc.market,
    dp.product,
    SUM(fsm.sold_quantity) AS Total_Sales,
    RANK() OVER (PARTITION BY dc.market ORDER BY SUM(fsm.sold_quantity) DESC) AS RankInMarket
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN dim_product dp ON fsm.product_code = dp.product_code
GROUP BY dc.market, dp.product;

/*
11. Develop a user-defined function to calculate the total
freight cost for a product based on its market and fiscal
year. Then, integrate this function into a stored procedure to
update the overall cost.*/CREATE FUNCTION dbo.GetTotalFreightCost
(@market NVARCHAR(45), @fiscal_year INT)
RETURNS DECIMAL(15,4)
AS
BEGIN
    DECLARE @total DECIMAL(15,4);
    SELECT @total = SUM(freight_pct)
    FROM fact_freight_cost
    WHERE market = @market AND fiscal_year = @fiscal_year;
    RETURN ISNULL(@total, 0);
END;
/*
12. Write a trigger that automatically updates the
inventory count in the product table whenever a new sale is
recorded, utilizing inbuilt functions to perform the
calculation.*/ALTER TABLE dim_product ADD inventory_count INT DEFAULT 1000;CREATE TRIGGER trg_UpdateInventory
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    UPDATE dp
    SET inventory_count = inventory_count - i.sold_quantity
    FROM dim_product dp
    JOIN inserted i ON dp.product_code = i.product_code;
END;/*13. Implement a trigger to enforce referential integrity,
ensuring that only products listed in the product table can be
added to the sales table, utilizing subqueries to validate the
data.*/CREATE TRIGGER trg_ValidateProduct
ON fact_sales_monthly
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        WHERE NOT EXISTS (SELECT 1 FROM dim_product dp WHERE dp.product_code = i.product_code)
    )
    BEGIN
        RAISERROR('Invalid product code!', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO fact_sales_monthly SELECT * FROM inserted;
    END
END;
/*
14. Design a stored procedure to generate a report showing
the month-over-month growth rate of sales for each
product, using window functions to calculate the percentage
change.
*/
CREATE PROCEDURE dbo.MonthlyGrowthReport
AS
BEGIN
    SELECT 
        product_code,
        [date],
        sold_quantity,
        LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date]) AS PreviousMonth,
        CASE 
            WHEN LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date]) = 0 THEN NULL
            ELSE ((sold_quantity - LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date])) * 100.0 /
                  LAG(sold_quantity, 1) OVER (PARTITION BY product_code ORDER BY [date]))
        END AS GrowthPercent
    FROM fact_sales_monthly;
END;
/*
15. Develop a user-defined function to calculate the
average discount percentage given to customers for a
specific product, utilizing inbuilt functions to aggregate and
analyze the data.
*/
CREATE FUNCTION dbo.GetAverageDiscount
(@product_code NVARCHAR(45))
RETURNS DECIMAL(5,4)
AS
BEGIN
    DECLARE @avg DECIMAL(5,4);
    SELECT @avg = AVG(discounts_pct)
    FROM fact_post_invoice_deductions
    WHERE product_code = @product_code;
    RETURN ISNULL(@avg, 0);
end;

SELECT
    dc.region,
    dc.customer,
    SUM(fsm.sold_quantity) AS Total_Sales,
    RANK() OVER (PARTITION BY dc.region ORDER BY SUM(fsm.sold_quantity) DESC) AS RankInRegion
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
GROUP BY dc.region, dc.customer;
/*
16. Write a query to identify the customers who made the
highest total purchases in each region, using subqueries and
window functions to perform the analysis.
*/
SELECT
    dc.region,
    dc.customer,
    SUM(fsm.sold_quantity) AS Total_Sales,
    RANK() OVER (PARTITION BY dc.region ORDER BY SUM(fsm.sold_quantity) DESC) AS RankInRegion
FROM fact_sales_monthly fsm
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
GROUP BY dc.region, dc.customer;
/*
17. Create a stored procedure to calculate the total revenue
generated from sales for a given period, using inbuilt
functions to handle date manipulation and aggregation.

*/
CREATE PROCEDURE dbo.GetTotalRevenue
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SELECT SUM(fsm.sold_quantity * fgp.gross_price) AS TotalRevenue
    FROM fact_sales_monthly fsm
    JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
        AND fgp.fiscal_year = CASE WHEN MONTH(fsm.[date]) >= 9 THEN YEAR(fsm.[date]) + 1 ELSE YEAR(fsm.[date]) END
    WHERE fsm.[date] BETWEEN @start_date AND @end_date;
END;
/*
18. Implement a trigger to automatically update the
forecasted quantity in the forecast table whenever a new
product is added to the product table, utilizing a userdefined function to calculate the forecast
*/
CREATE TRIGGER trg_UpdateForecastOnNewProduct
ON dim_product
AFTER INSERT
AS
BEGIN
    INSERT INTO fact_forecast_monthly ([date], fiscal_year, product_code, customer_code, forecast_quantity)
    SELECT GETDATE(), YEAR(GETDATE()), product_code, 70002017, 10 FROM inserted;
END;
/*
19. Develop a trigger to identify outliers in the monthly
sales data and flag them for further investigation, leveraging
window functions to detect deviations from the expected
sales patterns.
*/
CREATE TRIGGER trg_FlagOutliers
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (action, product_code, customer_code, sold_quantity)
    SELECT 'OUTLIER', product_code, customer_code, sold_quantity
    FROM inserted
    WHERE sold_quantity > (SELECT AVG(sold_quantity) * 2 FROM fact_sales_monthly);
END;
/*
20. Write a query to retrieve the products with the highest
average gross price across all fiscal years, using subqueries
and inbuilt functions to perform the analysis*/SELECT TOP 1
    product_code,
    AVG(gross_price) AS AvgGrossPrice
FROM fact_gross_price
GROUP BY product_code
ORDER BY AvgGrossPrice DESC;
/*
Aanalyze the monthly forecast accuracy for a specific product
over multiple fiscal years.
Question:
Write a SQL query that calculates the forecast accuracy for a
given product over different fiscal years.
Utilize Pivot table functionality to present the forecast quantity
and actual sold quantity side by side for each month within a
fiscal year.
Calculate forecast accuracy as the percentage of actual sold
quantity compared to forecast quantity.
Interpret the results to identify months with high or low forecast
accuracy and provide possible reasons for the discrepancies.
Include considerations for handling missing or incomplete data
in the analysis.
*/
SELECT
    FiscalYear,
    MonthName,
    ForecastQty,
    ActualSoldQty,
    CASE 
        WHEN ForecastQty = 0 THEN NULL
        ELSE ROUND((ActualSoldQty * 100.0 / ForecastQty), 2)
    END AS ForecastAccuracyPercent
FROM (
    SELECT 
        CASE 
            WHEN MONTH(ffm.[date]) >= 9 THEN YEAR(ffm.[date]) + 1
            ELSE YEAR(ffm.[date])
        END AS FiscalYear,
        DATENAME(MONTH, ffm.[date]) AS MonthName,
        SUM(ffm.forecast_quantity) AS ForecastQty,
        SUM(fsm.sold_quantity) AS ActualSoldQty
    FROM fact_forecast_monthly ffm
    LEFT JOIN fact_sales_monthly fsm
        ON ffm.product_code = fsm.product_code
        AND ffm.customer_code = fsm.customer_code
        AND ffm.[date] = fsm.[date]
    WHERE ffm.product_code = 'A0118150101'  -- Example product
    GROUP BY CASE 
                 WHEN MONTH(ffm.[date]) >= 9 THEN YEAR(ffm.[date]) + 1
                 ELSE YEAR(ffm.[date])
             END,
             DATENAME(MONTH, ffm.[date])
) AS Data
ORDER BY FiscalYear, MonthName;

SELECT FiscalYear,
       [January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December]
FROM (
    SELECT 
        CASE WHEN MONTH(ffm.[date]) >= 9 THEN YEAR(ffm.[date]) + 1 ELSE YEAR(ffm.[date]) END AS FiscalYear,
        DATENAME(MONTH, ffm.[date]) AS MonthName,
        ROUND((ISNULL(fsm.sold_quantity, 0) * 100.0 / NULLIF(ffm.forecast_quantity, 0)), 2) AS ForecastAccuracyPercent
    FROM fact_forecast_monthly ffm
    LEFT JOIN fact_sales_monthly fsm
        ON ffm.product_code = fsm.product_code
        AND ffm.customer_code = fsm.customer_code
        AND ffm.[date] = fsm.[date]
    WHERE ffm.product_code = 'A0118150101'
) AS SourceData
PIVOT (
    AVG(ForecastAccuracyPercent)
    FOR MonthName IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
) AS PivotTable
ORDER BY FiscalYear;