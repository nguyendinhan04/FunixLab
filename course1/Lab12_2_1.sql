use online_shop;

set transaction isolation level read uncommitted;
start transaction;
select * from customers;
-- At this momnet, when select * from user1's transaction, the table have been changed where name of row having id = 2 was set to 'name C'
commit; 

set transaction isolation level read committed;
start transaction;
insert into customers(name, email) values('name D', 'A@gmail.com');
select * from customers;
-- The insert query was executed successfully 
commit;

set transaction isolation level repeatable read;
start transaction;
update customers set name='name E' where id = 1;
select * from customers;
--  The update query was executed successfully
commit; 
select * from customers;
--  Change in step 2 was applied beacause, when table 1 commited -> unlock -> other queued query were executed.


set transaction isolation level serializable;
start transaction;
select * from customers;
commit;
select * from customers;

set transaction isolation level serializable;
start transaction;
select * from customers;
commit;
select * from customers;
-- Change is applied  

