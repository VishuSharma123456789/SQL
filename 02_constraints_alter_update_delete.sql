create table Amazone_Store2
(
Order_id integer NOT NULL UNIQUE, -- Not null constraint, Unique constraint
Order_date date,
Product_name varchar(20), 
Total_price decimal,
Payment_method varchar(20) check (Payment_method in ('UPI','Credit Card')) default 'UPI', -- Check Constraint
Discount integer check (Discount <= 20), -- Check Constraint
Category varchar(20) default'Mens Wear' -- Default constraint
primary key (Order_id)
);

select * from Amazone_Store2;

insert into Amazone_Store2(Order_id,Order_date,Total_price,Product_name) values(1,'2020-10-23',2500,'Laptop');

drop table Amazone_Store2;

insert into Amazone_Store2 values(null,'2020-10-01','Water Bottle',534.8,'Creit Card'); -- NOT NULL constraint

insert into Amazone_Store2 values(4,'2020-10-01','Water Bottle',534.8,'UPI',-12);

insert into Amazone_Store2 values(1,'2020-10-01','Water Bottle',534.8,'Credit Card',16,default);

-- To alter the datatype of a column
alter table Amazone_Store2 alter column Order_date datetime;

alter table Amazone_Store2 alter column Order_id date;  -- It will not happen because int is incompatible with date

alter table Amazone_Store2 alter column Product_name varchar(15); -- It will happen if all product names were less than 15 or equal to it

-- If table is empty then we can alter any datatype to any other datatype

-- To add the column in a table
alter table Amazone_Store2 add username varchar(20);

alter table Amazone_Store2 add category varchar(20); 

-- To remove the  column from table
alter table Amazone_Store2 drop column category;


insert into Amazone_Store2 values(1,'2020-10-01','Water Bottle',534.8,'Credit Card',16,default);

insert into Amazone_Store2 values(2,'2020-10-01','Water Bottle',534.8,'Credit Card',16,default);

insert into Amazone_Store2 values(3,'2020-10-01','Water Bottle',534.8,'Credit Card',16,default);

select * from Amazone_Store2;

-- delete with filter condition
delete from Amazone_Store2 -- to delete all the rows

-- delete with filter condition
delete from Amazone_Store2 where Product_name = 'Water Bottle';

delete from Amazone_Store2 where Order_id = 2;

----- update 
update Amazone_Store2 set Discount = 20;

update Amazone_Store2 set Order_id = 2 where Order_id = 1

update Amazone_Store2 set Total_price = 500, Payment_method = 'UPI' where Order_id = 2;