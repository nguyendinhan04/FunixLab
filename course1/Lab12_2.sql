use online_shop;

start transaction;
insert into categories set name = 'name A';
select * from categories;

savepoint test1;

update categories set name = 'name B' where id = 1;
select * from categories;

rollback to test1;
select * from categories;
-- THe table return to the previous state which was saved in test1 save point. The record's name whose id = 1 was returned to 'Books'