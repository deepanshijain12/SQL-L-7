use shadidb;
select * from emp;

-- partition by -> The collection of similar values

select *, sum(salary) over (partition by department),
sum(salary) over() from emp;

select *, sum(salary) over (partition by name) from emp;

select *, sum(salary) over (partition by manager_id) from emp;

select *, sum(salary) over (partition by emp_id) from emp;

select *, sum(salary) over (partition by department order by salary) from emp;

select name, department, salary, sum(salary) over (partition by department), 
salary - sum(salary) over (partition by department) from emp;

select name, department, salary, sum(salary) over (partition by department), 
(salary / sum(salary) over (partition by department)) * 100 from emp;

create database windowsdb;
use windowsdb;


-- ============================================
--  Create the employees table
-- ============================================
CREATE TABLE emp (
  emp_id    INT,
  name      VARCHAR(50),
  dept      VARCHAR(30),
  salary    INT,
  hire_year INT
);
 
-- ============================================
--  Insert sample data (12 employees)
-- ============================================
INSERT INTO emp VALUES
  (1,  'Alice',   'IT',      90000, 2019),
  (2,  'Bob',     'IT',      75000, 2020),
  (3,  'Charlie', 'IT',      82000, 2018),
  (4,  'Diana',   'HR',      68000, 2021),
  (5,  'Eve',     'HR',      72000, 2019),
  (6,  'Frank',   'HR',      65000, 2022),
  (7,  'Grace',   'Sales',   55000, 2020),
  (8,  'Henry',   'Sales',   60000, 2021),
  (9,  'Iris',    'Sales',   58000, 2019),
  (10, 'Jack',    'Finance', 95000, 2017),
  (11, 'Karen',   'Finance', 88000, 2018),
  (12, 'Leo',     'Finance', 91000, 2020);



select * from employees;

select *, sum(salary) over (partition by hire_year order by salary) from employees;

select *, max(salary) over (partition by dept order by hire_year) from employees;

select *, avg(salary) over (partition by dept order by hire_year) from employees;

select *, avg(salary) over (partition by dept),
case
	when salary > avg(salary) over (partition by dept) then 'Above avg salary'
    else 'Less than avg Salary'
    end
    from employees;
    
    select *, row_number() over (order by salary) from employees;
    
     select *, row_number() over (partition by dept) from employees;
     
     -- row_number is used to give unique number
     
     select *, rank() over (order by salary) from employees;
     select *, rank() over (order by salary desc) from employees;
     
     select *, rank() over (partition by dept order by salary) from employees;
     
     -- Learning Assignment
     -- Difference between windows function and group by
     -- Difference between Row number, rank and dense rank
     -- Difference between where and having clause
     -- Types of joins in sql
     -- Natural join and cartesian join
     -- What is super, primary, foreign, unique key
     
     use windowsdb;
     select * from employees;
     
     select *, sum(salary) over() from employees;
     
     select *, sum(salary) over(partition by dept order by salary) from employees;
     
     select *, row_number() over(order by dept),
     rank() over(order by salary),
     dense_rank() over(order by salary) from employees;
     
     select *, rank() over(partition by dept) from employees;
     
     use windowsdb;
     select * from emp;
     
     select *, sum(salary) over() from emp;
     
     select *, sum(salary) over(partition by dept order by salary) from emp;
     
     select *, row_number() over(order by dept),
     rank() over(order by salary),
     dense_rank() over(order by salary) from emp;
     
     select *, dense_rank() over(partition by dept order by hire_year) from emp;
     
     select * from emp as e
     where salary = (select max(salary) from emp where dept = e.dept);
     
     -- max 
     select * from
     (select *, max(salary) over(partition by dept) as deptSalary from emp) as trh
     where salary = deptSalary;
     -- Hum where clause directly deptSalary pr nhi lga skte kyuki where clause sabse pehle chlta hai toh error aa jayega
     
     select * from
     (select *, rank() over(partition by dept order by salary desc) as `rank` from emp) as temp
     where `rank` = 1;
     
     -- Q. Find the person whose salary is second highest
     select * from 
     (select *, dense_rank() over(order by salary desc)as drank from emp) as xyz
     where drank=2;
     
     select * from emp where salary = (select max(salary) from emp where salary < (select max(salary) from emp));
     
     -- IMP Question: second highest salary
     select max(salary) from emp where salary < (select max(salary) from emp);
     
     -- Find out the 4th lowest salary from the table
     
     select * from (select *, dense_rank() over(order by salary) as abc from emp) as temp where abc=4;
     