create database online_shop;
use online_shop;
create table book(id int primary key auto_increment, name varchar(50) not null, notes varchar(100));

create view bookview as (select * from book);
insert into bookview (id, name) values (2, "War and Peace");
select * from book;
-- The reason why updating in view will lead to update in real table is that data in view cannot exist independently because view basically is the procedure to store select query. Therefore the changes made in view will be applied to real table too.
delete from bookview;