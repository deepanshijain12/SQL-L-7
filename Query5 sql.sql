-- Sub Query: Query inside another query. (Query within query). (One query output depends on another query).
-- A sub query is a type of query where a query is present within another query. This sub query is also known as nested sub query.
-- Sub query consists of two parts: 1. Outer query (result depends on inner query) 2. Inner query (executes first)

create database shadidb;

use shadidb;

create table biodata(id int, name varchar(20), age int);

insert into biodata values(1, 'Rahul', 28), (2, 'Anjali', 28), (3, 'Aishwarya', 40), (4, 'Naina', 23);

select * from biodata;


select age from biodata where name='Rahul'; -- age of rahul

select * from biodata where age=28;

select * from biodata where age=(select age from biodata where name='Rahul');

select max(age) from biodata;

select * from biodata where age=40;

select * from biodata where age=(select max(age) from biodata);

select min(age) from biodata;
select * from biodata where age=(select min(age) from biodata);

-- Q. Find out the total characters in the name rahul

select char_length(name) from biodata where name='Rahul';

select name from biodata where 
char_length(name)=(select char_length(name) from biodata where name='Rahul');

-- Single row sub query: It is a type of sub query in which the inner query returns only one.

use shadidb;

select * from biodata;

select * from biodata where name='anjali' or name='aishwarya';

select * from biodata where age in (select age from biodata where name='anjali' or name='aishwarya') and name!='Rahul';
-- multirow sub query mai koi bhi arithmetic operator nhi use hota hai

-- Q1. Find the name for rahul where the age is not equal to the age of anjali and age of aishwarya.

select * from biodata where age not in (select age from biodata where name='anjali' or name='aishwarya') and name!='Rahul';

use sakila;

select * from film;
 -- Q. Find the movie name where the rental rate is same for the movie of african egg.
 
select rental_rate from film where title='African Egg'; 

select title, rental_rate from film
where rental_rate=(select rental_rate from film where title = 'African Egg'); -- dynamic condition

-- Q1. Get the movie id and the movie name where the rental_rate is equal to the min rental rate

select film_id, title from film where rental_rate = (select min(rental_rate) from film);

-- Q2. Get the movie id, movie name and the duration where the duration is greater than the average duration of the movies.

select film_id, title, length from film where length > (select avg(length) from film);


-- Q3. Get the movie id for the movies where the release year of the movie should be equal to the release year of the movie alone trip and 
-- the rating should be same as the movie apollo teen.

select film_id, title from film where release_year = (select release_year from film where title = 'Alone Trip')
and rating = (select rating from film where title = 'Apollo Teen');
-- In multirow sub query (nested query) it will returns more than one row 