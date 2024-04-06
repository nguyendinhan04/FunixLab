create database lab;

use lab;
create table student(
id int primary key auto_increment,
name varchar(100)
);
insert into student(name) values('name A'),('name B');

use lab;
lock tables student write;
select * from student;
insert into student(name) values('name C');
-- The query run sucessfully because user use write lock which alow to insert and select table

unlock table;
select * from student;
-- the user2's query is run after user1 unlock the table. 
lock tables student read;
select * from student;
-- The query is executed sucecessfully

insert into student(name) values('name E'); 
-- THe query cannot be query becausr read lock only allow read data and cannot write. 
 
unlock table;

select * from student;
-- THe query was executed successfully and the waiting query of user2 was executed because user1 unlocked the the table and allow other to write. 


lock table student as myalias write;
unlock tables;