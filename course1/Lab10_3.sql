use online_Shop;

show tables;
select * from products;
select * from sales;

create view customer_sale1 as select * from sales s join customers c on c.id = s.customer_id;
-- Cannot  create view bacause there is duplicated colmun which are id from customers and id from sales

create  algorithm=merge view customer_sale2 as select c.id  from sales s join customers c on c.id = s.customer_id;
-- The query is executed with no error

create  algorithm=temptable view customer_sale3 as select c.id  from sales s join customers c on c.id = s.customer_id;
-- The query is executed with no error

create  algorithm=merge view customer_sale4 as select count(*), c.id  from sales s join customers c on c.id = s.customer_id;
-- Mysql will warn us that we cannot use merge algorithm and automatically switch to undefined algorithm


    