create table if not exists reviewers(
    id int primary key auto_increment,
    first_name varchar(100),
    last_name varchar(100)
);

create table if not exists series(
    id int auto_increment primary key,
    title varchar(100) not null,
    released_year year(4),
    genre varchar(100)
);

create table reviews(
    id int auto_increment primary key,
    rating float,
    series_id int,
    reviewer_id int,
    constraint fk_series foreign key (series_id) references series(id),
    constraint fk_reviewer_id foreign key (reviewer_id) references reviewers(id)      
);


-- INSERT INTO series (title, released_year, genre) VALUES
    -- ('Archer', 2009, 'Animation'),
    -- ('Arrested Development', 2003, 'Comedy'),
    -- ("Bob's Burgers", 2011, 'Animation'),
--     ('Bojack Horseman', 2014, 'Animation'),
--     ("Breaking Bad", 2008, 'Drama'),
--     ('Curb Your Enthusiasm', 2000, 'Comedy'),
--     ("Fargo", 2014, 'Drama'),
--     ('Freaks and Geeks', 1999, 'Comedy'),
--     ('General Hospital', 1963, 'Drama'),
--     ('Halt and Catch Fire', 2014, 'Drama'),
--     ('Malcolm In The Middle', 2000, 'Comedy'),
--     ('Pushing Daisies', 2007, 'Comedy'),
--     ('Seinfeld', 1989, 'Comedy'),
--     ('Stranger Things', 2016, 'Drama');
-- ;
-- INSERT INTO reviewers (first_name, last_name) VALUES
--     ('Thomas', 'Stoneman'),
--     ('Wyatt', 'Skaggs'),
--     ('Kimbra', 'Masters'),
--     ('Domingo', 'Cortes'),
--     ('Colt', 'Steele'),
--     ('Pinkie', 'Petit'),
--     ('Marlon', 'Crafford');

-- INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
--     (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
--     (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
--     (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
--     (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
--     (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
--     (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
--     (7,2,9.1),(7,5,9.7),
--     (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
--     (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
--     (10,5,9.9),
--     (13,3,8.0),(13,4,7.2),
--     (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
-- Task 3:
select * from reviewers;
select * from series;
select * from reviews;

select s.title, round(r.rating,2)
from reviews r 
left join series s on r.series_id = s.id;

-- Task 5:
select s.title, round(avg(r.rating),2) avg_rating
from reviews r 
left join series s on r.series_id = s.id
group by s.id
order by avg_rating;

-- Task 6:
select s.genre, round(avg(r.rating),2) avg_rating
from reviews r 
left join series s on r.series_id = s.id
group by s.genre
order by s.genre;

-- Task 7:
select rer.first_name, rer.last_name,r.rating 
from reviewers rer
right join reviews r on rer.id = r.reviewer_id
order by rer.first_name;

-- Task 8:
select s.title
from series s
left join reviews r on s.id = r.series_id
where r.rating is null ;

-- Second solution
select s.title 
from series s
where s.id not in(select series_id from reviews);

-- Task 9:
select rer.id,rer.first_name, rer.last_name, count(r.rating), min(ifnull(r.rating,0)), max(ifnull(r.rating,0)), avg(ifnull(r.rating,0)), 
case 
    when count(r.rating) > 0 then 'ACTIVE'
    else 'INACTIVE'
end AS "STATUS" 
from reviewers rer 
left join reviews r on rer.id = r.reviewer_id
group by rer.id;

-- second solution
select r.first_name, r.last_name, ifnull(res.c,0) as "COUNT",ifnull(res.mi,0) as "MIN",ifnull(res.ma,0) as "MAX",round(ifnull(res.a,0),2)as "AVG", if(ifnull(res.c,0) = 0,'INACTIVE',"ACTIVE") as "STATUS"
from reviewers r
left join (
    select reviewer_id,count(rating) as c, min(rating) as mi, max(rating) as ma, avg(rating) as a
    from reviews
    group by reviewer_id
) res on r.id = res.reviewer_id;

-- Task 10:
select s.title, r.rating, concat(rer.first_name, " ", rer.last_name) as reviewer
from reviews r
join reviewers rer on r.reviewer_id = rer.id
join series s on r.series_id = s.id
order by s.title, reviewer asc;






