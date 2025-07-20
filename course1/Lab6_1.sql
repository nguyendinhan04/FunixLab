-- Task 1:
select title,pages from books
order by pages desc 
limit 1;

-- Task 2:
select title,released_year from books
order by released_year desc
limit 3;

-- Task 3:
select title, author_lname from books
where author_lname like '% %';

-- Task 4:
select title, released_year, stock_quantity from books
order by stock_quantity asc
limit 3;

-- Task 5:
select title, author_lname from books 
order by author_lname,title;