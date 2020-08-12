#Write a SQL query to get the second highest salary from the Employee table.

# Write your MySQL query statement below
#Finding for 2nd Highest Salary
select max(salary) as SecondHighestSalary
from Employee
where salary < (select max(salary) from employee)







#Finding the salary for nth position

SELECT salary AS SecondHighestSalary
FROM employee A
WHERE n-1 = (SELECT count(1) 
             FROM employee B 
             WHERE B.salary>A.salary)