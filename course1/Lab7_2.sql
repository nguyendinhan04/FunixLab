-- Task 1:
select sum(population) from city 
where district = 'California';

-- Task 2:
select avg(population) from city 
where district = 'California';

-- Task 3:
select case 
    when avg(population) - round(avg(population),0) > 0 then round(avg(population),0)
    else round(avg(population),0) -1
end
from city;

-- Task 4:
select sum(population) from city
where countrycode = 'JPN';

-- Task 5:
select max(population) - min(population) from city;

-- Task 6:
select case
    when avg(salary) - avg(replace(salary,"0","")) > round(avg(salary) - avg(replace(salary,"0","")),0) then round(avg(salary) - avg(replace(salary,"0","")),0) + 1
    else round(avg(salary) - avg(replace(salary,"0","")),0)
end
from employees

-- Task 7:
select salary*months as total,count(*) from employee
where (salary*months) = (select max(salary*months) from employee)
group by salary*months;

-- Task 8:
select round(sum(lat_n),2),round(sum(long_w),2) from station;

-- Task 9:
select (select count(*) from station) - (select count(distinct city) from station)

-- Task 10:
select city, char_length(city) as len from station
where char_length(city) = (select min(char_length(city)) from station)
order by city limit 1;

select city, char_length(city) as len from station
where char_length(city) = (select max(char_length(city)) from station)
order by city limit 1;

-- Task 11:
select round(sum(lat_n),4) from station
where lat_n > 38.7880 and lat_n < 137.2345;

-- Task 12:
select (round(max(lat_n),4)) from station
where lat_n < 137.2345;

-- Task 13:
select round(long_w,4) from station
where lat_n = (select max(lat_n) from station
where lat_n < 137.2345);