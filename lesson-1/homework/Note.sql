--Easy
--1. 
--Data are raw facts and figures from which meaningful information can be derived.
--Database is a set of information that is stored in an organized manner in electronic form.
--Relational database is a type of database in which data is organized into tables, and these tables are linked together by logical relationships.
--Table is a structured way of presenting information in the form of rows and columns, designed to organize and display data.
--2.
--Five key features of SQL Server:comprehensive management tools, flexibility , robust security, high availability, intelligent query processing.
--3.
--Authentification modes of connecting SQL Server: SQL server authentification and Windows authentification.

--Medium
-- 4, 5 and 8 tasks  
create database SchoolIDB
--table 1 
use SchoolIDB
create table students ( StudentID int PRIMARY KEY , name Varchar(50) , Age int )
insert into students values (1, 'Dilnavoz', 20), (2,'Sabina' , 20),(3, 'Merida' , 19)
select* from students


6. 
--Differences between SQL Server , SSMS, SQL: 
--SQL (Structured Query Language) is a standard language for working with relational databases.
--SQL Server is a server which responds data management in the form of databases and tables and does most of the work with the data. And includes a server part that processes queries and ensures data integrity, as well as provides various tools for administration.
--SSMS is an interface which allows to work with SQL Server.
  
--Hard

7.
--1- DDL Commands are used to build the structure of database , they include commands (CREATE-This command is used to create a new database object, ALTER-This command is used to modify an existing database object, DROP-This command is used to delete an entire database object,TRUNCATE-This command is used to delete all records from a table, without deleting the table.) 
--Example: 
--CREATE table students ( StudentID int PRIMARY KEY , name Varchar(50) , Age int ) 
--ALTER table students
--DROP COLUMN name
--TRUNCATE table students 
--2- DML Commands are used to add and change data We use them to add, change, or remove data rows. They include commands(INSERT-Used to add new rows or records into a table, UPDATE-Used to change existing records in a table, DELETE-used  to delete records from table)
--Example:
--INSERT INTO students ( StudentID  , name  , Age  ) VALUES (3, 'Doniyor', '21')
--UPDATE  students
--SET  StudentID = 1 , name='Dilnavoz' , age=20 WHERE StudentID = 1
--DELETE FROM Employees WHERE Department = 'Finance'
--3-DQL Commands are used to get information, they include commands (SELECT-You tell the database exactly what data you want to see and which table it should look in.) 
--Example:
SELECT * from students
--4-DCL Commands - These commands are used to manage access and permissions in a database.They include commands (GRANT,REVOKE) 
--Example:
--GRANT SELECT, INSERT ON object TO user 
--REVOKE DELETE ON Customers FROM Sales_Team
--5-TCL Commands-These commands help manage transactions.They include commands (COMMIT-Used to save all the changes you made during a transaction permanently,BEGIN-Starts a transaction , ROLLBACKUsed to undo changes you made during a transaction if something went wrong,SAVEPOINT)
--Example:
--BEGIN
--SQL statements
--SAVEPOINT my_savepoint
-- More SQL statements
--ROLLBACK TO my_savepoint

9.
--Step 1. We have to  click the link below then upload a file . Then  go to “ Desktop ” find the downloaded file then click on the right and save to C disk
--Step 2. Then we have to go to c-disk find program files click on it and go to the " Microsoft SQL Server" section. There we can find section "MSSQL" within this section is the "backup" department  . We have to enter department "Backup"  it asks for permission to enter, click continue then save the file.
--Step 3. From Object explorer we will select database and right-click . Then select Restore database.
--Step 4. Then we go to the section "Source" then go over the section "device" then click "....." bottom.
--Step 5. On the next step we have to click the bottom "Add", after we will find the file that we upload.
--Step 6. Then click the bottom "ok" to complete all steps above . So after all , among the database you can find "AdventureWorks2022".






