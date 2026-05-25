create database if not exists datatypedb;

use datatypedb;

-- numeric
create table test1 (id tinyint);
insert into test1 values (-1), (10);
insert into test1 values (-129); -- out of range (1 byte => 8 bit => 2**8) (-128 to 127)
select * from test1;

-- small int -> 2 byte
-- medium int -> 3 byte
-- int -> 4 byte
-- big int -> 8 byte

create table test2 (age tinyint unsigned); 
insert into test2 values (250);
select * from test2;

create table test3 (salary float, salary2 double);
insert into test3 values (1989.9301934, 1989.9301934);
select * from test3;

create table test4 (price double(6,2)); -- total is 6,2 is decimal value, 4 are the values before
insert into test4 values (0.7326723); -- only two decimal values
insert into test4 values (44.7326723);
insert into test4 values (4453.7326723);
insert into test4 values (4453);
insert into test4 values (44531); -- error because there are 5 integer value

select * from test4;



create table test5 (countrycode char(3));
insert into test5 values ('IND');
insert into test5 values ('INDIA'); -- <<-------- error
insert into test5 values ('he          ');

select *, char_length (countrycode) from test5;
select * from test5;

create table test6 (countrycode varchar(3));
insert into test6 values ('IND');
insert into test6 values ('INDIA'); -- <<-------- error
insert into test6 values ('h           ');

select *, char_length (countrycode) from test6;