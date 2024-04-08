use test;
-- Task 1:
show tables;

create table mytb(
    id int auto_increment primary key,
    noun varchar(20),
    adjective varchar(20)
);

insert into mytb(noun,adjective) values 
('Swing', 'painfull') ,
('Fifth', 'fat'),
('Waves', 'absorded'), 
('Back', 'innate'),
('Hope', 'chubby') ,
('Thing', 'modern'),
('Virus', 'combative');

delete from mytb;
-- Taks 2:
delimiter $$ 
create procedure task1()
begin
    declare nouns varchar(255) default '';
    declare adjectives varchar(255) default '';
    declare isFinish boolean default false;
    declare tmp1 varchar(255);
    declare tmp2 varchar(255);
    
    declare cur cursor for select noun, adjective from mytb;
    declare continue handler for not found set isFinish := true;
    
    open cur;
    my_loop : LOOP
        fetch cur into tmp1,tmp2;
        set nouns := concat(nouns,',',tmp1);
        set adjectives := concat(adjectives,',',tmp2);
        if isFinish then leave my_loop; end if; 
    end LOOP my_loop;
    
    
    select case 
        when char_length(nouns) > 1 then substring(nouns,2)
        else nouns
    end, case 
        when char_length(adjectives) > 1 then substring(adjectives,2)
        else adjectives
    end;
    close cur;
end$$
delimiter ;
call task1();

-- Task 3:
delimiter $$
create procedure task3()
begin
    declare n varchar(255);
    declare a varchar(255);
    create table if not exists stars(
        res text
    );
    select noun into n from mytb order by rand() limit 1;
    select adjective into a from mytb order by rand() limit 1;
    
    select concat(n,' ',a);
end$$
delimiter ;

drop procedure task3;
call task3();

-- Task 4: 
delimiter $$
create procedure task4()
begin
    declare height float default 0;
    declare weight float default 0;
    
    set height := rand()*(190-100) + 100;
    set weight := rand()*(height/2 - height/3) + height/3;
    
    select round(height,2),round(weight,2);
    
end$$
delimiter ;

drop procedure task4;

call task4();