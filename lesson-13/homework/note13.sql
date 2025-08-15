--You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

 SELECT CONCAT(EMPLOYEE_ID,'-',FIRST_NAME,' ', LAST_NAME)
 FROM Employees
 

 --Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'

UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER , '124', '999') 
 WHERE PHONE_NUMBER LIKE '%124%'

 --That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)

 SELECT FIRST_NAME ,  LEN (FIRST_NAME) AS LEN_NAME
 FROM Employees
WHERE LEFT(FIRST_NAME, 1) IN ('A', 'J', 'M')
ORDER BY FIRST_NAME;

--Write an SQL query to find the total salary for each manager ID.(Employees table)

SELECT MANAGER_ID, SUM(SALARY ) AS TOTAL_SALARY 
FROM Employees
GROUP BY MANAGER_ID 

--Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

SELECT * , 
CASE WHEN Max1 > Max2 AND Max1> Max3 THEN Max1 
WHEN Max2>Max1 AND Max2>Max3 THEN Max2
ELSE Max3
END AS MAX_RESULT
FROM TestMax

--Find me odd numbered movies and description is not boring.(cinema)

SELECT * FROM Cinema 
WHERE id%2=1 AND description != 'boring'

--You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)

SELECT * FROM SingleOrder
ORDER BY 
CASE WHEN Id = 0 THEN 1 ELSE 0 END, 
Id DESC

--Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)

SELECT COALESCE(ssn,passportid,itin) 
FROM Person 


--Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

SELECT LEFT(FullName, CHARINDEX( ' ', FullName ) -1) AS FIRST_NAME,  
SUBSTRING(FullName, CHARINDEX(' ', FullName ) +1 , CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1) AS MiddleName,
RIGHT(FullName,LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1)) AS LastName
FROM Students

--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

SELECT *
FROM Orders
WHERE DeliveryState= 'TX'
AND CustomerID IN (
SELECT DISTINCT CustomerID
FROM Orders
WHERE DeliveryState = 'CA');

--Write an SQL statement that can group concatenate the following values.(DMLTable)

SELECT
STRING_AGG(String , ' ')
FROM DMLTable


--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.


SELECT FIRST_NAME + ' ' + LAST_NAME AS FULL_NAME 
FROM Employees
WHERE 
    (LEN(first_name) - LEN(REPLACE(LOWER(first_name), 'a', ''))) +
    (LEN(last_name) - LEN(REPLACE(LOWER(last_name), 'a', ''))) >= 3;


--The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)

SELECT 
    DEPARTMENT_ID,
    SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS MoreThan3Years,
    CAST(SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS PercentageMoreThan3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

--Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)


SELECT P1.SpacemanID ,J.LEAST_EXPERIENCED, P2.SpacemanID ,J.MOST_EXPERIENCED
FROM(
SELECT JobDescription, MIN(MissionCount) AS LEAST_EXPERIENCED, MAX(MissionCount) AS MOST_EXPERIENCED
FROM Personal
GROUP BY JobDescription
) AS J

JOIN Personal AS P1 
ON P1.JobDescription=J.JobDescription
AND P1.MissionCount = J.LEAST_EXPERIENCED
JOIN Personal AS P2
ON P2.MissionCount=J.MOST_EXPERIENCED 
AND P2.JobDescription=J.JobDescription

--Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.

DECLARE @TEXT VARCHAR(30) = 'tf56sd#%OqH';

SELECT
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 65 AND 90 THEN ch END, '') AS ONLY_UPPERCASE,
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 97 AND 122 THEN ch END, '') AS ONLY_LOWERCASE,
    STRING_AGG(CASE WHEN ASCII(ch) BETWEEN 48 AND 57 THEN ch END, '') AS ONLY_DIGITS,
    STRING_AGG(CASE WHEN NOT (ASCII(ch) BETWEEN 65 AND 90 
                          OR ASCII(ch) BETWEEN 97 AND 122 
                          OR ASCII(ch) BETWEEN 48 AND 57) THEN ch END, '') AS ONLY_SYMBOLS
FROM (
    SELECT SUBSTRING(@TEXT, number, 1) AS ch
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number BETWEEN 1 AND LEN(@TEXT)
) AS chars;


--Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)

SELECT d.StudentID ,d.CumulativeValue
FROM (
    SELECT s1.StudentID,
           (SELECT SUM(s2.Grade) 
            FROM Students s2 
            WHERE s2.StudentID <= s1.StudentID) AS CumulativeValue
    FROM Students s1
) AS d;

--You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)

WITH Split AS (
    SELECT Equation,
           TRIM(value) AS part
    FROM Equations
    CROSS APPLY STRING_SPLIT(
        REPLACE(REPLACE(Equation, '-', ',-'), '+', ',+'),
        ','
    )
),
Parsed AS (
    SELECT Equation,
           CAST(SUBSTRING(part, 1, LEN(part)) AS INT) * 
           CASE LEFT(part, 1) 
                WHEN '-' THEN -1 
                WHEN '+' THEN 1 
                ELSE 1 
           END AS num
    FROM Split
)
SELECT Equation, SUM(num) AS Result
FROM Parsed
GROUP BY Equation;


--Given the following dataset, find the students that share the same birthday.(Student Table)

SELECT Birthday, 
       STRING_AGG(StudentName, ', ') AS StudentsWithSameBirthday
FROM Student
GROUP BY Birthday
HAVING COUNT(*) > 1;

--You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

SELECT
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;



