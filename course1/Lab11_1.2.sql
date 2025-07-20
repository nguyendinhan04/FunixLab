use lab;
select * from student;
--  THe query is put in queue waiting for other's lock

insert into student(name) values('name D');
--  THe query is put in queue waiting for other's lock because write lock only alow who have key to read and write.

select * from student;
-- the query is executed because read lock allow other to read data without key

insert into student(name) values('name F'); 
-- THe query is put into queue waiting for other's lock 

insert into student(name) values('name G'); 
select * from student as myalias;
select * from student;
