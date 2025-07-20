-- bai 1
select * from city 
where population > 100000 and countrycode = 'USA';


-- Bai 2 
select name from city where countrycode = 'USA' and population > 120000;

-- Bai 3
select * from city ;

-- Bai 4
select * from city 
where countrycode = 'JPN';  

-- bai 5
select name from city 
where countrycode = 'JPN';  

-- Bai 6
select city, state from station; 
