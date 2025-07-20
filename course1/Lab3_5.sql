show databases;
create database shirts_db;
use shirts_db;

create table shirts (
    shirt_id int primary key auto_increment not null,
    article varchar(100),
    color varchar(100),
    shirt_size varchar(100),
    last_worn int
);

insert into shirts(article,color,shirt_size,last_worn) values 
('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);

select * from shirts;

show tables;

insert into shirts(article,shirt_size,last_worn) values ('polo shirt','M',50);

select article, color from shirts; 

select article,color,shirt_size,last_worn
from shirts where shirt_size = 'M';

update shirts set shirt_size = 'L' where article = 'polo shirt';

delete from shirts where last_worn = 200;