select concat (author_fname,' ',author_lname) as full_name
from books;
select concat_ws('-',author_fname, author_lname) as full_name
from books ;

select substring('data analysis',6,8);

select replace('data analysis','analysis','science');

select replace(title,' ','->') from books;


select reverse('data analysis');

select char_length('database');

select char_length(title) from books;

select upper('database');

select upper(title) from books;

select lower('DATABASE');

select lower(title) from books;