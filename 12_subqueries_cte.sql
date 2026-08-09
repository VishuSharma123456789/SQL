-- ============================================================
-- SUBQUERIES
-- ============================================================

select * from Neworders

select avg(Sales)
from Neworders


-- 01 Find average order value
-- First calculate sales for each order, then find their average.

select avg(orders_sales) from
(select Order_ID,Sum(Sales) as orders_sales
from Neworders
group by Order_ID)  as orders_aggregated


-- 02 Find order with sales more than average order value

select Order_ID
from Neworders
group by Order_ID
having sum(Sales)>
(select avg(orders_sales)
from
(select Order_ID,sum(Sales) as orders_sales
from Neworders
group by Order_ID) as orders_aggregated)


-- 03 Find the employee details whose id not in dep_id

select * from employee
select * from dept

update employee
set dept_id = 700 where dept_id = 500

select * from employee -- Withot Sub-Query
where dept_id not in(100,200,300,400,500)


select * from employee -- By using Sub-Query
where dept_id not in(select dep_id from dept)


-- Another example of a subquery used in SELECT.
-- The average salary is calculated once and shown with every employee.

select *, (select avg(salary) from employee) as avg_salary from employee -- avg is 9100
where dept_id not in (select dep_id from dept)


select dept_id,avg(salary)
from employee
where dept_id != 700 -- avg is 9333
group by dept_id


-- Another way of doing question 02
-- Find order with sales more than average order value

select A.*,B.* from
(select Order_ID,sum(Sales) as Orders_sales
from Neworders
group by Order_ID) A
inner join
(select avg(Orders_sales) as Avg_value
from
(select Order_ID,sum(Sales) as Orders_sales
from Neworders
group by Order_ID) as Orders_aggregated) B
on 1 = 1
where Orders_sales > Avg_value;


-- Q4 give all employee details with the average of their department id

select*from employee

select e.*,d.avg_salary
from employee e
inner join
(select dept_id,avg(salary) as avg_salary
from employee
group by dept_id) d
on e.dept_id = d.dept_id


-- Q5 write a query to print below output from icc_world_cup table
-- team name, no of matches played,no of wins , no of losses
-- Note :- above question needs sub-query so we will do it later ,but as we have covered sub_query we will do now

select * from icc_world_cup

select team_name,count(1) as total_matches_played,sum(win_flag) as matches_won,count(1) - sum(win_flag) as matches_lost
from
(select Team_1 as team_name,case when Team_1 = Winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select Team_2 as team_name,case when Team_2 = Winner then 1 else 0 end as win_flag
from icc_world_cup) A
group by team_name


-- ============================================================
-- CTE
-- ============================================================

-- CTE = Common Table Expressions
-- A CTE gives a temporary name to a query result,
-- which can then be used in the main query.


-- Writing above subquery as CTE

with A as
(select Team_1 as team_name,case when Team_1 = Winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select Team_2 as team_name,case when Team_2 = Winner then 1 else 0 end as win_flag
from icc_world_cup)

select team_name,count(*) as total_matches_played,sum(win_flag) as matches_won,count(*) -  sum(win_flag) as matches_lost
from A
group by team_name


-- Q1 give all employee details with the average of their department id

with dep as
(select dept_id,avg(salary) as avg_salary
from employee
group by dept_id)
,total_salary as (select(sum(avg_salary) as ts from dep)

select e.*,d.*
from employee e
inner join dep d
on e.dept_id = d.dept_id


-- Another way of doing question 02 (Using CTE)
-- Find order with sales more than average order value

select A.*,B.* from
(select Order_ID,sum(Sales) as Orders_sales
from Neworders
group by Order_ID) A
inner join
(select avg(Orders_sales) as Avg_value
from
(select Order_ID,sum(Sales) as Orders_sales
from Neworders
group by Order_ID) as Orders_aggregated) B
on 1 = 1
where Orders_sales > Avg_value;


-- Very good example of CTE as we can use same CTE in another
-- Find order with sales more than average order value

with orders_wise_sales as
(select Order_ID,sum(Sales) as orders_sales
from Neworders
group by Order_ID)

select A.*,B.*
from orders_wise_sales A
inner join
(select avg(orders_aggregated.orders_sales) as avg_order_value from
orders_wise_sales as orders_aggregated) B
on 1 = 1
where orders_sales > avg_order_value


-- Another way of doing the same

with orders_wise_sales as
(select Order_ID,sum(Sales) as orders_sales
from Neworders
group by Order_ID),

B as (select avg(orders_aggregated.orders_sales) as avg_order_value from
orders_wise_sales as orders_aggregated)

select A.*,B.*
from orders_wise_sales A
inner join B
on 1 = 1
where orders_sales > avg_order_value


--
select * from employee -- By using Sub-Query
where dept_id not in(select dep_id from dept)


-- Above same with CTE

with depts as (select dep_id from dept)

select * from employee-- But here CTE is not required if it can be done easily and efficiently by SUB-QUERY
where dept_id not in (select dep_id from depts)


-- When we have multiple same SUB-QUERY ,better to go with CTE as they can be reused