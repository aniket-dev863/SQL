/*
Find employees whose salary is greater than the average salary of their department AND greater than the overall company average salary.
*/

SELECT e.name 
FROM Employee e 
WHERE e.salary >(
    SELECT AVG(salary)
    FROM employee
)
JOIN(
    SELECT AVG(salary) as avg , dept_id 
    FROM employee 
    GROUP BY(dept_id)
)m
    ON e.dept_id = m.dept_id 
    AND e.salary>m.avg