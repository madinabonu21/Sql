-- Easy-Level Tasks (10)

--1 TASK Using Products, Suppliers table List all combinations of product names and supplier names.

SELECT 
    P.ProductName,
    S.SupplierName
FROM Products AS  P
CROSS JOIN Suppliers AS S;

--2 TASK Using Departments, Employees table Get all combinations of departments and employees.

SELECT 
    E.Name,
    D.DepartmentName
FROM Employees AS E
CROSS JOIN Departments AS  D;

--3 TASK Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT 
    S.SupplierName,
    P.ProductName
FROM Products  AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID;

--4 TASK Using Orders, Customers table List customer names and their orders ID.
SELECT 
  C.FirstName ,
  O.OrderID
FROM Orders AS O 
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID

--5 TASK Using Courses, Students table Get all combinations of students and courses.
SELECT 
  S. Name,
  C.CourseName
FROM Students AS S 
CROSS JOIN Courses AS C 

--6 TASK Using Products, Orders table Get product names and orders where product IDs match.

SELECT 
  P.ProductName,
  O.OrderID
FROM Products AS  P 
JOIN Orders AS O ON P.ProductID = O.ProductID

--7 TASK Using Departments, Employees table List employees whose DepartmentID matches the department.

SELECT 
    E.Name,
    D.DepartmentName
FROM Employees AS  E
JOIN Departments AS  D ON E.DepartmentID = D.DepartmentID

--8 TASK Using Students, Enrollments table List student names and their enrolled course IDs.

SELECT S.Name , E.CourseID
FROM Students AS S 
JOIN Enrollments AS E 
ON S.StudentID = E.StudentID 

--9 TASK Using Payments, Orders table List all orders that have matching payments.

SELECT O.OrderID , P.PaymentMethod
FROM Orders AS O
INNER JOIN Payments AS P
ON O.OrderID = P.OrderID


--10 TASK Using Orders, Products table Show orders where product price is more than 100.

SELECT O.OrderID ,P.ProductName, P.Price
FROM Orders AS O 
JOIN Products AS P 
ON O.ProductID = P.ProductID
WHERE P.Price > 100

--Medium (10 puzzles)
--11 TASK Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.

SELECT E.Name,  D.DepartmentName
FROM Employees AS E
CROSS JOIN  Departments AS D
WHERE E.DepartmentID != D.DepartmentID;

--12 TASK Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

SELECT O.OrderID , O.Quantity ,P.StockQuantity
FROM Orders AS O 
LEFT JOIN Products AS P 
ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity

--13 TASK Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.

SELECT C.FirstName , S.ProductID
FROM Customers AS C 
JOIN Sales AS S 
ON C.CustomerID= S.CustomerID
WHERE S.SaleAmount > 500

--14 TASK Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

SELECT S.Name, C.CourseName
FROM Enrollments AS E 
JOIN Students AS S ON S.StudentID = E.StudentID
JOIN Courses AS C ON C.CourseID = E.CourseID

--15 TASK Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.

SELECT P.ProductName , S.SupplierName
FROM Products AS P 
JOIN Suppliers AS S 
ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE 'Tech%'

--16 TASK Using Orders, Payments table Show orders where payment amount is less than total amount.

SELECT O.OrderID , O.TotalAmount, P.Amount
FROM Orders AS O 
JOIN Payments AS P
ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount

--17 TASK Using Employees and Departments tables, get the Department Name for each employee.
SELECT D.DepartmentName , E.Name
FROM Employees AS E 
JOIN Departments AS D 
ON E.DepartmentID = D.DepartmentID
--18 TASK Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.

SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products AS P 
JOIN Categories AS C 
ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');

--19 TASK Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT S.SaleID , C.Country
FROM Sales AS S 
JOIN Customers AS C 
ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA'

--20 TASK Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT O.OrderID, C.Country, O.TotalAmount
FROM Orders AS O 
JOIN Customers AS C 
ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100

--Hard (5 puzzles)(Do some research for the tasks below)
-- 21 TASK Using Employees table List all pairs of employees from different departments.
SELECT 
    E1.Name AS Employee1, 
    E2.Name AS Employee2,
    E1.DepartmentID AS Dept1,
    E2.DepartmentID AS Dept2
FROM Employees E1
JOIN Employees E2 
    ON E1.EmployeeID < E2.EmployeeID  -- избежать дубликатов и самопар
WHERE E1.DepartmentID != E2.DepartmentID;

--22 TASK Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT 
    P.PaymentID,
    P.OrderID,
    P.Amount AS PaidAmount,
    O.Quantity,
    PR.Price AS ProductPrice,
    (O.Quantity * PR.Price) AS ExpectedAmount
FROM Payments AS P
JOIN Orders AS O 
    ON P.OrderID = O.OrderID
JOIN Products AS PR 
    ON O.ProductID = PR.ProductID
WHERE P.Amount != O.Quantity * PR.Price;

-- 23 TASK Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT S.StudentID, S.Name
FROM Students AS S
LEFT JOIN Enrollments AS E 
    ON S.StudentID = E.StudentID
WHERE E.CourseID IS NULL;


--24 TASK Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT M.Name AS ManagerName, M.Salary AS ManagerSalary,
 E.Name AS EmployeeName, E.Salary AS EmployeeSalary
FROM Employees AS E
JOIN Employees AS M
    ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;


--25 TASK Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

SELECT C.FirstName AS CustomerName, O.OrderID
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments AS P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;


