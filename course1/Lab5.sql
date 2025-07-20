select * from books
where released_year < 1980;

select * from books
where author_lname = 'Eggers' or author_lname = 'Chabon';

select * from books
where author_lname = 'Lahiri' and released_year < 2000;

select * from books 
where pages >= 100 and pages <= 200;

select title,  author_lname, 
case 
    when title like '%stories%' then 'Short Stories'
    when title like '%Just Kids%' or title = 'A Heartbreaking Work of Staggering Genius' then 'Memoir'
    else 'Novel'
end as type
from books;