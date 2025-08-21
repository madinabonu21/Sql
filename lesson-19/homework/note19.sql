USE LESSON19HM


--TASK 1 Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)


CREATE PROC GetEmployeeBonus
AS
BEGIN
    -- создаем временную таблицу
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- вставляем данные
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus db
        ON e.Department = db.Department;

    -- возвращаем результат
    SELECT * FROM #EmployeeBonus;
END;

EXEC GetEmployeeBonus;

--TASK2 Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage


CREATE PROCEDURE UpdateDepartmentSalary
    @DepartmentName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- обновляем зарплаты
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DepartmentName;

    -- возвращаем обновленных сотрудников
    SELECT EmployeeID, FirstName, LastName, Department, Salary
    FROM Employees
    WHERE Department = @DepartmentName;
END;

EXEC UpdateDepartmentSalary @DepartmentName = 'Sales', @IncreasePercent = 5;

--TASK3

MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- обновляем совпадающие
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- вставляем новые
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- удаляем отсутствующие
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- возвращаем результат
SELECT * FROM Products_Current;


--TASK4 

SELECT 
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree;


--TASK 5 

SELECT 
    s.user_id,
    ROUND(
        COALESCE(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / COUNT(c.user_id), 0)
    , 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;


--TASK 6 

SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


--TASK7 

CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;

EXEC GetProductSalesSummary @ProductID = 1;
