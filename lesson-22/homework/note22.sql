
--LESSON 22 AGGREGATED WINDOW FUNCTIONS 


--1 Compute Running Total Sales per Customer

SELECT *,
SUM(total_amount) OVER (PARTITION BY Customer_id ORDER BY 
order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNINGTOTALSALE
FROM sales_data

--2 Count the Number of Orders per Product Category

SELECT *,
COUNT( quantity_sold) OVER (PARTITION BY Product_category) AS ORDERPERCATEGORY
FROM sales_data

--3 Find the Maximum Total Amount per Product Category

SELECT * ,
MAX(total_amount) OVER (PARTITION BY Product_category) AS MAXTOTALAMOUNT
FROM sales_data


--4 Find the Minimum Price of Products per Product Category
SELECT *,
MIN(unit_price) OVER (PARTITION BY Product_category) AS MINPRICE
FROM sales_data 

--5 Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

SELECT *,
CAST(AVG(total_amount) OVER (
ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING  ) AS DECIMAL (10,2)) AS MOVAVG
FROM sales_data

--6 Find the Total Sales per Region

SELECT *,
SUM(total_amount) OVER (PARTITION BY region) AS PERREGION
FROM sales_data


--7 Compute the Rank of Customers Based on Their Total Purchase Amount

;WITH CTE AS (
SELECT customer_id,
SUM(total_amount) AS TOTALPURCHASE
FROM sales_data
GROUP BY customer_id)

SELECT * , 
RANK() OVER (ORDER  BY TOTALPURCHASE) AS RNK
FROM CTE

--8 Calculate the Difference Between Current and Previous Sale Amount per Customer

SELECT * ,
LAG(total_amount) OVER (PARTITION BY Customer_id ORDER BY Order_date) AS PREVSALE,
total_amount-LAG(total_amount) OVER (PARTITION BY Customer_id ORDER BY Order_date) AS DIFFPREV
FROM sales_data

--9 Find the Top 3 Most Expensive Products in Each Category

;WITH CTE AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY total_amount) AS RNK
FROM sales_data)

SELECT * FROM CTE 
WHERE RNK <=3

--10 Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT *,
SUM(total_amount) OVER (PARTITION BY region
ORDER BY order_date ROWS BETWEEN  UNBOUNDED PRECEDING AND CURRENT ROW) AS CUMULATIVESUM
FROM sales_data

--11 Compute Cumulative Revenue per Product Category

SELECT *,
SUM(total_amount) OVER (PARTITION BY product_category 
ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS CUMULATIVEREVENUE
FROM sales_data



--12 Here you need to find out the sum of previous values. Please go through the sample input and expected output.

CREATE TABLE NUMBERS (ID INT)
INSERT INTO NUMBERS VALUES (1),(2),(3),(4),(5)

SELECT *,
SUM(ID) OVER (ORDER BY ID ) AS SUMID
FROM NUMBERS

--13 Sum of Previous Values to Current Value

SELECT *,
ISNULL(
SUM(Value) OVER ( ORDER BY Value 
ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING),0) 
+ VALUE AS SUMPREV
FROM OneColumn

--14 Find customers who have purchased items from more than one product_category

;WITH CTE AS (
SELECT *,
DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Product_category) AS RNK
FROM sales_data)

SELECT DISTINCT Customer_id, customer_name ,
product_category ,product_name 
FROM CTE 
WHERE RNK=1 


--15 Find Customers with Above-Average Spending in Their Region


;WITH CustomerSpending AS (
    SELECT 
        customer_id,
        region,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id, region
),
AvgSUM AS ( 
    SELECT 
        customer_id,
        region,
        total_spent,
        AVG(total_spent) OVER (PARTITION BY region) AS avg_region_spent
    FROM CustomerSpending
)
SELECT *
FROM AvgSUM
WHERE total_spent > avg_region_spent;



--16 Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.

WITH CTE AS (
SELECT customer_id, customer_name, region,
SUM(total_amount) AS TOTALSUM
FROM sales_data
GROUP BY  customer_id, customer_name, region)

SELECT *,
RANK() OVER (PARTITION BY region ORDER BY TOTALSUM) AS SPENDINGRANK
FROM CTE 
ORDER BY region, SPENDINGRANK

--17 Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

SELECT *,
SUM(total_amount) OVER (
PARTITION BY customer_id 
ORDER BY order_date 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM sales_data

--18 Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

;WITH CTE AS (
    SELECT 
        MONTH(order_date) AS monthl,
        SUM(total_amount) AS total_sum
    FROM sales_data
    GROUP BY MONTH(order_date)
)
SELECT 
    monthl,
    total_sum,
    LAG(total_sum) OVER (ORDER BY monthl) AS prev_month_sale,
    ((total_sum - LAG(total_sum) OVER (ORDER BY monthl)) 
        / NULLIF(LAG(total_sum) OVER (ORDER BY monthl), 0) * 100) AS growth_rate
FROM CTE;


--19 Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)


;WITH CTE AS (
    SELECT *,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total_amount
    FROM sales_data
)
SELECT *
FROM CTE
WHERE total_amount > prev_total_amount;

-- 20 Identify Products that prices are above the average product price

;WITH CTE AS (
SELECT *,
AVG(unit_price) OVER () AS AVGPRICE
FROM sales_data 
)

SELECT * FROM CTE
WHERE unit_price > AVGPRICE

-- 21 In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. 
--For more details please see the sample input and expected output.
SELECT *,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
    END AS Tot
FROM MyData;

-- 22 Here you have to sum up the value of the cost column based on the values of Id. 
--For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.

;WITH CTE AS (
    SELECT *,
        SUM(Cost) OVER (PARTITION BY Id) AS TotalCost,
        ROW_NUMBER() OVER (PARTITION BY Id, Quantity ORDER BY (SELECT NULL)) AS rn
    FROM TheSumPuzzle
)
SELECT 
    Id,
    MAX(TotalCost) AS Cost,
    SUM(CASE WHEN rn = 1 THEN Quantity ELSE 0 END) AS Quantity
FROM CTE
GROUP BY Id;


--23 From following set of integers, write an SQL statement to determine the expected outputs

;WITH CTE AS (
    SELECT 
        SeatNumber,
        LAG(SeatNumber) OVER (ORDER BY SeatNumber) AS PrevSeat
    FROM Seats
)
SELECT 
    PrevSeat + 1 AS GapStart,
    SeatNumber - 1 AS GapEnd
FROM CTE
WHERE PrevSeat IS NOT NULL
  AND SeatNumber - PrevSeat > 1

UNION ALL
-- Добавим "дырку" до самого первого места
SELECT 1, MIN(SeatNumber) - 1
FROM Seats
HAVING MIN(SeatNumber) > 1
ORDER BY GapStart
