--Easy Tasks
--Create a numbers table using a recursive query from 1 to 1000.


;WITH Numbers AS (
SELECT 1 AS Num

UNION ALL

SELECT Num+1
FROM Numbers 
WHERE Num < 1000)

SELECT * 
FROM Numbers

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)

SELECT EMP.FirstName, DT.SUM_AMOUNT 
FROM Employees AS EMP
JOIN (SELECT EmployeeID , SUM(SalesAmount) AS SUM_AMOUNT
		FROM Sales
		GROUP BY EmployeeID) AS DT
ON EMP.EmployeeID= DT.EmployeeID;

	  
--Create a CTE to find the average salary of employees.(Employees)

WITH CTE AS (
    SELECT DepartmentID, AVG(Salary) AS AVG_SALARY
    FROM Employees
    GROUP BY DepartmentID
)
SELECT *
FROM CTE;


--Write a query using a derived table to find the highest sales for each product.(Sales, Products)

SELECT P.ProductName, DT.SALES_AMOUNT
FROM Products AS P
JOIN (
	SELECT ProductID , MAX(SalesAmount) AS SALES_AMOUNT
	FROM Sales AS S
	GROUP BY ProductID) AS DT 
ON DT.ProductID = P.ProductID

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.


;WITH Numbers AS (
SELECT 1 AS Num

UNION ALL

SELECT Num*2
FROM Numbers 
WHERE Num*2 < 1000000)

SELECT * 
FROM Numbers


--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

;WITH SalesCount AS (
    SELECT 
        EmployeeID,
        COUNT(SalesID) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT E.FirstName, SC.TotalSales
FROM Employees AS E
JOIN SalesCount AS SC
    ON E.EmployeeID = SC.EmployeeID
WHERE SC.TotalSales > 5;


--ВВФЫЦВУВ

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

;WITH SALES_GREATER AS (
	SELECT  ProductID, SalesAmount 
	FROM Sales
	WHERE SalesAmount > 500
	)
SELECT P.ProductName , SG.SalesAmount
FROM Products AS P 
JOIN SALES_GREATER AS SG
ON SG.ProductID=P.ProductID;



--Create a CTE to find employees with salaries above the average salary.(Employees)

;WITH SALARY_ABOVE AS (
	SELECT AVG(Salary) AS AVG_SALARY
	FROM Employees 
	)
SELECT E1.FirstName, E1.Salary
FROM Employees AS E1
CROSS JOIN SALARY_ABOVE AS A
WHERE E1.Salary > A.AVG_SALARY



--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

SELECT TOP 5 E.FirstName, DT.TOTAL_ORDER
FROM Employees AS E 
JOIN (
	SELECT EmployeeID , COUNT(*) AS TOTAL_ORDER
	FROM Sales 
	GROUP BY EmployeeID
	) AS DT
ON E.EmployeeID=DT.EmployeeID

--Write a query using a derived table to find the sales per product category.(Sales, Products)

SELECT P.ProductName,  DT.SUM_AMOUNT
FROM (
		SELECT P.CategoryID , SUM(S.SalesAmount) AS SUM_AMOUNT
		FROM Sales AS S
		JOIN Products AS P 
		ON P.ProductID=S.ProductID
		GROUP BY P.CategoryID
		)AS DT 
JOIN Products AS P 
ON P.CategoryID = DT.CategoryID



--Write a script to return the factorial of each value next to it.(Numbers1)

DECLARE @N INT = 5

;WITH FACTORIALCTE AS (

SELECT 1 AS NUM , 1 AS FACT
UNION ALL 
SELECT NUM+1 , FACT*(NUM+1)
FROM FACTORIALCTE
WHERE NUM < @N)
SELECT * FROM FACTORIALCTE


--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)



;WITH SplitCTE AS (
    -- Начало рекурсии: первый символ каждой строки
    SELECT 
        Id,
        1 AS Pos,
        SUBSTRING([String], 1, 1) AS Ch,
        LEN([String]) AS StrLen,
        [String] AS FullStr
    FROM Example

    UNION ALL

    -- Рекурсивная часть: берем следующий символ
    SELECT 
        Id,
        Pos + 1,
        SUBSTRING(FullStr, Pos + 1, 1),
        StrLen,
        FullStr
    FROM SplitCTE
    WHERE Pos + 1 <= StrLen   -- важно! иначе повторяется последняя часть
)
SELECT Id, Pos, Ch
FROM SplitCTE
ORDER BY Id, Pos;




--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)

;WITH SalesCTE AS (
    SELECT 
        s1.SaleDate,
        s1.SalesAmount,
        s2.SalesAmount AS PrevAmount
    FROM Sales s1
    LEFT JOIN Sales s2
        ON DATEADD(MONTH, 1, s2.SaleDate) = s1.SaleDate
)
SELECT 
    SaleDate,
    SalesAmount,
    PrevAmount,
    SalesAmount - PrevAmount AS DiffWithPrevMonth
FROM SalesCTE;



--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

SELECT e.EmployeeID, e.FirstName, s.Quarter, s.TotalSales
FROM Employees e
JOIN 
(
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 45000;



--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers

;WITH Fib AS (
    SELECT 0 AS n, 0 AS a, 1 AS b
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fib
    WHERE n < 10  -- здесь задаём сколько чисел хотим (20 = первые 21 число, от 0 до 20)
)
SELECT n, a AS FibValue
FROM Fib
ORDER BY n
OPTION (MAXRECURSION 0);

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

SELECT DT.Vals 
FROM (
	SELECT Vals
	FROM FindSameCharacters
	WHERE LEN(Vals)>1
	) AS DT
WHERE REPLACE(DT.Vals, LEFT(Vals,1), ' ')= ' ' 

--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)


DECLARE @NA INT = 5;

;WITH SeqCTE (n, seq_str) AS (
    -- Anchor
    SELECT 1, CONVERT(VARCHAR(100), 1)
    UNION ALL
    -- Recursive
    SELECT n + 1, CONVERT(VARCHAR(100), seq_str + CONVERT(VARCHAR(100), n + 1))
    FROM SeqCTE
    WHERE n < @NA
)
SELECT n, seq_str
FROM SeqCTE
ORDER BY n
OPTION (MAXRECURSION 0);



--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

SELECT E.FirstName ,DT.TOTALSALE
FROM Employees AS E 
JOIN (
	SELECT EmployeeID, 
	SUM(SalesAmount) AS TOTALSALE 
	FROM Sales 
	WHERE SaleDate > DATEADD(MONTH, -6 , GETDATE())
	GROUP BY EmployeeID 
	) AS DT 
ON E.EmployeeID = DT.EmployeeID
ORDER BY DT.TOTALSALE DESC

--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
;WITH Chars AS (
    SELECT
        PawanName,
        SUBSTRING(Pawan_slug_name, v.number, 1) AS ch
    FROM RemoveDuplicateIntsFromNames
    JOIN master..spt_values v 
        ON v.type = 'P'
       AND v.number BETWEEN 1 AND LEN(Pawan_slug_name)
),
DigitCounts AS (
    SELECT
        PawanName,
        ch,
        COUNT(*) AS cnt
    FROM Chars
    WHERE ch LIKE '[0-9]'
    GROUP BY PawanName, ch
),
RepeatedDigits AS (
    SELECT PawanName, ch
    FROM DigitCounts
    WHERE cnt > 1
)
SELECT
    c.PawanName,
    STRING_AGG(c.ch, '') WITHIN GROUP (ORDER BY v.number) AS CleanedString
FROM Chars c
LEFT JOIN RepeatedDigits d
    ON c.PawanName = d.PawanName AND c.ch = d.ch
JOIN master..spt_values v 
    ON v.type = 'P' AND v.number BETWEEN 1 AND LEN(c.Pawan_slug_name)
WHERE c.ch NOT LIKE '[0-9]' OR d.ch IS NOT NULL
GROUP BY c.PawanName
ORDER BY c.PawanName;




