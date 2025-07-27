-- lesson 7 
--Easy-Level Tasks (10)
-- TASK 1 Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT MIN(PRICE) FROM Products

-- TASK 2 Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT MAX(Salary) FROM Employees

-- TASK 3 Write a query to count the number of rows in the Customers table.

SELECT COUNT(*) AS number_of_rows FROM Customers

--TASK 4 Write a query to count the number of unique product categories from the Products table.

SELECT COUNT (DISTINCT Category ) AS UNIQUE_PRD_CTG FROM Products

-- TASK 5 Write a query to find the total sales amount for the product with id 7 in the Sales table.

SELECT SUM(SaleAmount) AS TOTAL_SALE_AMOUNT FROM Sales
WHERE ProductID=7

-- TASK 6 Write a query to calculate the average age of employees in the Employees table.

SELECT AVG(Age) AS AVG_AGE FROM Employees 

-- TASK 7 Write a query to count the number of employees in each department.
SELECT DepartmentName , COUNT(*) AS  EmployeeCount FROM Employees
GROUP BY DepartmentName

--TASK 8 Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT Category , MIN(Price) AS min_price ,MAX(Price) AS max_price FROM Products
GROUP BY Category 

-- TASK 9 Write a query to calculate the total sales per Customer in the Sales table.
SELECT CustomerID , COUNT (SaleAmount) AS NumberOfOrders , SUM(SaleAmount) AS TOTAL_SALE FROM Sales
GROUP BY CustomerID 

-- TASK 10 Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).

SELECT DepartmentName, COUNT(EmployeeID) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(EmployeeID) > 5;

--Medium-Level Tasks (9)
-- TASK 11 Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT PRODUCTID , COUNT(PRODUCTID) AS TOTAL , SUM( SaleAmount) AS TOTAL_SALE, AVG(SaleAmount) AS AVG_SALE FROM Sales
GROUP BY PRODUCTID 

--TASK 12 Write a query to count the number of employees from the Department HR.

SELECT COUNT(*) AS HR_EmployeeCount  FROM Employees
WHERE  DepartmentName = 'HR'

--TASK 13 Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).

SELECT DepartmentName , MIN(Salary) AS MIN_SALARY, MAX(Salary) AS MAX_SALARY FROM Employees 
GROUP BY DepartmentName  

-- TASK 14 Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).

SELECT DepartmentName , AVG(Salary) AS AVG_SALARY FROM Employees
GROUP BY DepartmentName

-- TASK 15 Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).

SELECT DepartmentName , AVG(Salary) AS AVG_SALARY , COUNT(*) AS CNT FROM Employees
GROUP BY DepartmentName 

-- TASK 16 Write a query to filter product categories with an average price greater than 400.
SELECT Category, AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;


-- TASK 17 Write a query that calculates the total sales for each year in the Sales table.

SELECT YEAR(SaleDate) AS Sale_Year, SUM(SaleAmount) AS Total_Sales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY Sale_Year ASC


-- TASK 18 Write a query to show the list of customers who placed at least 3 orders.

SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

--TASK 19 Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName).

SELECT DepartmentName , COUNT(*) AS DEPARTMENT_COUNT , AVG(Salary) AS AVG_SALARY 
FROM Employees 
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000 ; 

 --Hard-Level Tasks (6)

--TASK 20 Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150.

SELECT Category , COUNT(*) AS PRODUCT_CATEGORY , AVG(Price) AS AVG_PRICE 
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150; 

--TASK 21 Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.

SELECT CustomerID , SUM(SaleAmount) AS TOTAL_SALE
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500

--TASK 22 Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.

SELECT DepartmentName , SUM(Salary) AS TOTAL_SALARY , 
AVG(Salary) AS AVG_SALARY 
FROM Employees
GROUP BY DepartmentName 
HAVING AVG(Salary) > 65000


--TASK 23 Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.(least amount might be lower than 50, use tsql2012.sales.orders table,freight col, ask ur assistant to give the TSQL2012 database).

SELECT CustomerID,
    SUM(CASE WHEN Freight > 50 THEN Freight ELSE 0 END) AS Total_Freight,
    MIN(Freight) AS Least_Purchase
FROM TSQL2012.Sales.Orders
GROUP BY CustomerID


--TASK 24 Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
SELECT 
    YEAR(OrderDate) AS Order_Year,
    MONTH(OrderDate) AS Order_Month,
    SUM(TotalAmount) AS Total_Sales,
    COUNT(DISTINCT ProductID) AS Unique_Products
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2

--TASK 25 Write a query to find the MIN and MAX order quantity per Year. From orders table. 

SELECT 
    YEAR(OrderDate) AS OrderYear,
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate)
