use shadidb;

create database subque;
CREATE TABLE Emp (
EMP_ID INT PRIMARY KEY,
NAME VARCHAR(50),
DEPARTMENT VARCHAR(50),
SALARY INT,
MANAGER_ID INT);
-- Insert Data
INSERT INTO Emp(EMP_ID, NAME, DEPARTMENT, SALARY, MANAGER_ID) VALUES
(101, 'Alice', 'HR', 50000, NULL),
(102, 'Bob', 'IT', 80000, 101),
(103, 'Charlie', 'IT', 75000, 101),
(104, 'Diana', 'Finance', 90000, NULL),
(105, 'Eve', 'HR', 48000, 101),
(106, 'Frank', 'Finance', 95000, 104),
(107, 'Grace', 'IT', 82000, 101);
select * from emp;

select avg(salary) from emp ;
select * from emp where salary > (select avg(salary) from emp );

-- select max(salary) from emp
-- select * from emp where salary > (select avg(salary) from emp );


select  min(salary) from emp where department = 'IT' ;

-- multirowSubquery topic
-- MULTIROWSUBQUERY TOPIC

select * from emp where name = 'Alice' or name = 'Bob';

select  department from emp where salary = 80000 or salary = 50000;

select * from emp where department in (select department from emp where name = 'Alice' or name = 'Bob');
-- multisubquery can not be use opretors

select salary from emp where emp_id = 103 or emp_id = 105;

 select * from emp where salary > any (select salary from emp where emp_id = 103 or emp_id = 107);
 
 select * from emp where department = 'HR' ;
 
 select * from emp where salary > any (select salary from emp where department = 'HR');
 
 select * from emp where salary > all (select salary from emp where department = 'HR');
 select * from emp;
 
 select * from emp where department = 'IT';
 
  select * from emp where salary > all (select salary from emp where department = 'IT');
  
  -- find the emp detail who work with it department and have the salary of emp id 101
  SELECT salary FROM emp WHERE department = 'IT'
  AND salary in (SELECT salary FROM emp WHERE emp_id = 101);
  
  -- find the name of person who slary is > all the salary of HR or  IT department
  SELECT NAME  FROM emp WHERE salary > ALL (SELECT salary FROM emp
    WHERE department IN ('HR', 'IT'));
  -- find the emp id emp name of the user who salary is > the slary of any emp working id 
  SELECT emp_id, name FROM emp WHERE salary > ANY ( SELECT salary FROM emp
    WHERE department = 'IT');
  -- find the secode highest salary from this table
  select * from emp where emp_id = 101 ;
  
  -- 1
SELECT * FROM employees WHERE department = 'IT' AND salary > (SELECT salary FROM employees WHERE emp_id = 101);

-- 2
SELECT name FROM employees WHERE salary > ALL ( SELECT salary FROM employees WHERE department IN ('HR', 'IT'));

-- 3
SELECT emp_id, name FROM employees WHERE salary > ANY (SELECT salary FROM employees WHERE manager_id = 101);

-- 4
SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees);

use sakila;
select * from emp;

create table departments(dept_id int, dept_name varchar(20), location varchar(20));
insert into departments values(10, 'HR', 'Mumbai'), (20, 'IT', 'Banglore'), (30, 'Finance', 'Delhi');

select * from departments;

select dept_name  from departments where location in ('Banglore', 'Delhi');

select * from emp where department =any (select dept_name  from departments where location in ('Banglore', 'Delhi'));

-- The correlated sub query is a type of sub query where the inner query is executed for each value of the outer query.
-- Inner query also refers to the column of outer query.
-- Correlated is also known as dependent query.
-- It is a type of query in which the nested query is executed for every row of outer query.
-- Generally the outer column is referred inside the nested query.
-- --------------------------------------------------------------------------------------------------------------------------------------------
select avg(salary) from emp where department='IT';

select * from emp where department='IT' and salary>(select avg(salary) from emp where department='IT');

select avg(salary) from emp where department='Finance';

select * from emp where department='Finance' and salary>(select avg(salary) from emp where department='Finance');

select * from emp as e where 
salary>(select avg(salary) from emp where department=e.department);

select * from emp;

select max(salary) from emp where department='IT';
select * from emp where department='Finance' and salary=(select max(salary) from emp where department='Finance');

select * from emp as eout where salary=(select max(salary) from emp where department=eout.department);

-- Find departments where all the employees earn above 70000.

select distinct department from emp as e where
50000 <= all(select salary from emp where department=e.department);