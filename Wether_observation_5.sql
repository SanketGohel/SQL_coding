#Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths #(i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one #that comes first when ordered alphabetically.


--select * from station

with cte as(
    select 
        city,
        LEN(city) as name,
        row_number() over(order by LEN(city),city) as smallest_city,
        row_number() over (order by LEN(city)desc,city) as longest_city
    from 
        station)
select 
    city,name
from 
    cte
where smallest_city = 1
Union all
select  
    city, name
from 
    cte
where 
    longest_city = 1
