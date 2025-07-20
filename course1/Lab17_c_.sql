use test;

create table department(
    id int primary key,
    name varchar(100)
);

create table employee(
id int primary key,
name varchar(100),
dep_id int,
foreign key (dep_id) references department(id)
); 


insert into department(id, name) values(1, 'Phong ban A');
insert into department(id, name) values(2, 'Phong ban B');
insert into department(id, name) values(3, 'Phong ban C');

insert into employee(id, name, dep_id) values(1, 'Nguyen Van A', 1);
insert into employee(id, name, dep_id) values(2, 'Nguyen Van B', 1);
insert into employee(id, name, dep_id) values(3, 'Nguyen Van C', 2);


select * from department;

select * from employee;

delete from department where id = 1;
-- cannot delete record with id = 1 beacause it violate referance intergity contraint. 

delete from department where id = 2;
-- cannot delete record with id = 1 beacause it violate referance intergity contraint. 

update department set name = 'Phong ban D' where id = 1;
-- The query was successfully executed and did not violate any contraint

delete from employee where id = 3;
delete from department where id = 2;
