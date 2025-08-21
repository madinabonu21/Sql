
USE LESSON17


--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
--Assume there is at least one sale for each region

CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);


SELECT
    rd.Region,
    rd.Distributor,
    ISNULL(s.Sales, 0) AS Sales
FROM
(
    SELECT r.Region, d.Distributor
    FROM (SELECT DISTINCT Region FROM #RegionSales) r
    CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
) rd
LEFT JOIN #RegionSales s
    ON rd.Region = s.Region AND rd.Distributor = s.Distributor
ORDER BY rd.Distributor



--2. Find managers with at least five direct reports

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId, COUNT(*) AS direct_reports
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;


--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.


SELECT 
    p.product_name,
    t.total_units AS unit
FROM Products p
JOIN (
    SELECT 
        product_id,
        SUM(unit) AS total_units
    FROM Orders
    WHERE order_date >= '2020-02-01' AND order_date < '2020-03-01'
    GROUP BY product_id
    HAVING SUM(unit) >= 100
) t ON p.product_id = t.product_id;


--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders

-- Считаем заказы по каждому вендору
;WITH VendorCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount
    FROM Orders_
    GROUP BY CustomerID, Vendor
),
-- Находим максимум заказов по каждому CustomerID
MaxVendor AS (
    SELECT 
        CustomerID,
        MAX(OrderCount) AS MaxOrders
    FROM VendorCounts
    GROUP BY CustomerID
)
-- Выбираем только тех вендоров, у которых заказов = максимум
SELECT v.CustomerID, v.Vendor
FROM VendorCounts v
JOIN MaxVendor m 
  ON v.CustomerID = m.CustomerID 
 AND v.OrderCount = m.MaxOrders;

 --5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'


 DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

-- Проверяем только от 2 до sqrt(@Check_Prime)
WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @IsPrime = 0;
        BREAK; -- число делится на i → не простое
    END
    SET @i = @i + 1;
END

IF @IsPrime = 1 AND @Check_Prime > 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


--6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.


	SELECT 
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS no_of_location,
    (
        SELECT TOP 1 d2.Locations
        FROM Device d2
        WHERE d2.Device_id = d.Device_id
        GROUP BY d2.Locations
        ORDER BY COUNT(*) DESC
    ) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d
GROUP BY d.Device_id;



--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output


SELECT EmpID, EmpName, Salary
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DeptID = e.DeptID
);


--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. 
--Calculate the total winnings for today’s drawing.

-- Посчитаем количество выигрышных номеров
DECLARE @TotalWinningNumbers INT = (SELECT COUNT(*) FROM Numbers);

-- Группируем по билету и считаем совпадения
WITH MatchCounts AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS MatchedCount
    FROM Tickets t
    INNER JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
)
-- Вычисляем выигрыш для каждого билета
, Winnings AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchedCount = @TotalWinningNumbers THEN 100
            WHEN MatchedCount > 0 THEN 10
            ELSE 0
        END AS Prize
    FROM MatchCounts
)
-- Суммируем итоговый выигрыш
SELECT SUM(Prize) AS TotalWinnings
FROM Winnings;


--9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

;WITH UserPlatform AS (
    SELECT 
        Spend_date,
        User_id,
        SUM(CASE WHEN Platform = 'Mobile'  THEN Amount ELSE 0 END) AS MobileAmount,
        SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopAmount
    FROM Spending
    GROUP BY Spend_date, User_id
),
Agg AS (
    SELECT
        Spend_date,
        CASE 
            WHEN MobileAmount > 0 AND DesktopAmount = 0 THEN 'Mobile'
            WHEN DesktopAmount > 0 AND MobileAmount = 0 THEN 'Desktop'
            WHEN MobileAmount > 0 AND DesktopAmount > 0 THEN 'Both'
        END AS Platform,
        SUM(MobileAmount + DesktopAmount)      AS Total_Amount,
        COUNT(DISTINCT User_id)                AS Total_users
    FROM UserPlatform
    GROUP BY Spend_date,
             CASE 
                 WHEN MobileAmount > 0 AND DesktopAmount = 0 THEN 'Mobile'
                 WHEN DesktopAmount > 0 AND MobileAmount = 0 THEN 'Desktop'
                 WHEN MobileAmount > 0 AND DesktopAmount > 0 THEN 'Both'
             END
)
SELECT Spend_date, Platform, Total_Amount, Total_users
FROM Agg
ORDER BY Spend_date,
         CASE Platform WHEN 'Mobile' THEN 1 WHEN 'Desktop' THEN 2 WHEN 'Both' THEN 3 END;



--10. Write an SQL Statement to de-group the following data.
;WITH RecursiveCTE AS (
    SELECT 
        Product,
        1 AS Quantity,
        Quantity AS OriginalQty
    FROM Grouped
    UNION ALL
    SELECT 
        Product,
        1,
        OriginalQty - 1
    FROM RecursiveCTE
    WHERE OriginalQty > 1
)
SELECT Product, Quantity
FROM RecursiveCTE
ORDER BY Product
OPTION (MAXRECURSION 0);
