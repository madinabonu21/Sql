--Easy-Level Tasks
--Using Products table, find the total number of products available in each category.

SELECT Category ,COUNT(*) AS Product_Count
FROM Products 
GROUP BY Category

--Using Products table, get the average price of products in the 'Electronics' category.

SELECT AVG(Price) AS AVG_PRICE 
FROM Products
WHERE Category = 'Electronics'


--Using Customers table, list all customers from cities that start with 'L'.

SELECT FirstName, City
FROM Customers 
WHERE City LIKE 'L%'

--Using Products table, get all product names that end with 'er'.

SELECT ProductName
FROM Products 
WHERE ProductName LIKE '%er'


--Using Customers table, list all customers from countries ending in 'A'.

SELECT FirstName , Country
FROM Customers
WHERE Country  LIKE '%A'

--Using Products table, show the highest price among all products.

SELECT MAX(Price) AS MAX_PRICE
FROM Products


--Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.

SELECT *,
CASE WHEN StockQuantity < 30  
THEN 'Low Stock'  
ELSE 'Sufficient'
END AS LABEL_STOCK
FROM Products


--Using Customers table, find the total number of customers in each country.
SELECT Country, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Country

--Using Orders table, find the minimum and maximum quantity ordered.

SELECT MIN(Quantity) AS MIN_ORDER ,MAX(Quantity) AS MAX_ORDER 
FROM Orders

--Medium-Level Tasks
--Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.

SELECT DISTINCT CustomerID
FROM Orders
WHERE OrderDate >= '2023-01-01' AND OrderDate < '2023-02-01'

EXCEPT

SELECT DISTINCT CustomerID
FROM Orders
WHERE OrderID IN (SELECT OrderIDFROM Invoices);


--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT ProductName
FROM Products

UNION ALL 
SELECT ProductName 
FROM Products_Discounted


--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT ProductName
FROM Products

UNION
SELECT ProductName 
FROM Products_Discounted

--Using Orders table, find the average order amount by year.

SELECT YEAR(OrderDate) AS ORDER_BY_YEAR , AVG(TotalAmount) AVG_AMOUNT
FROM Orders
GROUP BY YEAR(OrderDate)


--Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.

SELECT PRODUCTNAME ,
CASE WHEN Price < 100  THEN 'LOW' 
WHEN Price BETWEEN 100 AND 500 THEN 'MID' 
ELSE 'HIGH' END AS PRICE_GROUP
FROM Products

--Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.

SELECT *
INTO Population_Each_Year
FROM (
    SELECT district_name, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;

SELECT * FROM Population_Each_Year

--Using Sales table, find total sales per product Id.

SELECT ProductID, SUM(SaleAmount)
FROM Sales
GROUP BY ProductID

--Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT PRODUCTNAME
FROM Products
WHERE ProductName LIKE '%OO%' 

--Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.

SELECT * 
INTO Population_Each_City
FROM (SELECT district_name, Year, Population
	  FROM City_Population)
AS SOURCE_table
PIVOT (
    SUM(Population)
    FOR district_name IN ( [Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

SELECT *  FROM Population_Each_City

--Hard-Level Tasks
--Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY SUM(TotalAmount) DESC

--Transform Population_Each_Year table to its original format (City_Population).

SELECT district_name, Year, Population
FROM Population_Each_Year
UNPIVOT (
    Population FOR Year IN ([2012], [2013])
) AS UnpivotedResult;

--Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)

SELECT ProductName , COUNT(*) AS TimesSold
FROM Products AS P
JOIN Sales AS S 
ON P.ProductID= S.ProductID
GROUP BY ProductName 

--Transform Population_Each_City table to its original format (City_Population).
SELECT district_name, Year, Population
FROM Population_Each_City
UNPIVOT (
    Population FOR Year IN ([Bektemir], [Chilonzor],[Yakkasaroy])
) AS UnpivotedResult;
