-- Task 4:
select city from station 
where substring(city,1,1) in ('a','e','i','o','u') 
and substring(reverse(city),1,1) in ('a','e','i','o','u');
-- Task 5:
select distinct  city from station 
where substring(city,1,1) not in ('a','e','i','o','u');
-- Task 6:
select distinct city from station 
where substring(city,1,1) not in ('a','e','i','o','u') 
or substring(reverse(city),1,1) not in ('a','e','i','o','u');
-- Task 7:
select name from students 
where marks > 75
order by reverse(substring(reverse(name),1,3)),id asc;
-- Task 8: 
select 
case
    when a + b <= c or abs(a - b) >= c then 'Not A Triangle'
    when a = b and b=c and c = a then 'Equilateral'
    when a != b and b != c and c != a then 'Scalene'
    else 'Isosceles'
end
from triangles;
-- Task 9:
select name from employee
order by name;
