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

-- Task 14:
select round(min(lat_n),4)from (select lat_n from station where lat_n > 38.7780) res;

-- Task 15:
select round((long_w),4)from station 
where lat_n = (select min(lat_n) from station where lat_n > 38.7790)


-- Task 16:
select round(abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)),4)
from station;

-- Task 17:
WITH 
    total_lead_manager as (
        select company_code,count(lead_manager_code) from lead_manager 
        group by company_code
    ),
    total_senior_manager as(
        select company_code,count(senior_manager_code) from senior_manager
        group by company_code
    ),
    total_manager as(
        select company_code,count(manager_code) from manager
        group by company_code
    ),
    total_employee as(
        select company_code,count(employee_code) from employee
        group by company_code
    )
select *
from company c
join total_lead_manager lm on c.company_code = lm.company_code
join total_senior_manager sm on c.company_code = sm.company_code
join total_manager m on c.company_code = m.company_code
join total_employee e  on c.company_code = e.company_code;

-- Ver2
SELECT c.company_code,c.founder,
       (SELECT COUNT(distinct(lead_manager_code)) FROM lead_manager WHERE lead_manager.company_code = c.company_code) AS lead_manager_count,
       (SELECT COUNT(distinct(senior_manager_code)) FROM senior_manager WHERE senior_manager.company_code = c.company_code) AS senior_manager_count,
       (SELECT COUNT(distinct(manager_code)) FROM manager WHERE manager.company_code = c.company_code) AS manager_count,
       (SELECT COUNT(distinct(employee_code)) FROM employee WHERE employee.company_code = c.company_code) AS employee_count
FROM company c
order by char_length(c.company_code), c.company_code;

-- Task 18:
select round(sqrt(power(min(lat_n) - max(lat_n),2) + power(min(long_w) - max(long_w),2)),4)
from station;

