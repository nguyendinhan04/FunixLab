-- Task 1:
select sum(ci.population)
from city ci
left join country co on ci.countrycode = co.code
where co.continent = 'Asia'

-- Task 2:
select ci.name
from city ci
left join country co on ci.countrycode = co.code
where co.continent = 'Africa'

-- Task 3:
select ci.name
from city ci
left join country co on ci.countrycode = co.code
where co.continent = 'Africa'

-- Task 4:
select res.hacker_id, h.name
from (select s.hacker_id,count(*) as total
from submissions s 
left join challenges c on c.challenge_id = s.challenge_id
left join difficulty d on c.difficulty_level = d.difficulty_level
group by s.hacker_id
having count(*) >= 1 and sum(s.score) = sum(d.score)) res 
join hackers h on res.hacker_id = h.hacker_id
order by res.total desc , res.hacker_id 


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

-- Task 7:
select h.hacker_id, h.name,count(c.challenge_id)
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