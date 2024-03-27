select
  database();

create table unique_cats(
  cat_id int not null primary key,
  name varchar(100),
  age int
);


insert into unique_cats values
(1, 'Fred', 23),
(2, 'Louise', 3),
(3, 'James', 3);
-- We have to insert mannually into cat_id value

select * from unique_cats;


create table unique_cat2(
    cat_id int not null AUTO_INCREMENT primary key,
    name varchar(100),
    age int
);

insert into unique_cat2(name,age) values 
('Skippy', 4),
('Jiff', 3),
('Jiff', 3),
('Jiff', 3),
('Skippy', 4);
-- we do not have to insert into cat_id values


select *from unique_cat2;
-- The cat_id values are increases for each record.


create table employee (
    id int primary key auto_increment,
    first_name varchar(225) not null,
    last_name varchar(225) not null,
    middle_name varchar(225),
    age int not null,
    current_status varchar(225) not null default "Employed"
);

insert into employee(first_name, last_name, age) values
('Dora', 'Smith', 58);

select * from employee;
-- When we not insert into middle name, it will be null. When we not insert into current_status,it will be "employee" 