use test;

create table sales(id int primary key auto_increment, product varchar(45) not null, sold numeric(8.2) not null);
create table sales_totals(id int primary key auto_increment, total numeric(11.2) not null, day date unique);


delimiter $$
create trigger handle_total_on_day
after insert 
on sales for each row
begin
	declare total_count int;
    declare cd date;
    set cd = curdate();
    select count(*) into total_count from sales_totals where day = cd;
    
	if total_count = 0 
		then insert into sales_totals(total,day) values (new.sold,cd);
	else
    update sales_totals set total = total + new.sold where day = cd;
    end if;
end $$
delimiter ;





