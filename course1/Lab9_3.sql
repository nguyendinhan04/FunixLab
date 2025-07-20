    -- Task 1:
select sum(ci.population)
from city ci
left join country co on ci.countrycode = co.code
where co.continent = 'Asia'

-- Secend solution:
select sum(ci.population)
from city ci
join (select * from country where continent = 'Asia') co on ci.countrycode = co.code;

-- Task 2:
select ci.name
from city ci
left join country co on ci.countrycode = co.code
where co.continent = 'Africa'

-- Task 3:
select co.continent, case
    when round(avg(c.population),0) > avg(c.population) then (round(avg(c.population),0) - 1)
    else round(avg(c.population),0)
end 
from city c
join country co on c.countrycode = co.code
group by co.continent

-- Task 4:
select res.hacker_id, h.name
from (select s.hacker_id,count(*) as total
from submissions s 
left join challenges c on c.challenge_id = s.challenge_id
left join difficulty d on c.difficulty_level = d.difficulty_level
group by s.hacker_id
having count(*) >= 1 and sum(s.score) = sum(d.score)) res 
join hackers h on res.hacker_id = h.hacker_id
order by res.total desc , res.hacker_id;


select s.hacker_id, sum(d.score)
from submissions s
left join challenges c on c.challenge_id = s.challenge_id
left join difficulty d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by s.hacker_id
having count(s.hacker_id) > 1

select s.hacker_id, sum(d.score)
from submissions s
left join challenges c on c.challenge_id = s.challenge_id
left join difficulty d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by s.hacker_id
having count(s.hacker_id) > 1

-- Corect solution:
select res.hacker_id, h.name
from (select s.hacker_id, count(*) as total
from submissions s
left join challenges c on c.challenge_id = s.challenge_id
left join difficulty d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by s.hacker_id
having count(s.hacker_id) > 1) res 
join hackers h on res.hacker_id = h.hacker_id
order by res.total desc , res.hacker_id;




-- Task 5: 
select concat(name,'(', substring(occupation,1,1),')')
from occupations
order by name;

select 
case 
    when count(occupation) > 1 then concat('There are a total of ',count(occupation),' ',lower(occupation),'s.') 
    else concat('There is a total of ',count(occupation),occupation)
end
from occupations
group by occupation
order by count(occupation),occupation;


-- Task 6:
select res.id, res.age, res.mi,res.power
from (select w.id,wp.age, w.coins_needed,min(w.coins_needed) over(partition by wp.age,w.power) as mi, w.power
from wands w
join wands_property wp on w.code = wp.code where wp.is_evil = 0 ) res 
where res.coins_needed = res.mi
order by res.power desc , res.age desc

-- Task 7:
with res as
(select h.hacker_id,h.name ,count(c.challenge_id) as total
from hackers h
left join challenges c on h.hacker_id = c.hacker_id 
group by h.hacker_id,h.name),
max_total as (
select max(res.total) from res
),
frequent as(
    select res.total, count(res.total) as freq from res group by res.total
)

select res.hacker_id, res.name,res.total
from res
where res.total = (select * from max_total) or (select freq from frequent where frequent.total = res.total) < 2
order by res.total desc , res.hacker_id
;


-- Task 8:
select res.hacker_id,h.name, res.total 
from (select r.hacker_id, sum(r.max_score) as total
    from (select s.hacker_id, s.challenge_id,max(s.score) as max_score from submissions s group by s.hacker_id,s.challenge_id) as r
    group by r.hacker_id) res
join hackers h on res.hacker_id = h.hacker_id 
where res.total != 0
order by res.total desc, res.hacker_id

-- Task 9:
SELECT Start_Date, MIN(End_Date)
FROM 
/* Choose start dates that are not end dates of other projects (if a start date is an end date, it is part of the samee project) */
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
/* Choose end dates that are not end dates of other projects */
    (SELECT end_date FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)) b
/* At this point, we should have a list of start dates and end dates that don't necessarily correspond with each other */
/* This makes sure we only choose end dates that fall after the start date, and choosing the MIN means for the particular start_date, we get the closest end date that does not coincide with the start of another task */
where start_date < end_date
GROUP BY start_date
ORDER BY datediff(start_date, MIN(end_date)) DESC, start_date

-- Task 10:
with res as(
    select f.id, p2.salary
    from friends f 
    join Packages p1 on f.id = p1.id
    join Packages p2 on f.friend_id = p2.id
    where p1.salary < p2.salary
)

select  students.name
from res 
join students on res.id = students.id
order by res.salary;


-- Task 11:
with res as (SELECT 
    CASE 
        WHEN f1.x < f1.y THEN f1.x
        ELSE f1.y
    END as column1,
    CASE 
        WHEN f1.x < f1.y THEN f1.y
        ELSE f1.x
    END as column2,
             count(*)  as cnt
from functions f1
join functions f2 on f1.y = f2.x
where f1.x = f2.y and f1.x <= f1.y
            group by  f1.x, f1.y)
select res.column1, res.column2
from res where res.column1 != res.column2 or res.cnt > 1
order by res.column1

-- second solution:
with res as (SELECT 
    CASE 
        WHEN f1.x < f1.y THEN f1.x
        ELSE f1.y
    END as column1,
    CASE 
        WHEN f1.x < f1.y THEN f1.y
        ELSE f1.x
    END as column2
from functions f1
join functions f2 on f1.y = f2.x
where f1.x = f2.y )

select res.column1, res.column2
from res 
group by res.column1, res.column2
having count(*) > 1
order by res.column1




-- Task 12:
WITH view_all AS (
    SELECT challenge_id , SUM(total_views) AS sum_views, SUM(total_unique_views) AS sum_unique_view 
    FROM view_stats
    GROUP BY challenge_id
),
submission_all AS (
    SELECT challenge_id, SUM(total_submissions) AS sum_submissions, SUM(total_accepted_submissions) AS sum_total_acc_sub
    FROM Submission_Stats
    GROUP BY challenge_id
)
select * from (SELECT con.contest_id,con.hacker_id, con.name
, SUM(ISNULL(submission_all.sum_submissions,0)) as c1, SUM(ISNULL(submission_all.sum_total_acc_sub,0)) as c2, SUM(ISNULL(view_all.sum_views,0)) as c3, SUM(ISNULL(view_all.sum_unique_view,0)) as c4
FROM contests con
LEFT JOIN colleges col ON con.contest_id = col.contest_id
LEFT JOIN challenges ch ON ch.college_id = col.college_id 
LEFT JOIN view_all ON ch.challenge_id = view_all.challenge_id
LEFT JOIN submission_all ON ch.challenge_id = submission_all.challenge_id
GROUP BY con.contest_id,con.hacker_id, con.name ) as res 
where (res.c1 + res.c2 + res.c3 +res.c4) != 0
ORDER BY res.contest_id