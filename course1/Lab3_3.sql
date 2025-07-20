select database();

create table cats(
    cat_id int primary key auto_increment,
    name varchar(100),
    breed varchar(100),
    age int
);

insert into cats(name,breed,age) values 
('Ringo', 'Tabby', 4),
('Cindy', 'Maine Coon', 10),
('Dumbledore', 'Maine Coon', 11),
('Egg', 'Persian', 4),
('Misty', 'Persian', 4),
('George Michael', 'Ragdoll', 9),
('Jackson', 'Sphynx', 7);

select * from cats;
select cat_id from cats;
select name, breed from cats;
select name, age from cats where age = 4;
select cat_id as id, name from cats;
select name as cat_name,breed as kitty_breed from cats;
