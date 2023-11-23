SELECT *
FROM automobile.sales;

-- 1. What is the distribution of Quantity Ordered?
SELECT t1.QuantityOrdered, t1.Count, t2.AverageQuantityOrdered, t3.MinimumQuantityOrdered, t3.MaximumQuantityOrdered, t4.STDQuantityOrdered
FROM (
    SELECT QuantityOrdered, COUNT(*) AS Count
    FROM automobile.sales
    GROUP BY QuantityOrdered
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(QuantityOrdered) AS AverageQuantityOrdered
    FROM automobile.sales
) AS t2
JOIN (
    SELECT MIN(QuantityOrdered) AS MinimumQuantityOrdered, MAX(QuantityOrdered) AS MaximumQuantityOrdered
    FROM automobile.sales
) AS t3
JOIN (
    SELECT STD(QuantityOrdered) AS STDQuantityOrdered
    FROM automobile.sales
) AS t4;

-- 2. What is the distribution of Price?
SELECT t1.Price, t1.Count, t2.AveragePrice, t3.MinimumPrice, t3.MaximumPrice, t4.STDPrice
FROM (
    SELECT Price, COUNT(*) AS Count
    FROM automobile.sales
    GROUP BY Price
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(Price) AS AveragePrice
    FROM automobile.sales
) AS t2
JOIN (
    SELECT MIN(Price) AS MinimumPrice, MAX(Price) AS MaximumPrice
    FROM automobile.sales
) AS t3
JOIN (
    SELECT STD(Price) AS STDPrice
    FROM automobile.sales
) AS t4;

-- 3. What is the distribution for Order Line Number?
SELECT t1.OrderLineNumber, t1.Count, t2.AverageOrderLineNumber, t3.MinimumOrderLineNumber, t3.MaximumOrderLineNumber, t4.STDOrderLineNumber
FROM (
    SELECT OrderLineNumber, COUNT(*) AS Count
    FROM automobile.sales
    GROUP BY OrderLineNumber
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(OrderLineNumber) AS AverageOrderLineNumber
    FROM automobile.sales
) AS t2
JOIN (
    SELECT MIN(OrderLineNumber) AS MinimumOrderLineNumber, MAX(OrderLineNumber) AS MaximumOrderLineNumber
    FROM automobile.sales
) AS t3
JOIN (
    SELECT STD(OrderLineNumber) AS STDOrderLineNumber
    FROM automobile.sales
) AS t4;

-- 4. What is the distribution for MSRP?
SELECT t1.MSRP, t1.Count, t2.AverageMSRP, t3.MinimumMSRP, t3.MaximumMSRP, t4.STDMSRP
FROM (
    SELECT MSRP, COUNT(*) AS Count
    FROM automobile.sales
    GROUP BY MSRP
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(MSRP) AS AverageMSRP
    FROM automobile.sales
) AS t2
JOIN (
    SELECT MIN(MSRP) AS MinimumMSRP, MAX(MSRP) AS MaximumMSRP
    FROM automobile.sales
) AS t3
JOIN (
    SELECT STD(MSRP) AS STDMSRP
    FROM automobile.sales
) AS t4;

-- 5. What is the distribution for Status?
SELECT Status, COUNT(*) AS Count
FROM automobile.sales
GROUP BY Status
ORDER BY Count DESC;

-- 6. What is the distribution for Product Line?
SELECT ProductLine, COUNT(*) AS Count
FROM automobile.sales
GROUP BY ProductLine
ORDER BY Count DESC;

-- 7. What is the distribution of Deal Size in percentage?
SELECT DealSize, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM automobile.sales)), 1) AS Percentage
FROM automobile.sales
GROUP BY DealSize
ORDER BY Percentage DESC;

-- 8. What is the distribution for Countries and Cities?
SELECT Country, COUNT(*) AS Count
FROM automobile.sales
GROUP BY Country
ORDER BY Count DESC;

SELECT City, COUNT(*) AS Count
FROM automobile.sales
GROUP BY City
ORDER BY Count DESC;

-- 9. What is the distribution for Customers? Who is the most frequent buyer/s?
SELECT CustomerName, COUNT(*) AS Count
FROM automobile.sales
GROUP BY CustomerName
ORDER BY Count DESC;

-- 10. What is the distribution of Sales according to Deal Size?
SELECT DealSize, COUNT(*) AS Count, SUM(Sales) AS TotalSales, AVG(Sales) AS AverageSales
FROM automobile.sales
GROUP BY DealSize
ORDER BY TotalSales DESC;

-- 11. What is the distribution of Sales according to Product Line?
SELECT ProductLine, COUNT(*) AS Count, SUM(Sales) AS TotalSales, AVG(Sales) AS AverageSales
FROM automobile.sales
GROUP BY ProductLine
ORDER BY TotalSales DESC;

-- Deal Size Breakdown
-- Determining which is the best selling/performing product.
-- Total Sales by Product Line 
SELECT 
    ProductLine, DealSize, ROUND(SUM(Sales), 2) AS TotalSales
FROM automobile.sales
GROUP BY ProductLine, DealSize
ORDER BY TotalSales DESC;

-- Total Quantity Ordered by Product Line
SELECT 
    ProductLine, DealSize, ROUND(SUM(QuantityOrdered), 2) AS TotalQuantityOrdered
FROM automobile.sales
GROUP BY ProductLine, DealSize
ORDER BY TotalQuantityOrdered DESC;

-- Average Price by Product Line
SELECT 
    ProductLine, DealSize, ROUND(AVG(Price), 2) AS AveragePrice
FROM automobile.sales
GROUP BY ProductLine, DealSize
ORDER BY AveragePrice DESC;

-- Average MSRP by Product Line
SELECT 
    ProductLine, DealSize, ROUND(AVG(MSRP), 2) AS AverageMSRP
FROM automobile.sales
GROUP BY ProductLine, DealSize
ORDER BY AverageMSRP DESC;

-- Sales Analysis
-- Sales Distribution
SELECT t1.Sales, t1.Count, t2.AverageSales, t3.MinimumSales, t3.MaximumSales, t4.STDSales
FROM (
    SELECT Sales, COUNT(*) AS Count
    FROM automobile.sales
    GROUP BY Sales
    ORDER BY Count DESC
) AS t1
JOIN (
    SELECT AVG(Sales) AS AverageSales
    FROM automobile.sales
) AS t2
JOIN (
    SELECT MIN(Sales) AS MinimumSales, MAX(Sales) AS MaximumSales
    FROM automobile.sales
) AS t3
JOIN (
    SELECT STD(Sales) AS STDSales
    FROM automobile.sales
) AS t4;

-- Total Sales by Prodcut Line over the Years
SELECT 
    ProductLine, YEAR(OrderDate) AS Year, ROUND(SUM(Sales), 2) AS TotalSales
FROM automobile.sales
GROUP BY ProductLine, Year
ORDER BY TotalSales DESC;

-- Total Sales by Deal Size over the Years
SELECT 
    DealSize, YEAR(OrderDate) AS Year, ROUND(SUM(Sales), 2) AS TotalSales
FROM automobile.sales
GROUP BY DealSize, Year
ORDER BY TotalSales DESC;
