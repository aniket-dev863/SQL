/*
    Greatest-per-group + Filtering

    Employee
+----+------+--------+---------+
| id | name | salary | dept_id |
+----+------+--------+---------+
| 1  | A    | 50000  | 10      |
| 2  | B    | 70000  | 10      |
| 3  | C    | 60000  | 20      |
| 4  | D    | 90000  | 20      |
| 5  | E    | 40000  | 30      |
| 6  | F    | 45000  | 30      |
+----+------+--------+---------+

Department
+---------+-------------+
| dept_id | dept_name   |
+---------+-------------+
| 10      | Engineering |
| 20      | Marketing   |
| 30      | HR          |
+---------+-------------+

Task

Find the department name and employee name of the highest-paid employee in departments whose average salary is greater than 50,000.
*/

SELECT d.dept_name , e.name 
FROM Employee e 
JOIN (
    SELECT dept_id , MAX(salary) as sal
    FROM Employee
    GROUP BY dept_id 
    HAVING AVG(salary)>=50000 
) m
    ON e.dept_id = m.dept_id 
    AND e.salary = m.sal
JOIN Department d  
    ON e.dept_id = d.dept_id 


