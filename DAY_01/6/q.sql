/**
    🚀 Question 16 — New pattern: NOT EXISTS

Now we're leaving the comfortable GROUP BY/HAVING zone.

Find employees who do not have any other employee in the same department earning a higher salary.

*/

SELECT e.name , e.salary ,e.dept_id
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee x
    WHERE e.dept_id = x.dept_id
    AND x.salary>e.salary
)