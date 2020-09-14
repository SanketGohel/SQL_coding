#Write an SQL query to report the difference between number of apples and oranges sold each day.

#Return the result table ordered by sale_date in format ('YYYY-MM-DD').


# Write your MySQL query statement below
With A as
(select sum(sold_num) as a_s,sale_date
from Sales
where fruit = "apples"
GROUP BY sale_date),O as
(select sum(sold_num) as o_s, sale_date
from sales
where fruit = "oranges"
GROUP BY sale_date)
select A.SALE_DATE, (a_s - o_s) as DIFF
from A,O
where A.sale_date = O.sale_date
Group by A.sale_date
