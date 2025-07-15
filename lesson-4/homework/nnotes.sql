--Easy-Level Tasks (10)
--1 TASK 

SELECT TOP 5 *  FROM Employees

--2 TASK 

SELECT DISTINCT Category FROM Products

-- 3 TASK  

SELECT * FROM Products
WHERE Price > 100

-- 4 TASK 

SELECT * FROM Customers
WHERE FirstName LIKE 'A%'

-- 5 TASK 
SELECT * FROM Products
ORDER BY Price  ASC

-- 6 TASK 

SELECT * FROM Employees
WHERE Salary >=60000 AND  DepartmentName = 'HR'

-- 7 TASK 
SELECT  ISNULL (Email,'noemail@example.com') AS Email
FROM Employees

-- 8 TASK 

SELECT * FROM Products 
WHERE Price BETWEEN 50 AND 100 

-- 9 TASK 

SELECT DISTINCT Category , ProductName 
FROM Products 

-- 10 TASK 

SELECT DISTINCT Category , ProductName 
FROM Products 
ORDER BY ProductName DESC

--Medium-Level Tasks (10)

-- 11 TASK 
SELECT TOP 10 * FROM Products
ORDER BY Price DESC

-- 12 TASK 
SELECT COALESCE (FirstName , LastName) AS Name
FROM Employees

-- 13 TASK 
SELECT DISTINCT Category , Price 
FROM Products 

-- 14 TASK 

SELECT * FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing'

-- 15 TASK 

SELECT * FROM Employees
ORDER BY Salary DESC 
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY

-- 16 TASK 

SELECT * FROM Products
WHERE Price<= 1000 AND StockQuantity >50 
ORDER BY StockQuantity ASC

-- 17 TASK 

SELECT * FROM Products
WHERE ProductName LIKE '%e%'

-- 18 TASK 

SELECT * FROM Employees 
WHERE DepartmentName IN ('HR','IT','Finance')

--19 TASK 

SELECT * FROM Customers
ORDER BY City ASC , PostalCode DESC

-- Hard-Level Tasks

--20 TASK 

SELECT TOP 5 * FROM Sales 
ORDER BY SaleAmount DESC

-- 21 TASK 
SELECT   COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '')  AS FullName
FROM Employees

-- 22 TASK 
SELECT DISTINCT Category , ProductName, Price 
FROM  Products 
WHERE Price > 50 

--23 TASK 
SELECT *  FROM Products 
WHERE Price < (SELECT AVG(Price) * 0.1 FROM Products)

-- 24 TASK 

SELECT *
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT')

-- 25 TASK 
SELECT * FROM Customers 
WHERE Email LIKE '%@gmail.com%'

-- 26 TASK 
SELECT *
FROM Employees
WHERE Salary > ALL (
SELECT Salary 
FROM Employees 
WHERE DepartmentName = 'Sales'
)

-- 27 TASK 
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
