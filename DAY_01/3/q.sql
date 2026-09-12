/*
Question 13 — JOIN + GROUP BY + HAVING + Subquery

Tables:

Employee
id | name | salary | dept_id

Department
dept_id | dept_name
Task

Find the department names whose average salary is greater than the overall average salary of all employees.


*/

SELECT d.dept_name
FROM Employee  e 
JOIN (
    SELECT AVG(salary) AS avg , dept_id 
    FROM Employee
    GROUP BY Dept_id 
)m
    ON e.dept_id = m.dept_id 
JOIN Department d 
    ON e.dept_id = d.dept_id 
WHERE m.avg>(
    SELECT AVG(salary)
    FROM Employee
)


SELECT d.dept_name
FROM Employee  e 
JOIN (
    SELECT AVG(salary) AS avg , dept_id 
    FROM Employee
    GROUP BY Dept_id 
)m
    ON e.dept_id = m.dept_id 
JOIN Department d 
    ON e.dept_id = d.dept_id 
GROUP BY Dept_id 
HAVING m.avg>(
    SELECT AVG(salary)
    FROM Employee 
)

/* Correct One */

SELECT d.dept_name
FROM Employee e
JOIN (
    SELECT dept_id, AVG(salary) AS dept_avg
    FROM Employee
    GROUP BY dept_id
) m
    ON e.dept_id = m.dept_id
JOIN Department d
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name, m.dept_avg
HAVING m.dept_avg > (
    SELECT AVG(salary)
    FROM Employee
);