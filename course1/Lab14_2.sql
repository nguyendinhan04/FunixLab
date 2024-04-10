use test;

create table sales(id int primary key auto_increment, product varchar(45) not null, sold numeric(8.2) not null);
create table sales_totals(id int primary key auto_increment, total numeric(11.2) not null, day date unique);

