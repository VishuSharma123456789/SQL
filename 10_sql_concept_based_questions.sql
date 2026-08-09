create table icc_world_cup
(
Team_1 varchar(20),
Team_2 varchar(20),
Winner varchar(20)
);

insert into icc_world_cup values('India','SL','India'),
('SL','Aus','Aus'),('SA','Eng','Eng'),('Eng','NZ','NZ'),('Aus','India','India')

select * from icc_world_cup

--Q1 write a query to print below output from icc_world_cup table
--team name, no of matches played,no of wins , no of losses 
-- Note :- above question needs sub-query so we will do it later
select * from icc_world_cup
select team_name,count(1) as total_matches_played,sum(win_flag) as matches_won,count(1) - sum(win_flag) as matches_lost
from
(select Team_1 as team_name,case when Team_1 = Winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select Team_2 as team_name,case when Team_2 = Winner then 1 else 0 end as win_flag
from icc_world_cup) A
group by team_name

--Q2 write a query to print first name and last name of a customer using orders table
--(everything after first space can be considered as last name),customer_name, first_name,last_name

SELECT Customer_Name,case when charindex(' ',Customer_Name) > 0 then substring(Customer_Name,1,charindex(' ',Customer_Name)-1) else Customer_Name end as first_name,
case when charindex(' ',Customer_Name) > 0 then substring(Customer_Name,charindex(' ',Customer_Name)+1) else Customer_Name end as last_name
FROM Neworders

--Q3- write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
--id, total_rides , profit_rides

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select * from drivers
select d1.id as drivers_id, count(*) as total_rides,count(d2.id) as profit_rides
from drivers d1
left join drivers d2 on
d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
group by d1.id


--Q4- write a query to print customer name and no of occurence of character 'n' in the customer name.
--customer_name , count_of_occurence_of_n
select Customer_Name,len(Customer_Name) - len(replace(lower(Customer_Name),'n',''))
from Neworders

/* 5-write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
and so on all the category ,subcategory and ship_mode hierarchies */

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



--6 the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
--(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

select left(Order_ID,2) as Country_name,count(distinct(Order_ID)) Total_orders
from Neworders
group by left(Order_ID,2)


