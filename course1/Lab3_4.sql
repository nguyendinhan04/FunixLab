select database();
show tables;
select * from cats;

update cats set name = 'Jack' where name = 'Jackson';
update cats set name = 'Bitish Shorthair' where name = 'Ringo';
update cats set age = 12 where breed = 'Maine Coon';
delete from cats where age = 4;
delete from cats where cats.age = cats.cat_id;
delete from cats;
