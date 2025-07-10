-- Basic level 
-- 1 Task

CREATE TABLE Employees (EmpID int , Name VARCHAR(50), Salary DECIMAL(10,2))

--2 Task
INSERT INTO Employees (EmpID  , Name, Salary )
VALUES (1, 'Xalimova Karina',55000000.00)
INSERT INTO Employees (EmpID  , Name, Salary )
VALUES (2, 'Baydarova Sabina', 7000000.00),
       (3, 'Egamberdiyeva Dilnavoz', 1200000.00),
	   (4, 'Kim Anastassiy', 30000000.00)
INSERT INTO Employees (EmpID  , Name, Salary ) 
VALUES(5, 'Merida Korrigan', 3000)

SELECT * FROM Employees

--3 Task
UPDATE Employees
SET Salary = 7000
WHERE EmpID=1

--4 Task
DELETE Employees
WHERE EmpID=2

--5 Task (brief definition for difference between DELETE, TRUNCATE, and DROP.)
--DELETE  removes specific rows from a table (with WHERE) and can be rolled back, logging each deletion. 
--TRUNCATE quickly removes all rows without logging individual deletions, resets identity counters, and can't be rolled back. 
--DROP completely deletes the table structure and data from the database, requiring recreation to use again.

--6 Task
ALTER TABLE Employees 
ALTER COLUMN Name VARCHAR(100)

--7 Task
ALTER TABLE Employees
ADD Department VARCHAR(50)

--8 Task
ALTER TABLE Employees 
ALTER COLUMN Salary FLOAT

--9 Task
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY , DepartmentName VARCHAR(50))

--10 Task
TRUNCATE TABLE Employees 

--Intermediate-Level Tasks
 
 --11 Task
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 10001, 'HR' UNION
SELECT 10002, 'IT' UNION
SELECT 10003, 'Finance' UNION
SELECT 10004, 'Marketing' UNION
SELECT 10005, 'Sales'
SELECT * FROM Departments
 --12 Task
UPDATE Employees
SET Department= 'Management' WHERE Salary > 5000

 --13 Task
 TRUNCATE TABLE Employees 

 --14 Task 
 ALTER TABLE Employees DROP COLUMN Department
 
 --15 Task
 EXEC sp_rename 'Employees', 'StaffMembers'

 --16 Task
DROP TABLE Departments

 --Advanced level tasks 
--17 Task
CREATE TABLE  Products (ProductID INT Primary Key, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2),Description VARCHAR(200))

--18 Task
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0)

--19 Task
ALTER TABLE ProductS
ADD StockQuantity INT DEFAULT 50

--20 Task
EXEC sp_rename 'Products.Category', 'ProductCategory','COLUMN'

--21 Task
INSERT INTO Products(ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1500.00, 'HP laptop CORE I5 10TH GENERATION'),
(2, 'Phone', 'Electronics', 1500.00, 'Smartphone I phone 16 '),
(3, 'Desk', 'Furniture', 150.00, 'Wooden desk'),
(4, 'SMART-WATCH', 'Furniture', 75.00, ' APLLE SMART WATCH '),
(5, 'Monitor', 'Electronics', 200.00, '24-inch LED monitor')


-- 22 Task
SELECT* INTO Products_Backup FROM  Products

--23 Task
EXEC sp_rename 'Products','Inventory'

--24 Task
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT 

--25 Task
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5)
