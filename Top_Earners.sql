#We define an employee's total earnings to be their monthly Salary * Months  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table.
#Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
#Then print these values as  space-separated integers.


SELECT
    TOP 1 (Months * Salary) AS Earnings,
    COUNT(*)
FROM
    Employee
GROUP BY
    (Months * Salary)
ORDER BY
    Earnings DESC;





-- select 
--     max(months*salary),count(months*salary) 
-- from   
--     employee 
-- where 
--     employee_id in( 
--         select 
--             employee_id 
--         from 
--             employee 
--         where 
--             months*salary in (
--                 select 
--                     max(months*salary) 
--                 from 
--                     employee))


