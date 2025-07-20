CREATE TABLE `managers` ( 
  `ID_MNG` INT AUTO_INCREMENT NOT NULL,
  `TEN` VARCHAR(45) NOT NULL,
  `NAM_SINH` YEAR NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_MNG`)
);

CREATE TABLE `reposter` ( 
  `ID_REPOSTER` INT AUTO_INCREMENT NOT NULL,
  `TEN` VARCHAR(45) NOT NULL,
  `TO_CHUC` VARCHAR(45) NULL,
  `nam_sinh` YEAR NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_REPOSTER`)
);

CREATE TABLE `users` ( 
  `ID_USER` INT AUTO_INCREMENT NOT NULL,
  `ACCOUNT_NAME` VARCHAR(45) NOT NULL,
  `PASSWORDs` VARCHAR(45) NULL,
  `FACEBOOK_USER` VARCHAR(100) NULL,
  `EMAIL_USER` VARCHAR(100) NULL,
  `ID_MNG` INT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_USER`),
  CONSTRAINT `ID_MNG_fk` FOREIGN KEY (`ID_MNG`) REFERENCES `managers` (`ID_MNG`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE `post` ( 
  `ID_POST` INT AUTO_INCREMENT NOT NULL,
  `TIEU_DE` TEXT NOT NULL,
  `NOI_DUNG` TEXT NOT NULL,
  `IMAGEs` VARCHAR(45) NULL,
  `TAC_GIA` INT NOT NULL,
  `LUOT_XEM` INT NOT NULL,
  `NGUOI_DUYET` INT NULL,
  `thoi_gian_dang` DATE NULL,
  `xet_duyet` INT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_POST`),
  CONSTRAINT `Manager_id_fk` FOREIGN KEY (`NGUOI_DUYET`) REFERENCES `managers` (`ID_MNG`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Reposter_id_fk` FOREIGN KEY (`TAC_GIA`) REFERENCES `reposter` (`ID_REPOSTER`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


CREATE TABLE `comment` ( 
  `ID_COMMENT` INT AUTO_INCREMENT NOT NULL,
  `NGUOI_COMMENT` INT NOT NULL,
  `time_comment` DATE NULL,
  `noi_dung` TEXT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_COMMENT`),
  CONSTRAINT `User_commnet_id_fk` FOREIGN KEY (`NGUOI_COMMENT`) REFERENCES `users` (`ID_USER`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `share` ( 
  `ID_SHARE` INT AUTO_INCREMENT NOT NULL,
  `NGUOI_SHARE` INT NOT NULL,
  `time_share` DATE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_SHARE`),
  CONSTRAINT `User_id_fk` FOREIGN KEY (`NGUOI_SHARE`) REFERENCES `users` (`ID_USER`) ON DELETE NO ACTION ON UPDATE NO ACTION
);





-- Truy van tat ca bang POST va  MANAGERS
select * from post;
SELECT * FROM MANAGERS;

-- truy van nhung nhung bai viet co LUOT_XEM lon hon 20
select * from post
where LUOT_XEM > 20;

-- trong bang post viet truy van nhwng bai viet da duoc xet duyet va xap xep theo thu tu bang chu cai cua cot tieu de 
select * from post
where xet_duyet = 1
order by tieu_de asc;

-- viet truy van de lay ten cac account name cua user comment vao post
select c.nguoi_comment, u.account_name,c.noi_dung from comment c
join users u on c.nguoi_comment = u.id_user;

-- viet truy van tim bai viet co noi dung bat dau bang 'n'
select * from post
where lower(substring(noi_dung,1,1)) = 'n';

-- tao view lay bai viet da duoc duyet boi quan ly
create view verified_post as(
    select * from post 
    where xet_duyet = 1
);

-- tao view de lay ra cac comment cua user
create view get_comment as (select * from comment);

-- tao thu tuc lay nhwng bai viet duoc duyet
delimiter $$
create procedure get_verified_post()
begin
    select * from post 
    where xet_duyet = 1;
end $$
delimiter ; 

call get_verified_post();

-- tao thu tuc de lay nhung bai viet chua duoc duyet truoc ngay 01-02-2018.
delimiter $$
create procedure get_unverified_post_before()
begin
    select * from post 
    where xet_Duyet = 0 and thoi_gian_dang < '2018-02-01';
end $$
delimiter ;

call get_unverified_post_before();

SET GLOBAL log_bin_trust_function_creators = 1;

-- tao function de lay so luong thang lon nhat ma cac bai viet da dang ke tu thoi diem duoc dang den thoi diem 01-01-2019 trong bang post
delimiter $$
create function max_month()
returns int
begin
    declare res int;
    select timestampdiff(month,min(thoi_gian_dang),'2019-01-01') from post into res;
    return res;
end $$
delimiter ;

select max_month();


create table comment_on_day(
    id_user int,
    day date,
    number_of_comment int,
    primary key (id_user,day)
);

-- tao trigger luu lai moi user da thuc hien bao nhieu comment trong mot ngay 
delimiter $$
create trigger handle_nums_of_comment_on_day
after insert on comment for each row
begin
    if(exists(select * from comment_on_day where id_user = new.nguoi_comment and day = new.time_comment))
    then 
        update comment_on_day set number_of_comment = number_of_comment + 1 where id_user = new.nguoi_comment and day = new.time_comment;
    else
        insert into comment_on_day(id_user,day,number_of_comment) values (new.nguoi_comment, new.time_comment,1);
    end if;
end $$
delimiter ;

-- TAO INDEX TREN COT TIEU_DE TRONG BANG POST DE GIUP VIEC TIM KIEM THEO THEO TIEU DE NHANH HON
CREATE INDEX post_heading_idx ON post(TIEU_DE(100));

-- Tao index tren cot thoi gian dang de tang toc do tim kiem post theo thoi gian dang
create index post_day_inx on post(thoi_gian_dang);


