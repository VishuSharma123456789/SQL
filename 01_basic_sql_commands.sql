create table Amazone_Store
(
Order_id integer,
Order_date date,
Product_name varchar(100),
Total_price decimal(5,2),
Payment_method varchar(20),
);
/* drop a table
drop table Amazone_Store #ye drop krdega table ko aur fir saare DML and DQL operations error show krenge
*/
insert into Amazone_Store values(1,'2020-10-01','Baby Soap',453.23,'UPI');
insert into Amazone_Store values(2,'2020-10-02','Baby Powder',500,'Credit Card');
insert into Amazone_Store values(3,'2020-10-04','Baby Milk',230,'UPI');
insert into Amazone_Store values(4,'2020-10-03','Baby Milk',230.87,'Cash');

/* deleteting all rows
delete from Amazone_Store # lekin ab DQL error nhi dega lekin kuch show nhi krega and DML toh work krenge hi
*/

-- SQL(Structured Query Language)
Select * from Amazone_Store;

-- Limiting or selecting Scpecific columns
select Order_id,Total_price,Order_date from Amazone_Store;

-- Limiting or selecting specific rows
Select top 2 * from Amazone_Store

-- Data Sorting
Select * from Amazone_Store
Order by Order_date 

Select * from Amazone_Store
Order by Order_date desc,Total_price 

-- Create a table in another schema(for this first we have to create a new schema)

create table hr.test
(
id Integer,
name varchar(20)
);

insert into hr.test values(1,'Arun');
select * from hr.test

-- Creating another table in another schema

create table sales.test
(
id Integer,
name varchar(20)
);
select * from sales.test

-- Transferring values from one schema to other(but rember, both definition would be same)
insert into sales.test
select * from hr.test 

-- now seeing it
select * from sales.test