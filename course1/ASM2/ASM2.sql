select * from post;

SELECT * FROM MANAGERS;

-- truy vấn những bài viết có LUOT_XEM lớn hơn 20.
select * from post
where LUOT_XEM > 20;

-- viết truy vấn những bài viết đã được xét duyệt và sắp xếp kết quả theo thứ tự bảng chữ cái của cột tiêu đề.
select * from post
where xet_duyet = 1
order by tieu_de asc;

-- Viết truy vấn để lấy tên các acount_name của user comment vào POST
select c.nguoi_comment, u.account_name,c.noi_dung from comment c
join users u on c.nguoi_comment = u.id_user;

-- Viết truy vấn để tìm nội dung bài viết bắt đầu bằng chữ ‘n’
select * from post
where lower(substring(noi_dung,1,1)) = 'n';

-- Tạo VIEW để lấy ra những bài viết đã được duyệt bởi những người quản lý.
create view verified_post as(
    select * from post 
    where xet_duyet = 1
);

-- Tạo VIEW để lấy ra các comment của user.
create view get_comment as (select * from comment);

-- Tạo thủ tục để lấy được những bài viết đã được duyệt
delimiter $$
create procedure get_verified_post()
begin
    select * from post 
    where xet_duyet = 1;
end $$
delimiter ; 

call get_verified_post();

-- Tạo thủ tục để lấy những bài viết chưa được duyệt trước ngày 01-02-2018.
delimiter $$
create procedure get_unverified_post_before()
begin
    select * from post 
    where xet_Duyet = 0 and thoi_gian_dang < '2018-02-01';
end $$
delimiter ;

call get_unverified_post_before();

delimiter $$
create function max_month()
returns int
as
begin
    select timestampdiff(month,min(thoi_gian_dang,'2019-01-01') )from post
    returning *;
end$$
delimiter ;

SET GLOBAL log_bin_trust_function_creators = 1;

-- Tạo function để lấy được số tháng lớn nhất mà các bài viết đã đăng kể từ thời điểm được đăng đến thời điểm 01-01-2019 trong bảng POST.
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

-- Bạn hãy tạo một trigger để lưu lại mỗi user đã thực hiện comment bao nhiêu lần theo từng ngày.
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

-- tAOJ INDEX TREN COT TIEU_DE TRONG BANG POST DE GIUP VIEC TIM KIEM THEO THEO TIEU DE NHANH HON
CREATE INDEX post_heading_idx ON post(TIEU_DE(100));

-- Tao index tren cot thoi gian dang de tang toc do tim kiem post theo thoi gian dang
create index post_day_inx on post(thoi_gian_dang);


