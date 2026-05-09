
select current_user(); -- will show the root user

show databases; -- will show kon konse databases hai?

use sakila; -- to access your database

show tables; -- show kregi tables in the database

select * from customer; -- select is used to access the table and select * from mtlb saare data ko access kro

-- 1 column access
select customer_id, first_name from customer;

select first_name, customer_id from customer;

select first_name, customer_id, first_name from customer;

select * from payment;
select payment_id, amount from payment; -- 2 column access

select * from customer;
select customer_id, first_name from customer;
select customer_id, first_name, customer_id+10 from customer; -- not seen changes in original table
select * from customer; -- * ka use tbhi krna h jb saare columns access krne ho

select customer_id, customer_id*10-1+6 from customer;

select customer_id, Customer_id, CUSTOMER_ID from customer; -- sql is not case sensitive

SElect customer_ID from CUstoMER;

select * from customer where customer_id=7; -- agar hume row 7 ka saara data chahiye toh aise likhenge

select customer_id, first_name, last_name from customer where customer_id=7;

select customer_id, first_name, last_name from customer where first_name = 'MARIA';

select customer_id, first_name from customer where last_name='WILLIS'; -- zaroori nhi hai ki jispe hum filter lga rhe hai usko select mai likhe

select customer_id, first_name, last_name from customer where first_name='MARION';

show databases;
-- use database_name;
-- show tables;

-- select * from table_name;
-- select col1, col2, col3 from table;

-- select col1, col2, from table where col='condition';

show tables;
select * from customer;
select first_name, last_name from customer where customer_id=2;
select first_name, last_name from customer where customer_id>5;
select first_name, last_name from customer where first_name='Susan';
select * from customer where first_name='Lisa';

-- range of values filter => between
select * from customer where customer_id between 2 and 5;

select * from customer where customer_id between 10 and 10000;

-- no output (we cannot write in descending order)
select * from customer where customer_id between 5 and 2;

-- in => specific values
select * from customer where customer_id in (2,5);

select * from customer where first_name in ('Lisa', 'Patricia');

-- it will give output for lisa not for 10
select * from customer where first_name in ('Lisa', 10);

select * from customer where first_name between 'Lisa' and 'Patricia';

select * from customer where address_id between 1 and 6;

select * from customer where customer_id=2 or customer_id>7;

select * from customer where customer_id>2;

select * from customer where first_name='Marion' or store_id=2;

select * from customer where first_name='Marion' and store_id=2;

select * from customer where 
first_name='Marion' or store_id=2 and store_id=5;

select * from customer where customer_id>=6 or customer_id<2 
and first_name='Patricia';

select * from customer where customer_id=7 
or customer_id=6 and first_name='Maria';

select * from customer where 
(customer_id=7 or customer_id=6) and first_name='Maria';

select * from customer where customer_id not between 2 and 5;

-- like operator => it is used to search for pattern / character
-- % -> zero or more than 1 character
-- B% -> B, BAD, BADSHAH, BAMBRI
select * from customer where first_name like 'BE%';

select * from customer where first_name like '%Y';
select * from customer where first_name like 'B%Y';
select * from customer where first_name like 'J%O';
select * from customer where first_name like 'JO%';
-- Two letter is JO but only one character
select * from customer where first_name like 'JO_';
select * from customer where first_name like '__';
select * from customer where first_name like '_OY';
select * from customer where first_name like 'Y_%';
select * from customer where first_name like 'JO%';
select * from customer where first_name like 'JO_%';
select * from customer where first_name like '____';
select * from customer where first_name like '____%';
select * from customer where first_name like 'A____%';
select * from customer where first_name like 'A_A';
select * from customer where first_name like 'A_A%';
select * from customer where first_name='%AA%';
select * from customer where first_name not like 'A%';

-- function => code logic/task + 
select first_name, last_name, concat (first_name,'_', last_name),
concat ('MRs',' ', first_name) 
from customer;
