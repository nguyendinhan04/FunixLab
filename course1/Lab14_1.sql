use test;

create table if not exists animals (
    id int auto_increment primary key,
    animal_name varchar(100)
);

delimiter $$
create trigger handle_animal_name
before insert on animals for each row 
begin
    if new.animal_name like '%cat%' then set new.animal_name := replace(new.animal_name,'cat','xxx');
    end if;
end $$   
delimiter ;  


drop trigger handle_animal_name;


select * from animals;
insert into animals (animal_name) values ('lioncatmeow');