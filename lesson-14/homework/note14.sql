--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

SELECT
LEFT (Name ,CHARINDEX(',' , Name)-1) AS NAME1,
SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)) AS NAME2
FROM [dbo].[TestMultipleColumns]

--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)

SELECT Strs
FROM TestPercent
WHERE Strs LIKE '%\%%' ESCAPE '\'

--In this puzzle you will have to split a string based on dot(.).(Splitter)


SELECT 
    CASE 
        WHEN CHARINDEX('.', Vals) > 0 
        THEN LEFT(Vals, CHARINDEX('.', Vals) - 1) 
        ELSE Vals 
    END AS VALS1,
    
    CASE 
        WHEN CHARINDEX('.', Vals) > 0 AND 
             CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) > 0
        THEN SUBSTRING(
                 Vals,
                 CHARINDEX('.', Vals) + 1,
                 CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) - CHARINDEX('.', Vals) - 1
             )
        WHEN CHARINDEX('.', Vals) > 0 
        THEN SUBSTRING(Vals, CHARINDEX('.', Vals) + 1, LEN(Vals))
        ELSE NULL
    END AS VALS2,
    
    CASE 
        WHEN CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) > 0
        THEN RIGHT(Vals, LEN(Vals) - CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1))
        ELSE NULL
    END AS VALS3
FROM Splitter

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)

DECLARE @input_string VARCHAR(100) = '1234ABC123456XYZ1234567890ADS';

SELECT 
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    @input_string,
    '0', 'X'), '1', 'X'), '2', 'X'), '3', 'X'), '4', 'X'),
    '5', 'X'), '6', 'X'), '7', 'X'), '8', 'X'), '9', 'X') 
AS masked_string;


--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)

SELECT Vals,
LEN(Vals)- LEN(REPLACE(Vals , '.', '')) AS DOTSCOUNT
FROM testDots 
WHERE LEN(Vals)- LEN(REPLACE(Vals , '.', '')) > 2 

--Write a SQL query to count the spaces present in the string.(CountSpaces)

SELECT texts, 
LEN(texts)- LEN(REPLACE(texts , ' ', '')) AS COUNTSPACES
FROM CountSpaces

--write a SQL query that finds out employees who earn more than their managers.(Employee)

SELECT EMPLOYEE.Name ,EMPLOYEE.Salary 
FROM Employee AS EMPLOYEE
JOIN Employee AS MANAGER
ON EMPLOYEE.ManagerId = MANAGER.Id
WHERE EMPLOYEE.Salary > MANAGER.Salary


--Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)

SELECT EMPLOYEE_ID , FIRST_NAME, LAST_NAME ,
DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS DIF_YEAR
FROM Employees
WHERE DATEDIFF(YEAR, CAST(HIRE_DATE AS DATE), GETDATE()) > 10
  AND DATEDIFF(YEAR, CAST(HIRE_DATE AS DATE), GETDATE()) < 15

  --Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
DECLARE @TEXT VARCHAR(50) = 'rtcfvty34redt'
SELECT 
    @TEXT,
    -- Получаем только буквы: заменяем цифры на '', потом убираем лишнее
    REPLACE(TRANSLATE(@TEXT, '0123456789', '          '), ' ', '') AS Letters,
    -- Получаем только цифры: заменяем буквы на '', потом убираем лишнее
    REPLACE(TRANSLATE(@TEXT, 'abcdefghijklmnopqrstuvwxyz', REPLICATE(' ', 26)), ' ', '') AS Numbers


  --write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
 
 SELECT W.Id 
 FROM weather AS W
 JOIN weather AS PREV
 ON W.RecordDate=DATEADD(DAY, 1, PREV.RecordDate)
WHERE W.Temperature > PREV.Temperature

--Write an SQL query that reports the first login date for each player.(Activity)

SELECT player_id,MIN(event_date) 
FROM Activity
GROUP BY player_id

--Your task is to return the third item from that list.(fruits)


SELECT LTRIM(RTRIM(s.value)) AS third_item
FROM fruits
CROSS APPLY STRING_SPLIT(fruit_list, ',', 1) AS s
WHERE s.ordinal = 3;

--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)

DECLARE @word VARCHAR(50) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < LEN(@word)
)
SELECT SUBSTRING(@word, n, 1) AS Letter
FROM Numbers

--You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

SELECT 
CASE WHEN PCODE1.code=0 THEN PCODE2.code
ELSE PCODE1.code
END AS CODE
FROM p1 AS PCODE1
JOIN  p2 AS PCODE2
ON PCODE1.id=PCODE2.id

--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

SELECT *,
CASE 
WHEN DATEDIFF(YEAR, HIRE_DATE , GETDATE()) BETWEEN 1 AND 5  THEN 'Junior'
WHEN DATEDIFF(YEAR, HIRE_DATE , GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
WHEN DATEDIFF(YEAR, HIRE_DATE , GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
WHEN DATEDIFF(YEAR, HIRE_DATE , GETDATE()) > 20 THEN 'Veteran'
ELSE 'New Hire'
END 
FROM Employees

--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)


SELECT 
REPLACE(TRANSLATE(ISNULL(VALS, ' '), 'abcdefghijklmnopqrstuvwxyz-#', REPLICATE(' ', 28)), ' ', '') AS Numbers
FROM GetIntegers

--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)

SELECT STUFF(
           STUFF(VALS, 1, 1, SUBSTRING(VALS, 3, 1)), -- Меняем первую букву
           3, 1, LEFT(VALS, 1)                      -- Меняем вторую букву
       )
FROM MultipleVals;

--Write a SQL query that reports the device that is first logged in for each player.(Activity)

SELECT A.event_date,A.device_id 
FROM Activity AS A 
JOIN 
(SELECT player_id , MIN(event_date) AS first_logged_in
FROM Activity 
GROUP BY player_id) AS DT

ON A.player_id = DT.player_id
AND A.event_date = DT.first_logged_in

--You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)

WITH CTE AS
(SELECT FinancialWeek,
SUM(ISNULL(SalesLocal, 0)+ ISNULL(SalesRemote , 0)) AS SALESPERADAY 
FROM WeekPercentagePuzzle
GROUP BY  FinancialWeek) 

SELECT W.Area,W.FinancialWeek,
(ISNULL(W.SalesLocal, 0)+ ISNULL(W.SalesRemote , 0)) *100/ P.SALESPERADAY AS PERCENTAGE
FROM WeekPercentagePuzzle AS W
JOIN CTE AS P
ON W.FinancialWeek = P.FinancialWeek

