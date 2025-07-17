-- EASY LEVEL TASKS
--1 TASK 

SELECT ProductName AS Name
FROM Products

--2 TASK 

SELECT Client.CustomerID, Client.FirstName, Client.Country 
FROM Customers AS Client 

-- 3 TASK
SELECT ProductName FROM Products
UNION 
SELECT ProductName FROM Products_Discounted

-- 4 TASK
SELECT ProductID, ProductName  FROM Products
INTERSECT
SELECT ProductID, ProductName FROM Products_Discounted

--5 TASK

SELECT DISTINCT FirstName , Country FROM Customers

-- 6 TASK 

SELECT *  , 
	CASE WHEN Price > 1000 THEN 'HIGH'
	ELSE'LOW'
	END AS PriceLevel
FROM Products 

-- 7 TASK 
SELECT 
    ProductName,
    StockQuantity,
    IIF(StockQuantity > 100, 'Yes', 'No') AS STOCK_STATUS
FROM Products_Discounted

-- Medium-Level Tasks

-- 8 TASK 

SELECT  ProductName  FROM Products
UNION
SELECT ProductName FROM Products_Discounted
ORDER BY  ProductName
-- 9 TASK  
SELECT  ProductID, ProductName, Category  FROM Products
EXCEPT
SELECT ProductID ,ProductName, Category FROM Products_Discounted

-- 10 TASK 

SELECT ProductID ,ProductName ,Price,
	IIF(Price> 1000 , 'EXPENSIVE','AFFORDABLE')  AS PriceLevel
FROM Products

-- 11 TASK 

SELECT EmployeeID , Age, Salary,
		CASE 
        WHEN Salary > 60000 THEN 'High Earner'
        ELSE 'Regular'
    END AS SalaryCategory,
    IIF(Age < 25, 'Young', 'Adult') AS AgeGroup
FROM Employees

-- 12 TASK 
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR EmployeeID = 5

--alternative version of 12 task 
--UPDATE Employees
--SET Salary = 
--    CASE 
--        WHEN DepartmentName = 'HR' OR EmployeeID = 5 THEN Salary * 1.10
--        ELSE Salary
--    END;



--Hard-Level Tasks

-- 13 TASK
SELECT SaleID,ProductID, SaleAmount,
	CASE WHEN SaleAmount > 500 THEN 'TOP TIER'
	WHEN SaleAmount BETWEEN 200 AND 500 THEN 'MID TIER'
	ELSE 'LOW TIER' 
	END AS tier
FROM Sales

--14 TASK 

SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales

-- 15 TASK 
SELECT CustomerID, Quantity,
	CASE 
		WHEN Quantity = 1 THEN 0.03
		WHEN Quantity BETWEEN 2 AND 3 THEN 0.05
		ELSE 0.07
	END AS DiscountPercent
FROM Orders
