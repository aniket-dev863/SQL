/*
Question 14 — Higher level

Use Employee + Department.

Find the highest-paid employee from every department whose average salary is greater than the overall company average.

Expected structure:

Department | Employee | Salary
*/

SELECT e.dept_id, MAX(e.salary) AS max_salary
FROM Employee e
JOIN (
    SELECT dept_id
    FROM Employee
    GROUP BY dept_id
    HAVING AVG(salary) > (
        SELECT AVG(salary)
        FROM Employee
    )
) q
    ON e.dept_id = q.dept_id
GROUP BY e.dept_id;