use online_shop;
-- start transaction; 
update customers set name = 'name C' where id = 2;

select * from customers;
-- Change in user1'transaction hasn't been applied beacause it is uncommitted

select * from customers;
-- when Changes in user1'transaction was committed -> other transaction can view them.



update customers set name='name F' where id = 1;
select * from customers;
-- The query is put into queue because when in repeatable read isolation level, use1's update query locked table customers -> other transaction cannot update

insert into customers(name, email) values('name A', 'A@gmail.com');
select * from customers;


update customers set name = 'name B' where id = 1;
-- Cannot executed -> lock table bacause user1's transaction is using 