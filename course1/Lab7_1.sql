use book_data;
select database();

-- Task 1:
select count(*) as number_book from books;

-- Task 2:
select count(*) as number_book, released_year from books 
group by released_year
order by released_year;

-- Task 3:
select sum(stock_quantity) from books; 

-- Task 4:
select concat(author_fname,author_lname),avg(released_year) as avg_released_year from books
group by author_fname,author_lname
order by avg_released_year;

-- Task 5:
select concat(author_fname,' ',author_lname) as fullname,pages from books
where pages = (select max(pages) from books);
