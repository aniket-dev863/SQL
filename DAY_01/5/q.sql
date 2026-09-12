/*
Question 15 — JOIN + GROUP BY + HAVING + Subquery 🔥

We will change the pattern slightly.

Tables
Employee
id | name | salary | dept_id

Department
dept_id | dept_name
Task

Find the department names that have at least 3 employees and whose highest salary is greater than the overall average salary of all employees.

Expected output
Department
-----------
Engineering
Marketing


*/

SELECT d.dept_name
FROM Employee e
JOIN Department d
    ON e.dept_id = d.dept_id
GROUP BY dept_id 
HAVING MAX(salary)>(
    SELECT AVG(salary)
    FROM Employee
)
AND
    COUNT(*)>=3 ;