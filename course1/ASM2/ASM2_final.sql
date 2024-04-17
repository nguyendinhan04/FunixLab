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
  `NGUOI_DANG` INT NOT NULL,
  `LUOT_XEM` INT NOT NULL,
  `NGUOI_DUYET` INT NULL,
  `thoi_gian_dang` DATE NULL,
  `xet_duyet` INT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID_POST`),
  CONSTRAINT `Manager_id_fk` FOREIGN KEY (`NGUOI_DUYET`) REFERENCES `managers` (`ID_MNG`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Reposter_id_fk` FOREIGN KEY (`NGUOI_DANG`) REFERENCES `reposter` (`ID_REPOSTER`) ON DELETE NO ACTION ON UPDATE NO ACTION
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

INSERT INTO MANAGERS(TEN ,NAM_SINH)
VALUES ('HOANG ANH','1998') ,
       ('VIET ANH' ,'1990' ),
	   ('QUYNH NGUYEN' , '1995') ,
	   ('THANH THAO' , '1996' );


INSERT INTO REPOSTER (TEN , NAM_SINH , TO_CHUC)
VALUES ('TRANG NGUYEN' , '1980' , 'BAO THANH NIEN'),
		('TUAN ANH', '1999', 'BAO THE THAO'),
		('TRINH DUONG' , '1995', 'BAO PHAP LUAT'),
		('THU THAO', '1997' , 'DAI TRUYEN HINH VTC'),
		('VIET NGUYEN' , '1990' , 'BAO VOV GIAO THONG ');
		
INSERT INTO USERS (ACCOUNT_NAME, PASSWORDS, FACEBOOK_USER , EMAIL_USER, ID_MNG)
VALUES ('THANG TRINH' , 12341235 , NULL , 'TRINHVANTHANG@GMAIL.COM' , 2 ),
	   ('HOAI AN' , 12356789 , NULL, 'HOAIAN@GMAIL.COM' ,1 ),
	   ('NGUYEN NAM' , 12345676, 'NGUYEN NAM ' , 'NGUYENNAM@GMAIL.COM' , 4 ),
	   ('DUNG NGUYEN', 45678453, 'DUNG CHERRY' , 'DUNGNGUYEN@GMAIL.COM' , 3),
	   ('HOAN ANH TUAN' , 66668888 , 'TUAN ANH HOANG' , 'TUANANH@GMAIL.COM' , 1), 
	   ('NGUYEN HAI ANH' , 11112222, NULL, NULL, 2) ,
	   ('TRINH LONG' , 22221111 , NULL, NULL, 1) ,
	   ('NGUYEN LONG' , 00001111, NULL, 'NGUYENLONG@GMAIL.COM' ,3) ,
	   ('TRUONG THU THAO', 88889999, NULL, NULL, 1),
	   ('LINH ANH' ,11116666 , 'ANH BLACKPINK' , NULL, 4);
	   
INSERT INTO POST (TIEU_DE, NOI_DUNG, IMAGES, LUOT_XEM, XET_DUYET, THOI_GIAN_DANG, NGUOI_DUYET, NGUOI_DANG)
VALUES ('LAO DONG' , 'NGUOI LAO ĐONG ĐANG THAT NGHIEP NHIEU........' , NULL, 20 ,1 , '2018-01-20', 1 , 3),
	   ('TIN AN NINH' , ' VAO HOI 12H ....' , NULL,  10 ,1,  '2018-01-20', 1,4),
	   ('GIAO THONG VÀ BAI TOAN KET XE' , ' HOM NAY ....' , NULL,  16 ,0, '2018-01-21' , 1,1),
	   ('LUAT HON NHAN GIA DINH' , ' THEO NGHI QUYET....' , NULL,  30 ,1,  '2018-01-22' , 4,5),
	   ('GIAO DUC' , ' KI THI THPT QUOC GIA NAM NAY ....' , NULL, 50 , 1, '2018-02-22' , 3, 2) ,
	   ('GIAO THONG ' , ' HOM NAY CÓ MO VU TAI NAN XE HOI ....' , NULL,  10 ,1, '2018-02-24' , 1,1),
	   ('TIN QUOC TE' , ' BÔ NGOAI GIAO VIET NAM SANG THAM CHINH PHU CAMPUCHIA ....' , NULL,  100 , 1, '2018-01-24' , 4,5),
	   ('SUC KHOE NGUOI DAN' , ' HOM NAY , BO CONG AN PHONG CHONG THUC PHAM DOC HAI ĐÃ  ....' , NULL,  10 , 1 ,'2018-03-25' , 2,5),
	   ('PHAP LUAT ' , ' DU AN ALIBABA DA BỊ DNH CHI VI NGHI NGO CHU DOANH NGIEP NAY ....' , NULL,  50 ,1 , '2018-5-26', 1,1),
	   ('AN NINH ' , ' VAO HOI 15H CHIEU NGAY HOM NAY, CONG AN DA BAT QUA TANG....' , NULL,  40,1 , '2018-06-24' , 4,1);
	   
INSERT INTO COMMENT (TIME_COMMENT, NOI_DUNG , NGUOI_COMMENT)
VALUES ('2018-01-22-12-20', ' TOI CUNG NGHI NHU VAY' , 1),
	   ('2018-01-22-12-21', ' KHONG THE CHAP NHAN DUOC' , 4),
	   ('2018-01-23-20-19', 'QUAN DIM CUA TOI VAN LÀ 1 VO 1 CHONG' , 10),
	   ('2018-03-24-20-13', ' RA LA VAY' , 6),
	   ('2018-03-25-12-01', ' GIAO THONG DAO NAY CHAN QUA' , 8),
	   ('2018-03-22-12-21', ' BUON THAT SU' , 3),
	   ('2018-03-24-12-20', ' XA HOI GIO LOAN LAM MOI NGUOI A' , 8),
	   ('2018-03-26-12-20', ' CHAN.......' , 9),
	   ('2018-03-12-12-20', ' MOI NGUOI CO LEN' , 5),
	   ('2018-03-12-12-20', ' CAC CHIEN SI TUYET VOI' , 7),
	   ('2018-03-12-12-20', ' CHUC CAC CHIEN SI LUON KHO MANH DE PHUC VU DAN' , 2),
	   ('2018-04-10-12-20', ' SAP TOI NGAY THUONG BINH LIET SI ROI' , 3),
	   ('2018-04-10-12-20', ' NAM NAY DE THI SE KHO DAY' , 4),
	   ('2018-04-20-12-20', 'KHONG BIET VAN SE RA DE GI DAY' , 8);
INSERT INTO SHARE(TIME_SHARE, NGUOI_SHARE)
VALUES ('2018-01-23-12-23' , 1 ),
	   ('2018-01-22-12-21' , 4 ),
	   ('2018-01-25-12-19' , 5 ),
	   ('2018-01-23-12-23' , 3 ),
	   ('2018-01-23-12-23' , 5 ),
	   ('2018-01-23-12-23' , 6 ),
	   ('2018-01-23-12-23' , 8 ),
	   ('2018-01-23-12-23' , 10 ),
	   ('2018-01-23-11-21' , 8 ),
	   ('2019-01-23-02-13' , 9 ),
	   ('2019-01-23-01-04' , 1 ),
	   ('2019-01-23-01-09', 5 ),
	   ('2018-01-23-12-02' , 2 ),
	   ('2018-01-23-12-21' , 2 ),
	   ('2019-01-23-01-21' , 4 ),
	   ('2019-01-23-01-21' , 3 ),
	   ('2019-01-23-01-21' , 6 ),
	   ('2019-01-23-01-21' , 5);
	   
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

select * from verified_post;

-- tao view de lay ra cac comment cua user
create view get_comment as (select * from comment);

select * from get_comment;

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