/*
    Find the employees who are the highest-paid in their department and whose salary is greater than the overall company average.
*/

SELECT e.name AS Name,  e.dept_id AS Department , e.salary AS Salary
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee x
    WHERE x.dept_id = e.dept_id
    AND x.salary>e.salary
)
AND e.salary >(
    SELECT AVG(salary)
    FROM Employee
)
