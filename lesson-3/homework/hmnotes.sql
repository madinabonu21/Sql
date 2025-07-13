--Easy-Level Tasks (10)
-- 1 TASK 
--BULK INSERT allows to import large amounts of data from a data file directly into a table quickly and efficiently.
--loads data in bulk from external files (like .csv, .txt) into SQL Server tables. 
--Ideal for large datasets, such as system logs, exports from other databases, or flat files.

-- 2 TASK 
--CSV (.csv) , TXT (.txt) , XML (.xml), JSON (.json)

--3 TASK 

CREATE TABLE Products (
PRODUCT_ID INT PRIMARY KEY,
PRODUCT_NAME VARCHAR(50),
PRICE DECIMAL(10,2)
)
-- 4 TASK
INSERT INTO Products VALUES 
(1, 'APPLE PIE 300gr ', 30.00),
(2, 'CHEESE CAKE 300gr ', 23.00),
(3, 'CHOCO COOKIES 1000gr', 11.00),
(4, 'BROWNIES 300gr', 10.00 )

-- 5 TASK 
--NULL represents missing, unknown, or undefined data. It is not the same as 0 or an empty string — it literally means “no value”.
--NOT NULL is a constraint that prevents NULL values in a column.It forces the user to provide a value when inserting or updating data.

-- TASK 6 and 7  
ALTER TABLE Products
ADD CONSTRAINT unq_prod_name UNIQUE (PRODUCT_NAME) -- we add a constraint UNIQUE to ProductName column in the Products table.

--8 TASK
ALTER TABLE Products
ADD CategoryID INT 

-- 9 TASK 
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE 
);
INSERT INTO Categories  VALUES 
(1001, 'AMERICAN PIES'),
(1002,'CHEESE CAKES'),
(1003,'COOKIES'),
(1004, 'CHOCOLATE CAKES')

-- 10 TASK 
--The IDENTITY property is used to automatically generate unique numeric values for a column — typically used for primary keys.

--MEDIUM LEVEL 
-- 11 TASK 
BEGIN TRY
bulk insert [MASTER].[dbo].[Products] 
FROM 'C:\Users\User\Downloads\iMe Desktop\test.csv'
WITH
(
FIRSTROW=2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
END TRY
BEGIN CATCH
    PRINT ' ошибка при загрузке файла:';
    PRINT ERROR_MESSAGE();
END CATCH

--12 TASK 
ALTER TABLE Products 
ADD CONSTRAINT FK_categoryID
FOREIGN KEY( CategoryID)
REFERENCES Categories(CategoryID)

-- 13 TASK 
--PRIMARY KEY is not allow NULLs while UNIQUE KEY  allows NULL but only one NULL and also PRIMARY KEY could be used one per a table but UNIQUE KEY u can use multiple in one table 

-- 14 TASK 
ALTER TABLE Products
ADD CONSTRAINT CH_Price CHECK (Price>0)

-- 15 TASK 
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0 

-- 16 TASK 
SELECT 
PRODUCT_ID,
PRODUCT_NAME,
ISNULL (PRICE,0) AS PRICE_CR
FROM Products
-- 17 TASK 
--The FOREIGN KEY constraint is used to prevent actions that would destroy links between tables. A FOREIGN KEY is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table.

-- HARD LEVEL 
-- 18 TASK 
CREATE TABLE CUSTOMERS( 
CUSTOMER_ID INT ,
CUSTOMER_NAME VARCHAR(100),
CUSTOMER_AGE INT,
CONSTRAINT CH_COSTUMERAGE CHECK(CUSTOMER_AGE>=18)

--19 TASK 
CREATE TABLE SCHOOL (
STUDENT_ID INT IDENTITY (100,10),
STUDENTS_NAME VARCHAR(100) UNIQUE,
CLASSES VARCHAR (20)
)

-- 20 TASK 
CREATE TABLE ORDER_DETAILS (
ORDERID INT NOT NULL,
CATEGORY VARCHAR(50),
PRODUCTID INT NOT NULL,
PRICE MONEY ,
PRIMARY KEY (ORDERID ,PRODUCTID)

-- 21 TASK
--Both functions are used to handle NULL values, but the key differences are ISNULL only checks two values, COALESCE checks multiple values and more flexible than ISNULL

--22 TASK
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(255) UNIQUE
)

-- 23 TASK
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FullName VARCHAR(100)
)
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100),
    TeacherID INT,
    FOREIGN KEY (TeacherID)
        REFERENCES Teachers(TeacherID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
