
--1. Find customers who purchased at least one item in March 2024 using EXISTS

SELECT CustomerName
FROM Sales AS S1
WHERE EXISTS ( SELECT * FROM Sales AS S2 
				WHERE S1.CustomerName=S2.CustomerName AND
				SaleDate BETWEEN '2024-03-01' AND'2024-03-30'
				AND Quantity >=1)



--2. Find the product with the highest total sales revenue using a subquery.

  with ProductTotals as (
    select Product, SUM(Quantity * Price) as TotalRevenue
    from Sales
    group by Product
)
select Product, TotalRevenue
from ProductTotals
where TotalRevenue = (
    select MAX(TotalRevenue) 
    from ProductTotals
)


--3. Find the second highest sale amount using a subquery

;WITH CTE AS (
		SELECT Product, 
		Quantity * Price AS AMOUNT 
		FROM Sales 
) 

SELECT MAX(AMOUNT) AS SECONDHIGHEST
FROM CTE 
WHERE AMOUNT<(SELECT MAX(AMOUNT) FROM CTE)



--4. Find the total quantity of products sold per month using a subquery


SELECT MONTH(SaleDate ) AS P_MONTH,
	(SELECT  SUM(Quantity)
	FROM Sales AS S2 
	WHERE MONTH(S2.SaleDate)=MONTH(S.SaleDate)
	) AS TOTALQUANTITY
FROM Sales AS S
GROUP BY  MONTH(S.SaleDate)



--5 Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT S1.CustomerName, S1.Product 
FROM Sales AS S1 
WHERE EXISTS (
	SELECT 1
	FROM Sales AS S2
	WHERE S1.Product=S2.Product
	AND S1.CustomerName<> S2.CustomerName
	)
ORDER BY S1.Product 

--6. Return how many fruits does each person have in individual fruit level

SELECT
    t.Name,
    SUM(CASE WHEN t.Fruit = 'Apple'  THEN t.Qty ELSE 0 END) AS Apple,
    SUM(CASE WHEN t.Fruit = 'Orange' THEN t.Qty ELSE 0 END) AS Orange,
    SUM(CASE WHEN t.Fruit = 'Banana' THEN t.Qty ELSE 0 END) AS Banana
FROM (
    SELECT Name, Fruit, COUNT(*) AS Qty
    FROM Fruits
    GROUP BY Name, Fruit
) t
GROUP BY t.Name;



--7. Return older people in the family with younger ones

;WITH FamilyTree AS (
    -- Базовый случай: прямые связи родитель → ребёнок
    SELECT ParentId, ChildId
    FROM Family
    
    UNION ALL
    
    -- Рекурсия: берём ребёнка как нового родителя
    SELECT ft.ParentId, f.ChildId
    FROM FamilyTree ft
    JOIN Family f
        ON ft.ChildId = f.ParentId
)
SELECT *
FROM FamilyTree
ORDER BY ParentId



--8. Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas


SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
        SELECT 1
        FROM Orders o2
        WHERE o2.CustomerID = o.CustomerID
          AND o2.DeliveryState = 'CA'
    );


--9. Insert the names of residents if they are missing

select * ,
case when charindex('name=', address)=0 
then stuff(address, charindex('age=', address),0, concat('name=', fullname, ' '))
else address 
end as updated
from residents



--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes


;WITH AllRoutes AS (
    SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 100 + 400 AS Cost
    UNION ALL
    SELECT 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm', 100 + 50 + 200 + 300
)
SELECT Route, Cost
FROM AllRoutes
WHERE Cost = (SELECT MIN(Cost) FROM AllRoutes)
   OR Cost = (SELECT MAX(Cost) FROM AllRoutes);



--11. Rank products based on their order of insertion.

SELECT 
    t.ID,
    t.Vals,
    r.ProductRank
FROM RankingPuzzle AS t
JOIN (
    SELECT 
        ID,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductRank
    FROM RankingPuzzle
)AS  r ON t.ID = r.ID
ORDER BY t.ID;

--Question 12
--Find employees whose sales were higher than the average sales in their department


SELECT S.EmployeeName, S.Department, S.SalesAmount
FROM EmployeeSales AS S
WHERE S.SalesAmount> (
		SELECT AVG(E.SalesAmount ) AS AVG_AMOUNT 
		FROM EmployeeSales AS E
		WHERE E.Department = S.Department )



--13. Find employees who had the highest sales in any given month using EXISTS

SELECT S.EmployeeName, S.Department, S.SalesAmount, S.SalesMonth 
FROM EmployeeSales AS S
WHERE EXISTS (
		SELECT 1
		FROM EmployeeSales AS E
		WHERE E.SalesMonth = S.SalesMonth
		      AND E.SalesAmount = (
          SELECT MAX(E2.SalesAmount)
          FROM EmployeeSales AS E2
          WHERE E2.SalesMonth = S.SalesMonth
      )
	     AND E.EmployeeID = S.EmployeeID
);


--14. Find employees who made sales in every month using NOT EXISTS

SELECT  S.EmployeeID, S.EmployeeName
FROM EmployeeSales AS S
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT SalesMonth FROM EmployeeSales) AS M
    WHERE NOT EXISTS (
        SELECT 1
        FROM EmployeeSales AS E
        WHERE E.EmployeeID = S.EmployeeID
          AND E.SalesMonth = M.SalesMonth
    )
);


--15. Retrieve the names of products that are more expensive than the average price of all products.

SELECT P.Name, P.Price 
FROM Products AS P
WHERE P.Price > (
		SELECT AVG(A.Price) AS AVG_AMOUNT 
		FROM Products AS A)


--16. Find the products that have a stock count lower than the highest stock count.

SELECT P.Name, P.Stock
FROM Products AS P
WHERE P.Stock<(
		SELECT MAX(A.Stock) 
		FROM Products AS A)


--17. Get the names of products that belong to the same category as 'Laptop'.

SELECT P.Name
FROM Products AS P
WHERE P.Category IN (
		SELECT A.Category  
		FROM Products AS A
		 WHERE A.Name = 'Laptop'
		 )

--18. Retrieve products whose price is greater than the lowest price in the Electronics category.

SELECT P.Name, P.Price
FROM Products AS P
WHERE P.Price > (
		SELECT MIN(A.Price)  
		FROM Products AS A
		WHERE A.Category='Electronics'
		 )

--19. Find the products that have a higher price than the average price of their respective category.


SELECT P.Name, P.Price, P.Category
FROM Products AS P
WHERE P.Price > (
		SELECT AVG(A.Price)  
		FROM Products AS A
		WHERE A.Category=P.Category
		 )

--20. Find the products that have been ordered at least once.

SELECT DISTINCT P.Name, P.ProductID
FROM Products AS P
WHERE EXISTS (
    SELECT 1
    FROM Orders_ AS O
    WHERE O.ProductID = P.ProductID
);


--21. Retrieve the names of products that have been ordered more than the average quantity ordered.

SELECT P.Name, SUM(O.Quantity) AS TotalOrdered
FROM Products AS P
JOIN Orders_ AS O ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.Name
HAVING SUM(O.Quantity) > (
    SELECT AVG(Quantity) 
    FROM Orders_
);

--22. Find the products that have never been ordered.

SELECT P.Name
FROM Products AS P
WHERE P.ProductID NOT IN (
    SELECT DISTINCT O.ProductID
    FROM Orders_ AS O
);


--23. Retrieve the product with the highest total quantity ordered.

SELECT P.Name, SUM(O.Quantity) AS TotalOrdered
FROM Products AS P
JOIN Orders_ AS O 
ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.Name
HAVING SUM(O.Quantity) = (
    SELECT MAX(TotalQty)
    FROM (
        SELECT SUM(O2.Quantity) AS TotalQty
        FROM Orders_ AS O2
        GROUP BY O2.ProductID
    ) AS Sub
);
