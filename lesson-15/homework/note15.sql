USE LESSON15

--Level 1: Basic Subqueries
--1. Find Employees with Minimum Salary
--Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)

SELECT id, name, salary 
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees)


--2. Find Products Above Average Price
--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

SELECT id, product_name, price
FROM Products 
WHERE price > (SELECT AVG(price) FROM Products)


--Level 2: Nested Subqueries with Conditions
--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

SELECT EMP.id, EMP.name
FROM Employees_ AS EMP
WHERE EXISTS ( 
	SELECT *
	FROM Departments AS DEP
	WHERE EMP.department_id=DEP.id 
	AND DEP.department_name= 'Sales')



--4. Find Customers with No Orders
--Task: Retrieve customers who have not placed any orders. 
--Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

SELECT C.name  
FROM Customers AS C 
WHERE NOT EXISTS (
	SELECT * 
	FROM Orders AS O 
	WHERE C.customer_id=O.customer_id
	)



--Level 3: Aggregation and Grouping in Subqueries
--5. Find Products with Max Price in Each Category
--Task: Retrieve products with the highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)

SELECT P1.id, P1.product_name, P1.price, P1.category_id
FROM Product AS P1
WHERE P1.price=(
	SELECT  MAX(P2.price) 
	FROM Product AS P2
	WHERE P1.category_id=P2.category_id
	GROUP BY category_id
	)




--Find Employees in Department with Highest Average Salary
--Task: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

SELECT e.id, e.name, e.salary, d.department_name
FROM Employeess AS e
JOIN Departments_ AS d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 e2.department_id
    FROM Employeess AS e2
    GROUP BY e2.department_id
    ORDER BY AVG(e2.salary) DESC
);



--7. Find Employees Earning Above Department Average
--Task: Retrieve employees earning more than the average salary in their department. 
--Tables: employees (columns: id, name, salary, department_id)


SELECT EMP1.id , EMP1.name , EMP1.salary 
FROM Employees AS EMP1
WHERE EMP1.Salary >(
	SELECT AVG(EMP2.salary)
	FROM Employees AS EMP2
	WHERE EMP1.department_id= EMP2.department_id
	)



--8. Find Students with Highest Grade per Course
--Task: Retrieve students who received the highest grade in each course. 
--Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

SELECT S.student_id, S.name, G.course_id, G.grade 
FROM students  AS S
JOIN Grades AS G 
ON S.student_id=G.student_id
WHERE G.grade= (
		SELECT MAX(G2.grade)
		FROM grades AS G2
		WHERE G.course_id=G2.course_id
		)




--9. Find Third-Highest Price per Category 
--Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)

SELECT * 
FROM Products AS p
WHERE p.price = (
    SELECT MIN(price)
    FROM (
        SELECT TOP 3 price
        FROM products
        WHERE category_id = p.category_id
        ORDER BY price DESC
    ) t
);


--10. Find Employees whose Salary Between Company Average and Department Max Salary
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
--Tables: employees (columns: id, name, salary, department_id)

SELECT *
FROM Employees E
WHERE E.Salary > (SELECT AVG(Salary) FROM Employees)      
  AND E.Salary < (SELECT MAX(Salary)                    
                  FROM Employees 
                  WHERE department_id = E.department_id)
