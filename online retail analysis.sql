 
SELECT *
INTO Cleaned_online_retail
FROM online_retail;


SELECT COUNT(*) AS RawRows
FROM online_retail ;

SELECT COUNT(*) AS CleanedRows
FROM Cleaned_online_retail;

select top 10 * from Cleaned_online_retail

---------checking for duplicates 
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    COUNT(*) AS duplicate_count
FROM Cleaned_online_retail
GROUP BY
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
HAVING COUNT(*) > 1;

------------- to check the nulls
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN InvoiceNo IS NULL OR InvoiceNo = '' THEN 1 ELSE 0 END) AS missing_invoice,
    SUM(CASE WHEN StockCode IS NULL OR StockCode = '' THEN 1 ELSE 0 END) AS missing_stockcode,
    SUM(CASE WHEN Description IS NULL OR Description = '' THEN 1 ELSE 0 END) AS missing_description,
    SUM(CASE WHEN InvoiceDate IS NULL OR InvoiceDate = '' THEN 1 ELSE 0 END) AS missing_date,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer,
    SUM(CASE WHEN Country IS NULL OR Country = '' THEN 1 ELSE 0 END) AS missing_country
FROM Cleaned_online_retail;

---------------- to check whether the stock is null too
SELECT TOP 20
    StockCode,
    Description,
    Quantity,
    UnitPrice,
    InvoiceNo,
    CustomerID
FROM online_retail
WHERE Description IS NULL
   OR LTRIM(RTRIM(Description)) = '';

-------------- to check returns/ cancellation

SELECT
    COUNT(*) AS return_rows
FROM Cleaned_online_retail
WHERE InvoiceNo LIKE 'C%';

SELECT
    COUNT(DISTINCT InvoiceNo) AS return_orders
FROM online_retail
WHERE InvoiceNo LIKE 'C%';

------------- handleling negative values

SELECT
    COUNT(*) AS negative_quantity_rows
FROM Cleaned_online_retail
WHERE Quantity <= 0
or UnitPrice <=0

delete from Cleaned_online_retail
WHERE Quantity <= 0
or UnitPrice <=0;

---------------- checking invalid dates

SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN TRY_CONVERT(datetime2, InvoiceDate, 103) IS NULL
            THEN 1
            ELSE 0
        END
    ) AS invalid_dates
FROM Cleaned_online_retail;


--------total rows
SELECT COUNT(*) AS total_rows
FROM Cleaned_online_retail;

------------ total revenue 

SELECT
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail;

----------- total orders

SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail;

------------total customers

SELECT
    COUNT(DISTINCT CustomerID) AS total_customers
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL;


------------total products 

SELECT
    COUNT(DISTINCT StockCode) AS total_products
FROM cleaned_online_retail;

-----------total countries 

SELECT
    COUNT(DISTINCT Country) AS total_countries
FROM cleaned_online_retail;

------------- revenue by month 

SELECT
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    ) AS month,
    SUM(Revenue) AS revenue
FROM cleaned_online_retail
GROUP BY
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    )
ORDER BY month;

-----------avg order value 

SELECT
    AVG(order_revenue) AS average_order_value
FROM
(
    SELECT
        InvoiceNo,
        SUM(Revenue) AS order_revenue
    FROM cleaned_online_retail
    GROUP BY InvoiceNo
) AS orders;

-----------Top 10 Customers by Revenue

SELECT TOP 10
    CustomerID,
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC;

-----------Top 10 Products by Revenue

SELECT TOP 10
    StockCode,
    Description,
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail
GROUP BY
    StockCode,
    Description
ORDER BY total_revenue DESC;

-------------Top 10 Products by Units Sold

SELECT TOP 10
    StockCode,
    Description,
    SUM(Quantity) AS units_sold
FROM cleaned_online_retail
GROUP BY
    StockCode,
    Description
ORDER BY units_sold DESC;

------------Revenue by Country

SELECT
    Country,
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail
GROUP BY Country
ORDER BY total_revenue DESC;

----------Top Countries by Customer Count

SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS customers
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY Country
ORDER BY customers DESC;

----------Top Countries by Number of Orders

SELECT
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
GROUP BY Country
ORDER BY total_orders DESC;

------------Repeat vs One-Time Customers

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers
FROM
(
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS order_count
    FROM cleaned_online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END;

-------------Customer Revenue

SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS orders,
    SUM(Quantity) AS units_purchased,
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC;

-----------Poor-Performing Products

SELECT TOP 20
    StockCode,
    Description,
    SUM(Quantity) AS units_sold,
    SUM(Revenue) AS total_revenue
FROM cleaned_online_retail
GROUP BY
    StockCode,
    Description
ORDER BY total_revenue ASC;

------------Orders by Month

SELECT
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    ) AS month,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
GROUP BY
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    )
ORDER BY month;

--------------Units Sold by Month

SELECT
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    ) AS month,
    SUM(Quantity) AS units_sold
FROM cleaned_online_retail
GROUP BY
    CONVERT(char(7),
        TRY_CONVERT(datetime2, InvoiceDate, 103),
        120
    )
ORDER BY month;

---------------Revenue Contribution by Country

SELECT
    Country,
    SUM(Revenue) AS revenue,
    ROUND(
        SUM(Revenue) * 100.0 /
        (SELECT SUM(Revenue)
         FROM cleaned_online_retail),
        2
    ) AS revenue_percentage
FROM cleaned_online_retail
GROUP BY Country
ORDER BY revenue DESC;

---------------Revenue Contribution of Top 10 Customers

SELECT TOP 10
    CustomerID,
    SUM(Revenue) AS revenue,
    ROUND(
        SUM(Revenue) * 100.0 /
        (SELECT SUM(Revenue)
         FROM cleaned_online_retail),
        2
    ) AS revenue_percentage
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY revenue DESC;





select * into dummy from Cleaned_online_retail

INSERT INTO dummy
(
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Transaction_Type,
    Revenue
)
SELECT DISTINCT
    r.InvoiceNo,
    r.StockCode,
    r.Description,
    r.Quantity,
    r.InvoiceDate,
    r.UnitPrice,
    r.CustomerID,
    r.Country,

    CASE
        WHEN r.InvoiceNo LIKE 'C%' THEN 'Return'
        ELSE 'Sale'
    END AS Transaction_Type,

    r.Quantity * r.UnitPrice AS Revenue

FROM online_retail r

WHERE r.InvoiceNo LIKE 'C%'
  AND r.Quantity < 0
  AND r.UnitPrice > 0

 
  AND NOT EXISTS
  (
      SELECT 1
      FROM dummy c
      WHERE c.InvoiceNo = r.InvoiceNo
        AND c.StockCode = r.StockCode
        AND ISNULL(c.Description, '') = ISNULL(r.Description, '')
        AND c.Quantity = r.Quantity
        AND c.InvoiceDate = r.InvoiceDate
        AND c.UnitPrice = r.UnitPrice
        AND ISNULL(c.CustomerID, 0) = ISNULL(r.CustomerID, 0)
        AND c.Country = r.Country
  );

  SELECT
    Transaction_Type,
    COUNT(*) AS rows
FROM dummy
GROUP BY Transaction_Type;

SELECT
    COUNT(*) AS return_rows,
    SUM(Quantity) AS return_quantity,
    SUM(Revenue) AS return_value
FROM dummy
WHERE Transaction_Type = 'Return';

SELECT COUNT(*) AS invalid_price_rows
FROM dummy
WHERE UnitPrice <= 0;


INSERT INTO cleaned_online_retail
(
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Transaction_Type,
    Revenue
)
SELECT DISTINCT
    r.InvoiceNo,
    r.StockCode,
    r.Description,
    r.Quantity,
    r.InvoiceDate,
    r.UnitPrice,
    r.CustomerID,
    r.Country,

    CASE
        WHEN r.InvoiceNo LIKE 'C%' THEN 'Return'
        ELSE 'Sale'
    END AS Transaction_Type,

    r.Quantity * r.UnitPrice AS Revenue

FROM online_retail r

WHERE r.InvoiceNo LIKE 'C%'
  AND r.Quantity < 0
  AND r.UnitPrice > 0

   
  AND NOT EXISTS
  (
      SELECT 1
      FROM cleaned_online_retail c
      WHERE c.InvoiceNo = r.InvoiceNo
        AND c.StockCode = r.StockCode
        AND ISNULL(c.Description, '') = ISNULL(r.Description, '')
        AND c.Quantity = r.Quantity
        AND c.InvoiceDate = r.InvoiceDate
        AND c.UnitPrice = r.UnitPrice
        AND ISNULL(c.CustomerID, 0) = ISNULL(r.CustomerID, 0)
        AND c.Country = r.Country
  );

  SELECT
    Transaction_Type,
    COUNT(*) AS rows
FROM cleaned_online_retail
GROUP BY Transaction_Type;

