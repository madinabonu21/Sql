USE LESSON21HM
--Write a query to assign a row number to each sale based on the SaleDate.

SELECT *,
ROW_NUMBER() OVER (ORDER BY SaleDate)
FROM ProductSales

--Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
SELECT 
 ProductName,
SUM(Quantity) AS TotalQuantity,
DENSE_RANK() OVER (ORDER BY SaleAmount)
FROM ProductSales
GROUP BY  ProductName

--Write a query to identify the top sale for each customer based on the SaleAmount.

;WITH RANKSALE AS (
SELECT * , 
ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC )AS RN
FROM  ProductSales)

SELECT * FROM RANKSALE
WHERE RN=1
ORDER BY CustomerID

--Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.

SELECT *,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate ASC ) AS NextSaleAmount
FROM ProductSales;


--Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
SELECT *,
    LAG(SaleAmount) OVER (ORDER BY SaleDate ASC ) AS PREVIOUSSaleAmount
FROM ProductSales;


--Write a query to identify sales amounts that are greater than the previous sale's amount

;WITH CTE AS (
SELECT * ,
   LAG(SaleAmount) OVER (ORDER BY SaleDate ASC ) AS PREVIOUSSaleAmount
FROM ProductSales)

SELECT * FROM CTE
WHERE SaleAmount> PREVIOUSSaleAmount


--Write a query to calculate the difference in sale amount from the previous sale for every product


;WITH CTE AS (
SELECT * ,
LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ASC ) AS PREVIOUSSaleAmount,
 SaleAmount -  LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ASC ) AS DIFFERENCES
FROM ProductSales)

SELECT * FROM CTE


--Write a query to compare the current sale amount with the next sale amount in terms of percentage change.

;WITH CTE AS (
SELECT * ,
LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate  ) AS NEXTSaleAmount
FROM ProductSales)

SELECT * ,
CASE WHEN NEXTSaleAmount IS NULL THEN 0
ELSE CEILING((SaleAmount-NEXTSaleAmount * 100.0/SaleAmount)) 
END AS PERCENTCHANGE 
FROM CTE

--Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.

; WITH RATIO AS(
SELECT *,
LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PREVSALE
FROM ProductSales)

SELECT *,
CASE WHEN PREVSALE IS NULL THEN 0 
ELSE CAST (((SaleAmount*1.0/PREVSALE)) AS DECIMAL(10,2))
END AS RatioToPrev
FROM RATIO

--Write a query to calculate the difference in sale amount from the very first sale of that product.

;WITH CTE AS (
SELECT*,
FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FIRSTSALE
FROM ProductSales)

SELECT * ,
SaleAmount-FIRSTSALE AS DIFFERENCES
FROM CTE
ORDER BY SaleDate, ProductName

--Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).

;WITH CTE AS (
    SELECT *,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
)
SELECT *
FROM CTE
WHERE PrevSaleAmount IS NOT NULL 
  AND SaleAmount > PrevSaleAmount
ORDER BY ProductName, SaleDate;

--Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (
        ORDER BY SaleDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingBalance
FROM ProductSales
ORDER BY SaleDate;

--Write a query to calculate the moving average of sales amounts over the last 3 sales.

WITH SalesWithMovingAvg AS (
    SELECT 
        ProductName,
        SaleDate,
        SaleAmount,
        AVG(SaleAmount * 1.0) OVER (
            PARTITION BY ProductName
            ORDER BY SaleDate
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS MovingAvgLast3
    FROM ProductSales
)
SELECT*,
    CAST(MovingAvgLast3 AS DECIMAL(10,2)) AS MovingAvgLast3
FROM SalesWithMovingAvg
ORDER BY ProductName, SaleDate;


--Write a query to show the difference between each sale amount and the average sale amount.

SELECT * , 
CAST(SaleAmount- AVG(SaleAmount) OVER (PARTITION BY ProductName ) AS DECIMAL(10,2)) AS DIFFERENCES 
FROM ProductSales

--Find Employees Who Have the Same Salary Rank

;WITH CTE AS (
    SELECT 
        EmployeeID,
        Name,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT *
FROM CTE
WHERE Salary IN (
    SELECT Salary 
    FROM Employees1
    GROUP BY Salary
    HAVING COUNT(*) > 1
)
ORDER BY Salary, EmployeeID;

--Identify the Top 2 Highest Salaries in Each Department

;WITH CTE AS (
SELECT*,
RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RNK
FROM Employees1
)

SELECT * FROM CTE 
WHERE RNK<=2
--Find the Lowest-Paid Employee in Each Department

;WITH CTE AS (
SELECT*,
RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RNK
FROM Employees1
)

SELECT * FROM CTE 
WHERE RNK<=2

--Calculate the Running Total of Salaries in Each Department

SELECT * ,
SUM(Salary) OVER (PARTITION BY Department
        ORDER BY EmployeeID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Employees1


--Find the Total Salary of Each Department Without GROUP BY

SELECT * ,
SUM(Salary) OVER (PARTITION BY Department) AS TOTALSALARY
FROM Employees1


--Calculate the Average Salary in Each Department Without GROUP BY

SELECT * ,
AVG(Salary) OVER (PARTITION BY Department) AS AVGSALARY
FROM Employees1

--Find the Difference Between an Employee’s Salary and Their Department’s Average


SELECT *,
Salary-AVG(Salary) OVER (PARTITION BY Department) AS DIFFERENCES 
FROM Employees1

--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT 
    EmployeeID,
    Name,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees1;

--Find the Sum of Salaries for the Last 3 Hired Employees
SELECT SUM(Salary) AS TotalLast3Salaries
FROM (
    SELECT 
        EmployeeID,
        Salary,
        ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RN
    FROM Employees1
) AS T
WHERE RN <= 3;
