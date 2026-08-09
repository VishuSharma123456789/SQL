select * from employee
select * from employee

-- Concept of self join (however this concept is not specifically in sql but we do by considering a single table as twice 
-- and doing innner joins

select e1.emp_name , e2.emp_name-- to get (employee name,manager name)
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id

select e2.emp_name , e1.emp_name-- to gget same as above
from employee e1
inner join employee e2 on e1.emp_id = e2.manager_id

select e1.emp_name -- to get employee name whose salary is greater than their manager
from employee e1
inner join employee e2 on e1.manager_id = e2.emp_id
where e1.salary > e2.salary


--String functions
-- 01 STRING_AGG(column_name,Separator)
select dept_id,STRiNG_AgG(emp_name,',') -- used to concatinate strings
from employee
group by dept_id

select dept_id,STRiNG_AgG(emp_name,',')  within group(order by salary desc) as list_of_employees --concatinate + sort by any condition
from employee
group by dept_id

--Date functions
-- 01 datepart(year/month/week/etc,column name)
select * from Neworders
select Order_ID,Order_Date,datepart(year,Order_Date) as Year_of_order_date,
datepart(month,Order_Date) as Month_of_order_date,
datepart(week,Order_Date) as Week_of_order_date,
datename(year,Order_Date) as Year_name,
datename(month,Order_Date) as Month_name,
datename(weekday,Order_Date) as Day_name
from Neworders

--02 getdate() gives current year
select Order_ID,Order_Date,datepart(year,getdate()) as Year_of_order_date
from Neworders

--03 dateadd(day/week/month,number,column)
select Order_ID,Order_Date,
dateadd(day,5,Order_Date),
dateadd(week,6,Order_Date),
dateadd(day,-5,Order_Date),
dateadd(month,3,Order_Date),
dateadd(year,2,Order_Date)
from Neworders

-- datediff(day/month/year,column,column)
 select Order_Date,Ship_Date,
 datediff(day,Order_Date,Ship_Date),
 datediff(month,Order_Date,Ship_Date),
 datediff(year,Order_Date,Ship_Date)
 from Neworders

--Case Statements(Start with CASE and ends with END and in between contains multiple when statement and a single else)
-- else is optional you can give or not ,if give (do after all when conditions)
select Profit,
case
when Profit < 100 then 'Low Profit'
when Profit < 200 then 'Mid Profit' 
else 'High Profit'
end as Profit_Category
from Neworders