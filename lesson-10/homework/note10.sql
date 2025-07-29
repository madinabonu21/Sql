--EASY LEVEL TASK 

--1 TASK Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

SELECT E.Name, E.Salary, D.DepartmentName 
FROM  Employees AS E
INNER JOIN Departments AS D 
ON E.DepartmentID= D.DepartmentID
WHERE E.Salary > 50000

--2 TASK Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Columns: FirstName, LastName, OrderDate

SELECT C.FirstName, C.LastName, O.OrderDate
FROM Customers AS C 
INNER JOIN Orders AS O 
ON C.CustomerID= O.CustomerID
WHERE YEAR(O.OrderDate)= 2023 


--3 TASK Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT E.Name, ISNULL(D.DepartmentName, 'NO DEPARTMENT')AS DepartmentName
FROM Employees AS E 
LEFT JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID

--4 TASK Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Columns: SupplierName, ProductName

SELECT S.SupplierName, ISNULL(P.ProductName,'NO PRODUCTS')
FROM Suppliers AS S 
LEFT JOIN Products AS P 
ON S.SupplierID = P.SupplierID

-- 5 TASK Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

SELECT  O.OrderID, O.OrderDate,  P.PaymentDate,P.Amount
FROM Orders AS O 
FULL JOIN Payments AS P 
ON O.OrderID = P.OrderID

--6 TASK Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Columns: EmployeeName, ManagerName

SELECT E.Name AS EMPLOYEE_NAME, ISNULL(M.Name , 'NO MANAGER' ) AS MANAGER_NAME
FROM Employees AS E
LEFT JOIN Employees AS M
ON E.ManagerID = M.EmployeeID

-- 7 TASK Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Columns: StudentName, CourseName

SELECT S.Name, C.CourseName
FROM Enrollments AS E 
JOIN Courses AS C ON E.CourseID = C.CourseID
JOIN Students AS S  ON E.StudentID=S.StudentID
WHERE C.CourseName = 'MATH 101'


-- 8 TASK Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--🔁 Expected Columns: FirstName, LastName, Quantity

SELECT C.FirstName + ' ' + C.LastName AS FULL_NAME, O.Quantity
FROM Customers AS C 
JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3 

-- 9 TASK Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT Name , DepartmentName
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID
WHERE DepartmentName = 'Human Resources'


-- MEDIUM LEVEL TASKS 
--10 TASK Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
--🔁 Expected Columns: DepartmentName, EmployeeCount

SELECT D.DepartmentName , COUNT(E.EmployeeID) AS Employee_Count
FROM Departments AS D 
INNER JOIN Employees AS E 
ON D.DepartmentID= E.DepartmentID
GROUP BY  D.DepartmentName 
HAVING COUNT(E.EmployeeID ) > 5 

-- 11 TASK Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Columns: ProductID, ProductName

SELECT P.ProductID, P.ProductName
FROM Products AS P 
LEFT JOIN Sales AS S 
ON  P.ProductID = S.ProductID
WHERE S.SaleID IS NULL

--12 TASK Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Columns: FirstName, LastName, TotalOrders
 
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers AS C 
JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(O.OrderID)>=1

--13 TASK Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT Name , DepartmentName
FROM Employees AS E 
INNER JOIN Departments AS D 
ON D.DepartmentID = E.DepartmentID


--14 TASK Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Columns: Employee1, Employee2, ManagerID

SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees AS  E1
JOIN Employees AS  E2
ON E1.ManagerID= E2.ManagerID
WHERE E1.EmployeeID > E2.EmployeeID

-- 15 TASK Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName

SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders AS O 
JOIN Customers AS C 
ON C.CustomerID = O.CustomerID
WHERE YEAR (OrderDate) = 2022


-- 16 TASK Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Columns: EmployeeName, Salary, DepartmentName

SELECT E.Name, E.Salary, D.DepartmentName
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary >= 60000

-- 17 TASK Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount

SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders AS O 
INNER JOIN Payments AS P 
ON O.OrderID = P.OrderID


-- 18 TASK Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Columns: ProductID, ProductName

SELECT P.ProductID, P.ProductName
FROM Products AS P 
LEFT JOIN Orders AS  O
ON O.ProductID = P.ProductID
WHERE O.ProductID IS NULL


-- HARD LEVEL TASKS 
-- 19 TASK Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
--🔁 Expected Columns: EmployeeName, Salary

SELECT E.Name AS EmployeeName, E.Salary
FROM 
    Employees AS E
WHERE 
E.Salary > (
	SELECT AVG(E2.Salary)
    FROM Employees  AS E2
    WHERE E2.DepartmentID = E.DepartmentID
    );

-- 20 TASK Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Columns: OrderID, OrderDate

SELECT O.OrderID, O.OrderDate
FROM Orders AS O 
LEFT JOIN Payments AS P 
ON O.OrderID = P.OrderID
WHERE YEAR(OrderDate) < 2020
AND P.OrderID IS NULL 

--21 TASK Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Columns: ProductID, ProductName

SELECT P.ProductID, P.ProductName
FROM Products AS P 
LEFT JOIN Categories AS C 
ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL 

-- 22 TASK Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary

SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees AS E1
JOIN Employees AS E2
ON E1.ManagerID= E2.ManagerID
AND E1.EmployeeID < E2.EmployeeID 
WHERE E1.Salary > 60000 AND E2.Salary > 60000;


-- 23 TASK Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
--🔁 Expected Columns: EmployeeName, DepartmentName

SELECT E.Name, D.DepartmentName
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID 
WHERE D.DepartmentName LIKE 'M%'

-- 24 TASK  Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Columns: SaleID, ProductName, SaleAmount

SELECT S.SaleID, P.ProductName, S.SaleAmount
FROM Sales AS S
JOIN Products AS P 
ON P.ProductID=S.ProductID
WHERE S.SaleAmount > 500

-- 25 TASK Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Columns: StudentID, StudentName

SELECT S.Name, C.CourseName
FROM Enrollments AS E 
LEFT JOIN Courses AS C ON E.CourseID = C.CourseID
LEFT JOIN Students AS S  ON E.StudentID=S.StudentID 
WHERE C.CourseName != 'Math 101 '

-- 26 TASK Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Columns: OrderID, OrderDate, PaymentID

SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders AS O 
LEFT JOIN Payments AS P 
ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL

-- 27 TASK Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Columns: ProductID, ProductName, CategoryName

SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products AS P 
JOIN Categories AS C 
ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
