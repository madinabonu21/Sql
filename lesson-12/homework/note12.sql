-- PUZZLE 1. Combine Two Tables
SELECT P.firstName , P.lastName , A.city , A.state
FROM Person AS P 
LEFT JOIN Address AS A 
ON P.personId = A.personId


--PUZZLE 2. Employees Earning More Than Their Managers

SELECT EMP.name
FROM EmployeeS AS EMP
JOIN EmployeeS AS MANAGER
ON MANAGER.id  = EMP.managerId
WHERE EMP.salary > MANAGER.salary

--PUZZLE 3. Duplicate Emails

SELECT DISTINCT p1.email
FROM PersonS p1
CROSS APPLY (
    SELECT COUNT(*) AS cnt
    FROM PersonS p2
    WHERE p2.email = p1.email
) AS stats
WHERE stats.cnt > 1;

--PUZZLE 4. Duplicate Emails
SELECT DISTINCT(email)
FROM Person_

--PUZZLE 5. Find those parents who has only girls.

SELECT DISTINCT ParentName
FROM girls

EXCEPT

SELECT DISTINCT ParentName
FROM boys;

--PUZZLE 6.Total over 50 and least

SELECT 
    CustomerID,
    SUM(TotalDue) AS TotalSalesOver50,
    MIN(Weight) AS LeastWeight
FROM Sales.Orders
WHERE Weight > 50
GROUP BY CustomerID;

--PUZZLE 7.Carts

SELECT ISNULL(C1.Item, '') AS ITEM ,ISNULL(C2.Item,'') AS ITEM 
FROM Cart1 AS C1
FULL JOIN Cart2 AS C2 
ON C1.Item = C2.Item
ORDER BY  
    CASE 
        WHEN C2.Item IS NULL THEN 1 ELSE 0 
    END, 
    C1.Item DESC;

--PUZZLE 8.Customers Who Never Order



SELECT C.id , C.name
FROM Customers AS C 
LEFT JOIN Orders AS O 
ON C.id = O.customerId
WHERE O.customerId IS NULL 


--PUZZLE 9. Students and Examinations
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;












