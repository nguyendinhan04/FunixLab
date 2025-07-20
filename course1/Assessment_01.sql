-- Task 1:
use hr;
select first_name,last_name, job_id, salary
from employees
where first_name like 'S%';

-- Task 2:
with max_salary as(
    select max(salary) from employees
)
select employee_id, first_name,last_name, job_id, salary
from employees 
where salary = (select * from max_salary);

-- select employee_id, first_name,last_name, job_id, salary
-- from employees 
-- where salary = (select max(salary) from employees);

-- Task 3:
with second_max as(
    select salary from employees 
    group by salary
    order by salary desc
    limit 1 
    offset 1
)
select employee_id, first_name,last_name, job_id, salary
from employees 
where salary = (select * from second_max);

-- Task 4:
with second_max as(
    select salary from employees 
    group by salary
    order by salary desc
    limit 1 
    offset 2
)
select employee_id, first_name,last_name, job_id, salary
from employees 
where salary = (select * from second_max);

-- second solution: using set variable
set @second_max = (select salary from employees 
    group by salary
    order by salary desc
    limit 1 
    offset 2);
select employee_id, first_name,last_name, job_id, salary
from employees 
where salary = @second_max;

-- SHOW SESSION VARIABLES
-- where variable_name like '%second%';

SELECT * FROM information_schema.session_variables;

-- Task 5:
-- Case 1:if the task only require getting name and salary of only employees' who have manager
select concat(e1.first_name,' ',e1.last_name) as employee,e1.salary,concat(e2.first_name,' ',e2.last_name) as manager,e2.salary
from employees e1
inner join employees e2
on e1.manager_id = e2.employee_id;

-- Case 2: if the task ask  to get all name and salary of all employees then there will be employee having np manager so we have to use ifnull to check whether he/she have manager.
select concat(e1.first_name,' ',e1.last_name) as employee,e1.salary,ifnull(concat(e2.first_name,' ',e2.last_name),'Not have manager') as manager,ifnull(e2.salary,0)
from employees e1
left join employees e2
on e1.manager_id = e2.employee_id;

-- Task 6:
select e2.employee_id,concat(e2.first_name,e2.last_name) as manager_name, count(e1.employee_id) as number_of_reportees 
from employees e1
inner join employees e2 on e1.manager_id = e2.employee_id
group by e2.employee_id
order by number_of_reportees desc;


-- Task 7: 
with emp_dep as(
    select employee_id, department_id from employees
)
select d.department_name,count(*) as emp_count
from emp_dep
join departments d on emp_dep.department_id = d.department_id
group by d.department_name
order by emp_count desc ;


-- Task 8:
select date_format(hire_date,'%Y') as hired_year,count(*) as employees_hired_count
from employees 
group by hired_year
order by employees_hired_count desc,hired_year;

-- Task 9:
select round(max(salary),0)as max_sal,round(min(salary),0)as min_sal, round(avg(salary),0)as avg_sal
from employees;

-- Task 10:
select concat(first_name,' ',last_name) as employee, salary, 
case
    when salary >= 10000 then 'high'
    when salary >= 5000 then 'mid'
    when salary >= 2000 then 'low'
end as salary_level
from employees
order by employee;

-- Task 11:
select concat(first_name,' ',last_name) as employee, concat(substring(phone_number,1,3),'-',substring(phone_number,5,3),'-',substring(phone_number,9,4)) as phone_number 
from employees;

-- Task 12:
select concat(first_name,' ',last_name) as employee, hire_date  
from employees 
where hire_date like '1994-08-%';

-- Task 13:
with avg_sal as (
    select avg(salary) from employees
)
select concat(first_name,' ',last_name) as name, employee_id, department_id, salary
from employees
having salary > (select * from avg_sal)
order by department_id;

-- Task 14:
with dep_max as(
    select department_id, max(salary) as maximum_salary
    from employees
    group by department_id
    order by department_id
)
select dep_max.department_id, d.department_name, dep_max.maximum_salary  
from dep_max
join departments d on dep_max.department_id = d.department_id;

-- Task 15:
select employee_id, concat(first_name,' ',last_name) as employee_name, salary
from employees
order by salary
limit 5;


-- Task 16:
select first_name,reverse(lower(first_name))
from employees;

-- Task 17:
select employee_id, concat(first_name, ' ', last_name), hire_date
from employees
where date_format(hire_date,'%e') - '15' > 0;

-- Task 18:
select concat(e2.first_name,' ',e2.last_name) as manager,concat(e1.first_name,' ',e1.last_name) as employee,e2.department_id as mgr_id,e1.department_id as emp_id
from employees e1
inner join employees e2
on e1.manager_id = e2.employee_id
where e1.department_id != e2.department_id
order by manager;

 
 
 