use sakila;
create database joinpractice;

use joinpractice;


CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);



INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales');



INSERT INTO employees VALUES
(101, 'Alice', 70000, 1, NULL),
(102, 'Bob', 60000, 2, 101),
(103, 'Charlie', 55000, 2, 102),
(104, 'David', 50000, 3, 101),
(105, 'Eva', 45000, 4, 104),
(106, 'Frank', 75000, 1, 101),
(107, 'Grace', 80000, 2, 102),
(108, 'Helen', 62000, 3, 104),
(109, 'Ian', 47000, 4, 105),
(110, 'Jack', 53000, 2, 102),
(111, 'Kevin', 49000, 3, 104),
(112, 'Laura', 72000, 1, 101),
(113, 'Mike', 58000, 4, 105),
(114, 'Nina', 61000, 2, 107),
(115, 'Oscar', 52000, NULL, 101);

select * from employees;

-- Q1. Display employee names along with their department names.
select e.emp_name, d.dept_name
from employees e inner join departments d on e.dept_id = d.dept_id order by e.emp_name;

-- Q2. Display all employees and their department names, including employees without departments.
select e.emp_name, d.dept_name from employees e
left join departments d on e.dept_id = d.dept_id order by e.emp_name;

-- Q3. Find the number of employees in each department.
select d.dept_name, count(e.emp_id) as total_employees from departments d
left join employees e on d.dept_id = e.dept_id group by d.dept_name;

-- Q4. Display all departments and the total salary paid in each department.
select d.dept_name, sum(e.salary) as total_salary from departments d
left join employees e on d.dept_id = e.dept_id group by d.dept_name;

-- Q5. Find how many employees report to each manager.
select m.emp_name as manager, count(e.emp_id) as team_size
from employees e join employees m on e.manager_id = m.emp_id group by m.emp_name order by manager;

-- Q6. Display average salary department-wise where average salary is greater than 60000.
select d.dept_name, avg(e.salary) as avg_salary from departments d
join employees e on d.dept_id = e.dept_id group by d.dept_name having avg(e.salary) > 60000;

use sakila;
select * from actor;
select * from film_actor;
select * from film;

-- Q1. select actor_id, actor full name and film id for which actor have worked. 
-- Q2. Get the film_id, the film title and the actor_id.
-- Q3. Find the actor_id, actor_name and the movie he has worked.
-- Q4. Find the actor_id, actor_name and film_id only for the movie whose length is greater than 120.
-- Q5. Get the actor_id, the actor_name and the total no. of movies he has worked.
-- Q6. Get the film_title and the number of actors worked in that film.

-- Q1.  
select a.actor_id, concat(a.first_name, ' ', a.last_name) as actor_name, fa.film_id
from actor a join film_actor fa on a.actor_id = fa.actor_id;

-- Q2. 
select f.film_id, f.title, fa.actor_id from film f join film_actor fa on f.film_id = fa.film_id;

-- Q3.
select a.actor_id, concat(a.first_name, ' ', a.last_name) as actor_name, f.title as movie_name
from actor a join film_actor fa on a.actor_id = fa.actor_id join film f on fa.film_id = f.film_id;

-- Q4. 
select a.actor_id, concat(a.first_name, ' ', a.last_name) as actor_name, f.film_id
from actor a join film_actor fa on a.actor_id = fa.actor_id join film f on fa.film_id = f.film_id where f.length > 120;

-- Q5.
select a.actor_id, concat(a.first_name, ' ', a.last_name) as actor_name, count(fa.film_id) AS total_movies
from actor a join film_actor fa on a.actor_id = fa.actor_id group by a.actor_id, a.first_name, a.last_name;

-- Q6. 
select f.title as film_title, count(fa.actor_id) as total_actors from film f
join film_actor fa on f.film_id = fa.film_id group by f.film_id, f.title;