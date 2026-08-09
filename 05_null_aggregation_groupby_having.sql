-- ============================================================
-- NULL VALUES
-- ============================================================

select * from Orders2
where Category is null;


select * from Orders2
where Category is not null;


update Orders2
set [Category] = null
where [Row ID] <=2


Update Orders2
set Category = 'Furniture'
where Category is null


-- ============================================================
-- AGGREGATION
-- ============================================================

-- AGGREGATION --

select  Region,Count(*) as Cnt, 
Sum(Sales) as Total_Sales,
max(Sales) as Max_Sales,
min(Profit) as Min_Profit,
avg(Profit) as Avg_Profit
from Orders2
group by Region;


-- Column 'Orders2.Row ID' is invalid in the select list because it
-- is not contained in either an aggregate function or the GROUP BY clause.

select * from Orders2 
group by Region;


-- ============================================================
-- GROUP BY WITH MULTIPLE COLUMNS
-- ============================================================

select Region , Category,Sum(Sales) as Total_Sales
from Orders2
group by Region,Category


select Region , Category,Sum(Sales) as Total_Sales  -- ERROR
from Orders2
group by Region


select Region , Category,Sum(Sales) as Total_Sales -- ERROR
from Orders2
group by Category


-- ============================================================
-- GROUP BY AND SELECTED COLUMNS
-- ============================================================

select Region,Sum(Sales) as Total_Sales
from Orders2
group by Region,Category


select Region,Sum(Sales) as Total_Sales
from Orders2
group by Region


-- ============================================================
-- WHERE + GROUP BY + TOP + ORDER BY
-- ============================================================

select top 2 Region,sum(Sales) as Total_Sales
from Orders2
where Profit > 50
group by Region
order by Total_Sales desc


-- ============================================================
-- HAVING
-- ============================================================

select top 2 Region,sum(Sales) as Total_Sales --ERROR
from Orders2
group by Region
having Profit > 50 
order by Total_Sales desc


select top 5 Region,sum(Sales) as Total_Sales
from Orders2
group by Region
having sum(Sales) > 50
order by Total_Sales desc;


-- WHERE cannot be used with aggregate functions

select top 5 Region,sum(Sales) as Total_Sales -- ERROR
from Orders2
where sum(Sales) > 50
group by Region
order by Total_Sales desc;


-- ============================================================
-- WHERE VS HAVING
-- ============================================================

select [Sub-Category] , sum(Sales) as Total_Sales from Orders2
group by [Sub-Category]
having [Sub-Category] = 'Phones'
Order by Total_Sales desc;


select [Sub-Category] , sum(Sales) as Total_Sales from Orders2-- This and above query both give same answer but this is better
where [Sub-Category] = 'Phones'
group by [Sub-Category]
Order by Total_Sales desc; 


-- ============================================================
-- COUNT
-- ============================================================

select count(*) ,count(1) from Orders2; -- both have same answers(that is count 1 as many times as there are rows in Order2

select count(Region) ,count(distinct Region)from Orders2;


-- ============================================================
-- IMPORTANT EXAMPLE
-- ============================================================

select Region,avg(Sales) as Avg_Sales,sum(Sales)/count(Region)
from Orders2
group by Region;


-- ============================================================
-- GOOD EXAMPLES
-- ============================================================

select [Sub-Category],sum(Sales) as total_Sales
from Orders2
group by [Sub-Category]
having max([Order Date]) > '2018-01-01'
order by total_Sales desc;


select [Sub-Category],sum(Sales) as total_Sales
from Orders2
where [Order Date] > '2018-01-01'
group by [Sub-Category]
order by total_Sales desc;