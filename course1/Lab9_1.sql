-- Task 1:
create database book_shop;
use book_shop;
select database();
create table students(
    id int primary key auto_increment,
    first_name varchar(150) not null
);
create table if not exists papers(
    student_id int,
    title varchar(150),
    grade int,
    constraint fk_student foreign key(student_id) references students(id)
);

-- Task 2:
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- Task 3:
select * from students;
select * from papers;

-- Task 4:
select s.first_name, p.title, p.grade from students s
left join papers p on s.id = p.student_id; 

select s.first_name, 
ifnull(p.title,'MISSING'),
ifnull(p.grade,0)
from students s
left join papers p on s.id = p.student_id; 


select s.first_name, avg(ifnull(p.grade,0)) from students s
left join papers p on s.id = p.student_id
group by s.id
order by s.first_name;

-- Task 4:
select s.first_name, avg(ifnull(p.grade,0)),
case    
    when avg(ifnull(p.grade,0)) > 70 then 'PASSING'
    else 'FAILING'
end as passing_status 
from students s
left join papers p on s.id = p.student_id
group by s.id
order by s.first_name;
