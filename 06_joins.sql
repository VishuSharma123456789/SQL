-- ============================================================
-- JOINS
-- ============================================================


-- ============================================================
-- JOINING ORDERS AND RETURNS
-- ============================================================

select * from Neworders

select * from Newreturns


select o.Order_ID,o.Order_Date,r.[Order Id]
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


select distinct(o.Order_ID),o.Order_Date,r.[Order Id]
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


-- Selecting columns from both tables

select o.*,r.*
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


-- Selecting only columns from Orders

select o.*
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


-- Selecting only columns from Returns

select r.*
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


select o.Order_ID,o.Order_Date,o.Product_ID,r.[Order Id],r.[Return Reason]
from Neworders o
inner join Newreturns r on o.Order_ID = r.[Order Id]


-- LEFT JOIN

select o.Order_ID,o.Order_Date,o.Product_ID,r.[Order Id],r.[Return Reason]
from Neworders o
left join Newreturns r on o.Order_ID = r.[Order Id]


-- GROUP BY after JOIN

select r.[Return Reason],sum(Sales)
from Neworders o
left join Newreturns r on o.Order_ID = r.[Order Id]
group by r.[Return Reason]


-- ============================================================
-- EMPLOYEE TABLE
-- ============================================================

create table employee(
emp_id int,
emp_name varchar(20),
dept_id int,
salary int,
manager_id int,
emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);

insert into employee values(2,'Mohit',100,15000,5,48);

insert into employee values(3,'Vikas',100,10000,4,37);

insert into employee values(4,'Rohit',100,5000,2,16);

insert into employee values(5,'Mudit',200,12000,6,55);

insert into employee values(6,'Agam',200,12000,2,14);

insert into employee values(7,'Sanjay',200,9000,2,13);

insert into employee values(8,'Ashish',200,5000,2,12);

insert into employee values(9,'Mukesh',300,6000,6,51);

insert into employee values(10,'Rakesh',500,7000,6,50);


select * from employee;


-- ============================================================
-- DEPARTMENT TABLE
-- ============================================================

create table dept(
dep_id int,
dep_name varchar(20)
);


insert into dept values(100,'Analytics');

insert into dept values(200,'IT');

insert into dept values(300,'HR');

insert into dept values(400,'Text Analytics');


select * from dept;


-- ============================================================
-- CARTESIAN PRODUCT / CROSS JOIN
-- ============================================================

select *
from employee,dept;


select *
from employee inner join dept on 1 = 1;


select *
from employee inner join dept on 1 = 1;


-- ============================================================
-- INNER JOIN
-- ============================================================

select *
from employee e
inner join dept d on e.dept_id = d.dep_id


-- ============================================================
-- LEFT JOIN
-- ============================================================

select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name
from employee e
left join dept d on e.dept_id = d.dep_id


-- ============================================================
-- RIGHT JOIN
-- ============================================================

select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name
from employee e
right join dept d on e.dept_id = d.dep_id


-- ============================================================
-- FULL OUTER JOIN
-- ============================================================

select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name
from employee e
full outer join dept d on e.dept_id = d.dep_id


-- ============================================================
-- PEOPLE TABLE
-- ============================================================

create table people(
manager varchar(20),
region varchar(20)
);


insert into people
values('Ankit','West'),
('Sanjay','East'),
('Bishal','Central'),
('Gagan','South')


-- ============================================================
-- JOIN ON 3 TABLES
-- ============================================================

-- join on 3 tables

select o.Order_ID,o.Product_ID,r.[Return Reason],p.manager
from Neworders o
inner join Newreturns r on o.Order_ID =  r.[Order Id]
inner join people p on p.region = o.Region