--Easy-Level Tasks (7)
--Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers

SELECT O.OrderID,C.FirstName,O.OrderDate
FROM Orders AS O
JOIN Customers AS C 
ON O.CustomerID = C.CustomerID
WHERE YEAR (O.OrderDate) >= 2022

--Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments

SELECT E.Name, D.DepartmentName
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID  
WHERE  D.DepartmentName = 'Sales' OR D.DepartmentName = 'Marketing'

--Return: DepartmentName, MaxSalary
--Task: Show the highest salary for each department.
--Tables Used: Departments, Employees

SELECT D.DepartmentName, Max(E.Salary) AS MAX_SALARY
FROM Departments AS D
JOIN Employees AS E 
ON D.DepartmentID = E.DepartmentID
GROUP BY  D.DepartmentName

--Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders

SELECT C.FirstName, O.OrderID, O.OrderDate
FROM Customers AS C
JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
WHERE C.Country = 'USA' AND  YEAR(O.OrderDate)=2023


--Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders , Customers

SELECT C.CustomerID , C.FirstName , COUNT(O.OrderID) AS TotalOrders
FROM Orders AS O 
JOIN Customers AS C 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID , C.FirstName

--Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers

SELECT P.ProductName, SP.SupplierName
FROM Products AS P 
JOIN Suppliers AS SP
ON P.SupplierID = SP.SupplierID
WHERE SP.SupplierName IN ( 'Gadget Supplies', 'Clothing Mart')

--Return: CustomerName, MostRecentOrderDate
--Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
--Tables Used: Customers, Orders

SELECT C.FirstName , MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers AS C 
LEFT JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
GROUP BY  C.FirstName 


--Medium-Level Tasks (6)

--Return: CustomerName, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers


SELECT C.FirstName, O.TotalAmount AS OrderTotal
FROM Orders AS O 
JOIN Customers AS C 
ON O.CustomerID=C.CustomerID
WHERE O.TotalAmount > 500 

--Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales

SELECT P.ProductName , S.SaleDate,S.SaleAmount
FROM Products AS P 
JOIN Sales AS S 
ON P.ProductID = S.ProductID
WHERE YEAR(S.SaleDate) = 2022 OR (S.SaleAmount > 400)

--Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales, Products

SELECT P.ProductName , SUM(S.SaleAmount) AS TotalSalesAmount
FROM Sales AS S 
RIGHT JOIN Products AS P 
ON S.ProductID = P.ProductID
GROUP BY P.ProductName

--Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 60000.
--Tables Used: Employees, Departments

SELECT E.Name,D.DepartmentName,E.Salary
FROM Employees AS E 
JOIN Departments AS D
ON E.DepartmentID =D.DepartmentID
WHERE D.DepartmentName ='Human Resources' AND E.Salary > 60000 

--Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
--Tables Used: Products, Sales

SELECT P.ProductName,S.SaleDate,P.StockQuantity
FROM Products AS P 
JOIN Sales AS S 
ON P.ProductID=S.ProductID
WHERE YEAR(S.SaleDate)=2023 AND P.StockQuantity > 100

--Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments

SELECT E.Name , D.DepartmentName ,E.HireDate
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID=D.DepartmentID
WHERE D.DepartmentName = 'Sales' OR YEAR(E.HireDate) >=2020


--HARD LEVEL TASKS
--Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders

SELECT C.FirstName , O.OrderID , C.Address , O.OrderDate
FROM Customers AS C 
JOIN Orders AS O 
ON O.CustomerID=C.CustomerID
WHERE C.Country ='USA' AND C.Address LIKE '[0-9][0-9][0-9][0-9]%'

--Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales

SELECT P.ProductName , P.Category , S.SaleAmount
FROM Products AS P
JOIN Sales AS S 
ON P.ProductID=S.ProductID
WHERE P.Category=1 OR S.SaleAmount > 350

--Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products, Categories

SELECT C.CategoryName, SUM(P.StockQuantity) AS ProductCount
FROM Products AS P
JOIN Categories AS C 
ON P.Category = C.CategoryID
GROUP BY C.CategoryName

--Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders

SELECT C.FirstName AS CustomerName , C.City ,O.OrderID , O.TotalAmount
FROM Customers AS C 
JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
WHERE C.City ='Los Angeles' AND O.TotalAmount >300

--Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments

SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Human Resources','Finance') OR E.Name LIKE '%[aeiou]%[aeiou]%[aeiou]%[aeiou]%'

--Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
--Tables Used: Employees, Departments

SELECT E.Name AS EmployeeName , D.DepartmentName, E.Salary
FROM Employees AS E
JOIN Departments AS D 
ON E.DepartmentID=D.DepartmentID
WHERE D.DepartmentName IN ('Sales', 'Marketing') AND E.Salary > 60000
