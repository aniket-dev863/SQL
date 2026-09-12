/*
Question 18 — Challenge 🔥

Now we're going to test whether you can choose between EXISTS / NOT EXISTS and JOIN/GROUP BY.

Tables:

Employee
id | name | dept_id | salary

Project
project_id | project_name

EmployeeProject
employee_id | project_id
Task

Find employees who are assigned to at least one project but are not assigned to any project named "Internal Audit".

*/

SELECT e.name 
FROM Employee 
WHERE EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    WHERE ep.employeeId = e.id 
)
AND NOT EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    JOIN Project p 
        ON ep.project_id = p.project_id 
    WHERE ep.employee_id = e.id 
        AND p.project_name = 'Internal Audit'
)
