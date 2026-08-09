-- ============================================================
-- VIEWS
-- ============================================================

-- View,unlike tables it does not hold any data in memory but think as an envelop or structure of table just for view 
-- A view stores the query definition rather than storing a separate copy of the result data.
-- When we query the view, SQL Server retrieves the data from the underlying table(s).

create view  New_orders_view as -- view 1
select * from Neworders;

select * from New_orders_view


-- Creating a view using aggregation and UNION ALL
-- This view combines Category, Sub_Category and Ship_Mode
-- and shows their total sales separately for West and East regions.

create view New_orders_view_1 as  -- view 2
select 'Category' as hierarchy_type1,Category as hierarchy_name,
sum(case when Region = 'West' then Sales end) as total_sales_in_west_region,
sum(case when Region = 'East' then Sales end) as total_sales_in_east_region
from Neworders
group by Category
union all
select 'subcategory' as hierarchy_type,[Sub_Category] as hierarchy_name,
sum(case when Region = 'West' then Sales end) as total_sales_in_west_region,
sum(case when Region = 'East' then Sales end) as total_sales_in_east_region
from Neworders
group by Sub_Category
union all
select 'shipmode' as hierarchy_type,[Ship_Mode] as hierarchy_name,
sum(case when Region = 'West' then Sales end) as total_sales_in_west_region,
sum(case when Region = 'East' then Sales end) as total_sales_in_east_region
from Neworders
group by Ship_Mode

select * from New_orders_view_1 


-- Creating view from table of another database
-- Syntax:
-- DatabaseName.SchemaName.TableName

create view New_Orders as -- creating view from table of another database
select * from Namaste_SQL.dbo.Orders

select * from New_Orders


-- ============================================================
-- REFERENTIAL INTEGRITY / FOREIGN KEY CONSTRAINT
-- ============================================================

-- Referential Integrity Constraint or Foreign Key Constraint
--01 the column which we are referencing should be a primary key and also not null

-- Here dep_id in emp references dep_id in dept.
-- Therefore, a value inserted into emp.dep_id must already exist in dept.dep_id.

create table emp(
emp_id integer,
emp_name varchar(20),
dep_id integer references dept(dep_id)
)


-- Making the referenced column NOT NULL and PRIMARY KEY
-- A primary key uniquely identifies each row and cannot contain NULL values.

alter table dept alter column dep_id integer  not null 
alter table dept add constraint primary_key primary key (dep_id)

select * from dept
select * from emp


-- These rows will work only when the corresponding dep_id
-- already exists in the dept table.

insert into emp values(1,'vishal',100),(1,'vishal',100),(2,'Anoop',200),(3,'Kiran',300),(4,'Ajay',400)


-- 500 does not currently exist in dept.
-- Therefore, this will show a Foreign Key constraint error.

insert into emp values(5,'sujal',500) -- at first it will show error as conflict with Foreign key constraint
-- but if we add 500 in dept then it  will not show error


-- Now 500 exists in the parent table, so emp can reference it.

insert into dept values(500,'Operational')


-- This will give an error because dep_id is a PRIMARY KEY
-- and PRIMARY KEY cannot contain NULL.

insert into dept values(null,'Fitter')-- error bcoz it is primary key and also not null


-- Foreign key column itself can contain NULL unless NOT NULL is specified.
-- NULL means that this employee is not assigned to a department.

insert into emp values(6,'Arpit',null)--but here we can add null becoz it do not have not null constraints


-- ============================================================
-- COMPOSITE PRIMARY KEY / FOREIGN KEY
-- ============================================================

-- Foreign key constraint on 2 columns 

-- Here dep_id + loc_id together form the PRIMARY KEY.
-- Therefore, the combination of both values must be unique.

create table dept2(
dep_id integer,
loc_id integer,
dep_name varchar(20)

constraint Pk_department
primary key(dep_id,loc_id)
)


insert into dept2 values(100,1,'Data Analyst')
insert into dept2 values(100,2,'Data Scientist')
insert into dept2 values(200,1,'Web Developer')
insert into dept2 values(200,2,'Senior Web Developer')


-- emp2 will reference the combination (dep_id, loc_id)
-- from dept2.

CREATE TABLE emp2
(
    emp_id INT,
    dep_id INT,
    locationn_id INT
);


-- NOTE:
-- The table above contains "locationn_id", while the following
-- statement uses "location_id".
-- This will produce an error because location_id does not exist
-- in emp2.

alter table emp2
add constraint Fk_emp2
foreign key(dep_id,location_id)
references dept2(dep_id,loc_id);


select * from dept2
select * from emp2


-- This combination (100,1) exists in dept2, so conceptually
-- it satisfies the composite foreign key relationship.

insert into emp2 values(01,100,1)


-- This combination uses location_id = 3, which does not exist
-- with dep_id = 100 in dept2, so it would violate the
-- composite foreign key constraint if the FK were created correctly.

insert into emp2 values(02,100,3) -- error


-- ============================================================
-- IDENTITY
-- ============================================================

--Concept of identity,Identity(int1,int2) where int1 is starting number and int2 is increment or decrement
--Note you cannot put your own vales

-- IDENTITY(1,2) means:
-- 1 = starting value
-- 2 = increment
--
-- Generated values will be:
-- 1, 3, 5, 7, 9, ...

create table dep1(
id int identity(1,2),
dep_id int,
dep_name varchar(20)
)


select * from dep1


-- No value is provided for id because SQL Server generates it automatically.

insert into dep1 values(100,'Data Engineer' )--no need to pass value for id as it is identity


insert into dep1 values(200,'Data Analyst')--it start with 1 and icrease by 2 like 1,3,5 etc.