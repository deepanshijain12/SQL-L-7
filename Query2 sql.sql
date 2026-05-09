use sakila;
select * from payment;
select * from payment where customer_id=1;
select count(*), count(payment_id) from payment where customer_id=3;

select customer_id from payment group by customer_id;

select customer_id, count(payment_id) from payment group by customer_id;

select * from payment where customer_id >= 3;
select customer_id from payment where customer_id >= 3 group by customer_id;

CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(50),
    product VARCHAR(50),
    sales_person VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (region, product, sales_person, amount, sale_date) VALUES
('North', 'Laptop', 'Amit', 55000, '2025-01-05'),
('North', 'Mobile', 'Amit', 20000, '2025-01-06'),
('South', 'Laptop', 'Ravi', 60000, '2025-01-07'),
('East', 'Tablet', 'Suman', 15000, '2025-01-08'),
('West', 'Laptop', 'Neha', 58000, '2025-01-09'),

('North', 'Tablet', 'Amit', 12000, '2025-01-10'),
('South', 'Mobile', 'Ravi', 22000, '2025-01-11'),
('East', 'Laptop', 'Suman', 50000, '2025-01-12'),
('West', 'Tablet', 'Neha', 14000, '2025-01-13'),
('North', 'Laptop', 'Amit', 57000, '2025-01-14'),

('South', 'Tablet', 'Ravi', 13000, '2025-01-15'),
('East', 'Mobile', 'Suman', 21000, '2025-01-16'),
('West', 'Laptop', 'Neha', 61000, '2025-01-17'),
('North', 'Mobile', 'Amit', 19000, '2025-01-18'),
('South', 'Laptop', 'Ravi', 62000, '2025-01-19'),

('East', 'Tablet', 'Suman', 16000, '2025-01-20'),
('West', 'Mobile', 'Neha', 23000, '2025-01-21'),
('North', 'Tablet', 'Amit', 11000, '2025-01-22'),
('South', 'Mobile', 'Ravi', 25000, '2025-01-23'),
('East', 'Laptop', 'Suman', 52000, '2025-01-24'),

('West', 'Tablet', 'Neha', 13500, '2025-01-25'),
('North', 'Laptop', 'Amit', 59000, '2025-01-26'),
('South', 'Tablet', 'Ravi', 12500, '2025-01-27'),
('East', 'Mobile', 'Suman', 20500, '2025-01-28'),
('West', 'Laptop', 'Neha', 60000, '2025-01-29'),

('North', 'Mobile', 'Amit', 21000, '2025-01-30'),
('South', 'Laptop', 'Ravi', 63000, '2025-01-31'),
('East', 'Tablet', 'Suman', 17000, '2025-02-01'),
('West', 'Mobile', 'Neha', 24000, '2025-02-02'),
('North', 'Tablet', 'Amit', 12500, '2025-02-03'),

('South', 'Mobile', 'Ravi', 26000, '2025-02-04'),
('East', 'Laptop', 'Suman', 54000, '2025-02-05'),
('West', 'Tablet', 'Neha', 15000, '2025-02-06'),
('North', 'Laptop', 'Amit', 61000, '2025-02-07'),
('South', 'Tablet', 'Ravi', 14000, '2025-02-08');

select * from sales;

select sum(amount) from sales;

-- total sales
select sum(amount) as total_sales from sales;


-- mobile total sales
select sum(amount) as mobile_total_sales from sales where product='Mobile';

-- Q. find the total sales and average sales for north region but for the product laptop and mobile

select * from sales where region='North' and (product='Laptop' or product='Mobile');
select sum(amount), avg(amount) from sales where region='North' and (product='Laptop' or product='Mobile');

-- Q. You need to find out the maximum amount and the minimum amount for february month

select max(amount), min(amount) from sales where month(sale_date) = 2;

-- Q1. Find out the total sales we have done for each region
-- Q2. Find out the avg sales done by each person
-- Q3. Find the total amount and the total transaction done for each product but the amit should not be the sales person
-- Q4. Find the number of sales done by each person for the amount greater than 10000
-- Q5. Find the number of transactions done from day 1 to day 7 for any month
-- Q6. Find the total amount, avg amount, max amount for each product of each region
-- Q7. Find the total transaction amount for each product where the product should be sold more than 13 times

select * from sales;
-- Q1.
select sum(amount) from sales group by region;
-- Q2.
select avg(amount) from sales group by sales_person;
-- Q3. 
select sum(amount), count(amount) from sales where sales_person != 'Amit' group by product ;
-- Q4.
select count(amount) from sales where amount > 10000;
-- Q5.
select count(*) as total_transaction from sales group by (sale_date) between 1 and 7;
-- Q6. 
select product, region, sum(amount), avg(amount), max(amount) from sales group by product, region;
-- Q7. 
select product, count(*) as total_times from sales group by product having count(*) > 13;

use sakila;
select * from sales;
select product, sum(amount) from sales where product != 'Tablet' group by product;

-- where clause is used to filter the data on the table 
-- where clause cannot be applied on aggregate function

-- having clause is applied with the group by 
-- having clause is used to filter the aggregate result

select product, sum(amount) from sales group by product having sum(amount)>250000;
-- Q. I need to find how many sales are done by each person?
select count(amount) from sales group by sales_person;
select sales_person, count(*) from sales group by sales_person having count(*)>8;
select region, sum(amount), count(*) from sales group by region having count(*)>9;

-- Q. Find the total transaction done by each person in the decreasing order
select sales_person, count(amount) from sales group by sales_person order by sales_person desc;

select sales_person, product, sum(amount)
from sales group by sales_person, product
order by sales_person; -- 232000.00 + 60000.00 + 35500.00

select sales_person, count(sales_person)
from sales group by sales_person;

select sales_person, product, count(amount)
from sales group by sales_person, product;

select year(payment_date), month(payment_date), sum(amount) 
from payment group by year (payment_date), month(payment_date);

CREATE TABLE employees (
    emp_id       INT            PRIMARY KEY,
    first_name   VARCHAR(50)    NOT NULL,
    last_name    VARCHAR(50)    NOT NULL,
    email        VARCHAR(100)   NOT NULL,
    department   VARCHAR(50),
    job_title    VARCHAR(60),
    salary       DECIMAL(10,2),
    hire_date    DATE,
    birth_date   DATE,
    phone        VARCHAR(20),
    city         VARCHAR(50),
    country      VARCHAR(50),
    is_active    CHAR(1)
);


INSERT INTO employees VALUES
(1,  'Alice',  'Smith',    'alice.smith@gmail.com', 'IT',        'Software Engineer',    85000.00,'2019-03-15','1990-06-20','555-1001','New York',     'USA','Y'),
(2,  'Bob',    'Johnson',  'bob.j@yahoo.com',       'HR',        'HR Manager',           72000.00,'2020-07-01','1985-11-05','555-1002','Chicago',      'USA','Y'),
(3,  'Carol',  'Williams', 'carol.w@gmail.com',     'Finance',   'Accountant',           65000.00,'2018-01-10','1992-03-14','555-1003','Houston',      'USA','Y'),
(4,  'David',  'Brown',    'david.b@outlook.com',   'IT',        'DevOps Engineer',      90000.00,'2021-05-20','1988-09-25','555-1004','Los Angeles',  'USA','Y'),
(5,  'Emma',   'Jones',    'emma.j@gmail.com',      'Marketing', 'Marketing Lead',       78000.00,'2017-11-30','1991-07-08','555-1005','Phoenix',      'USA','Y'),
(6,  'Frank',  'Garcia',   'frank.g@yahoo.com',     'Sales',     'Sales Representative', 55000.00,'2022-02-14','1994-02-28','555-1006','Philadelphia', 'USA','N'),
(7,  'Grace',  'Martinez', 'grace.m@gmail.com',     'IT',        'QA Engineer',          68000.00,'2020-09-01','1993-12-01','555-1007','San Antonio',  'USA','Y'),
(8,  'Henry',  'Davis',    'henry.d@outlook.com',   'Finance',   'Financial Analyst',    76000.00,'2019-06-15','1989-04-17','555-1008','San Diego',    'USA','Y'),
(9,  'Isla',   'Wilson',   'isla.w@gmail.com',      'HR',        'Recruiter',            60000.00,'2021-10-05','1995-08-22','555-1009','Dallas',       'USA','Y'),
(10, 'Jack',   'Moore',    'jack.m@yahoo.com',      'Marketing', 'SEO Specialist',       58000.00,'2023-01-09','1997-01-15','555-1010','San Jose',     'USA','Y'),
(11, 'Karen',  'Taylor',   'karen.t@gmail.com',     'Sales',     'Sales Manager',        82000.00,'2016-04-20','1984-05-30','555-1011','Austin',       'USA','Y'),
(12, 'Liam',   'Anderson', 'liam.a@outlook.com',    'IT',        'Data Scientist',       95000.00,'2020-11-15','1987-10-10','555-1012','Jacksonville', 'USA','Y'),
(13, 'Mia',    'Thomas',   'mia.t@gmail.com',       'Finance',   'Tax Consultant',       71000.00,'2022-06-01','1993-06-15','555-1013','Columbus',     'USA','Y'),
(14, 'Noah',   'Jackson',  'noah.j@yahoo.com',      'IT',        'System Admin',         80000.00,'2018-08-25','1990-02-14','555-1014','Charlotte',    'USA','N'),
(15, 'Olivia', 'White',    'olivia.w@gmail.com',    'HR',        'HR Assistant',         50000.00,'2023-03-20','1998-09-05','555-1015','Indianapolis', 'USA','Y'),
(16, 'Paul',   'Harris',   'paul.h@outlook.com',    'Marketing', 'Content Writer',       52000.00,'2021-07-10','1996-11-20','555-1016','San Francisco','USA','Y'),
(17, 'Quinn',  'Clark',    'quinn.c@gmail.com',     'Sales',     'Sales Representative', 56000.00,'2022-09-15','1995-04-11','555-1017','Seattle',      'USA','Y'),
(18, 'Rachel', 'Lewis',    'rachel.l@yahoo.com',    'Finance',   'Budget Analyst',       73000.00,'2019-12-01','1991-01-30','555-1018','Denver',       'USA','Y'),
(19, 'Sam',    'Robinson', 'sam.r@gmail.com',       'IT',        'Cloud Architect',     105000.00,'2017-05-22','1986-07-19','555-1019','Nashville',    'USA','Y'),
(20, 'Tina',   'Walker',   'tina.w@outlook.com',    'HR',        'Training Manager',     69000.00,'2020-03-08','1988-12-03','555-1020','Baltimore',    'USA','Y'),
(21, 'Uma',    'Hall',     'uma.h@gmail.com',       'Marketing', 'Brand Manager',        77000.00,'2018-10-17','1990-08-25','555-1021','Louisville',   'USA','N'),
(22, 'Victor', 'Young',    'victor.y@yahoo.com',    'Sales',     'Sales Director',       98000.00,'2015-02-10','1980-03-07','555-1022','Portland',     'USA','Y');

use sakila;
select * from employees;
-- if(condition, True statement, False statement)
select first_name, department, salary, if(department='IT', True, False) from employees;
select first_name, department, salary, if(department='IT', salary*1.1, salary*1.05) from employees;
select first_name, department, salary, if(department='IT', salary*1.1, if(department='HR', salary*1.05, salary)) from employees;


select first_name, department, salary,
case 
	when department='IT' or department='HR' then 'A Category'
    else 'B Category'
end
from employees;

select first_name, department, salary,
case 
	when department='IT' then salary*1.1
    when department='HR' then salary*1.05
    else salary
end as 'newsalary'
from employees;

select * from employees;
-- Q. If the hiring date of an employee is before the year 2020. Print job title with senior and if the year is 2021 then print associate else print same name

select * from employees;
Select first_name, hire_date, job_title, year(hire_date),
case
	when year(hire_date) < 2020 then concat(' Senior ',job_title)
	when year(hire_date) = 2021 then concat(' Associate ',job_title)
	else job_title
end as updated_job_title
from employees;

-- Q. Create the three categories if the salary is greater than 70000 create the category name as avg salary, 
-- if the salary is greater than 85000 create the category name as high salary, 
-- if the salary is greater than one lakh then the category name as extreme high salary 
-- otherwise print the category name as low salary

select * from employees;
select first_name, salary,
case
	when salary > 70000 and salary < 85000 then 'Avg Salary'
    when salary > 85000 and salary < 100000 then 'High Salary'
    when salary > 100000 then 'Extreme High Salary'
    else 'Low salary'
end as category
from employees;

-- select the job title and print the column values based on the following condition
-- print job title eg: if accountant are 2 persons then print accountant has 2 persons

select job_title, count(job_title),
    concat( job_title, ' Position have ', COUNT(*), ' ',
case
	when count(*) = 1 then 'Employee'
	else 'Employees'
end) as result
from employees
group by job_title;

-- Learning Assignment: What is super key, What is primary key, what is foreign key?
-- What is Normalisation and what is 1NF?

-- Super key: A super key is any set of one or more columns that can uniquely identify a row in a table.
/*CREATE TABLE students (
    id INT,
    email VARCHAR(100),
    name VARCHAR(50),
    UNIQUE(id),
    UNIQUE(email),
    UNIQUE(id, name)
);*/
-- Primary key: A primary key is the smallest (minimal) super key that uniquely identifies each row.
-- Cannot be NULL
-- Must be unique
/*CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);*/
-- Foreign key: A foreign key is a column that creates a relationship between two tables. 
-- It refers to the primary key of another table.
/*CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);*/
-- Normalization: Normalization is the process of organizing data in a database to:
-- Remove redundancy (duplicate data)
-- Improve data integrity
-- Make data consistent
-- The steps to remove duplicacy is known as Normal Form (1NF, 2NF, 3NF, 4NF, BCNF).
/* CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course VARCHAR(50),
    instructor VARCHAR(50)
);

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);*/


-- 1NF: A table is in 1NF if:
-- All values are atomic (single value)
-- No repeating groups or multiple values in a single column
/*CREATE TABLE contacts (
    id INT,
    name VARCHAR(50),
    phone_number VARCHAR(15)
);*/
/* 
select col1, col2;
case
	when condition then statement 
end
from table_name
if(condition, True, if(condition, True, False))
*/

use sakila;
create database regexjoin;

use regexjoin;

-- Create first table: customers
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- Insert records into customers
INSERT INTO customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Priya', 'Mumbai'),
(3, 'Rahul', 'Pune'),
(4, 'Sneha', 'Jaipur'),
(5, 'Karan', 'Chennai');


-- Create second table: orders
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_name VARCHAR(50)
);

-- Insert records into orders
-- Duplicate customer_id is present because some customers ordered multiple products
INSERT INTO orders VALUES
(101, 1, 'Laptop'),
(102, 2, 'Mobile'),
(103, 1, 'Keyboard'),
(104, 3, 'Mouse'),
(105, 2, 'Headphones');

select customers.customer_id, customers.customer_name, orders.product_name from customers
join orders where customers.customer_id = orders.customer_id;

-- Learning Assignment: What is Inner join, Left join and Right join 

use sakila;
-- Self join: A table when joined with itself

create database joindb;

use joindb;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    manager_id INT,
    salary INT
);

INSERT INTO employees (emp_id, emp_name, department, manager_id, salary) VALUES
(1, 'Amit', 'Management', NULL, 120000),
(2, 'Neha', 'HR', 1, 75000),
(3, 'Raj', 'IT', 1, 90000),
(4, 'Simran', 'Finance', 1, 85000),
(5, 'Karan', 'IT', 3, 70000),
(6, 'Priya', 'IT', 3, 72000),
(7, 'Rohit', 'HR', 2, 50000),
(8, 'Anjali', 'HR', 2, 52000),
(9, 'Vikas', 'Finance', 4, 65000),
(10, 'Sneha', 'Finance', 4, 62000),
(11, 'Arjun', 'IT', 5, 55000),
(12, 'Pooja', 'IT', 5, 53000),
(13, 'Meera', 'HR', 7, 45000),
(14, 'Dev', 'Finance', 9, 48000),
(15, 'Nitin', 'IT', 6, 51000);

-- EMPLOYEE MANAGER_ID = MANAGER EMPLOYEE_ID (CORRECT)
-- Make notes an put it on Notebook LLM

select empl.emp_id, empl.emp_name, empl.manager_id, mngr.emp_id, mngr.emp_name from employees as empl
join employees as mngr
where empl.manager_id=mngr.emp_id;

-- You need to find that employee whose department is same as the department of its manager.


select e.emp_id, e.emp_name, e.manager_id, e.department, m.emp_id, m.emp_name,
m.department
from employees as e join employees as m
where e.manager_id=m.emp_id and e.department=m.department;

-- you need to find out the employee name and its salary if it is greater than the salary of its manager

select empl.emp_name as employee_name, empl.salary as employee_salary,
mngr.emp_name as manager_name, mngr.salary as manager_salary
from employees as empl join employees as mngr on empl.manager_id = mngr.emp_id
where empl.salary > mngr.salary;

-- Q. Show all the employee name with all the manager name
select empl.emp_name as employee_name, mngr.emp_name as manager_name
from employees as empl left join employees as mngr
on empl.manager_id = mngr.emp_id;

-- Q. Show employee and its grand manager
select empl.emp_name as employee_name, mngr.emp_name as manager_name,
gmngr.emp_name as grand_manager from employees as empl
left join employees as mngr on empl.manager_id = mngr.emp_id
left join employees as gmngr on mngr.manager_id = gmngr.emp_id;

-- Q. Find the employees who are also the manager
select distinct mngr.emp_name from employees as empl
join employees as mngr on empl.manager_id = mngr.emp_id;