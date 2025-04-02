-- Write your PostgreSQL query statement below
Select 
    name
from Employee As t1
JOIN (
    SELECT 
        managerId
    FROM 
        Employee
    Group by 
        managerId
    HAVING count(managerId) >= 5
) AS t2
ON t1.id = t2.managerid
