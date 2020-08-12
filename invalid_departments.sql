#Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.

#Return the result table in any order.


# Write your MySQL query statement below
select s.id,s.name 
from students s
left join departments d
on s.department_id= d.id
where d.name is null