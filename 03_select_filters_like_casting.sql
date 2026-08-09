-- ============================================================
-- SELECT, DISTINCT, FILTERS, CASTING AND LIKE
-- ============================================================


-- TOP
select top 6* 
from Orders
order by [Order Date] desc


-- ============================================================
-- DISTINCT
-- To select or know distinct classes or to get distinct values
-- of a column
-- ============================================================

select distinct [Ship Mode] from Orders


-- ============================================================
-- FILTERS
-- ============================================================

select * from Orders 
where [Order Date]='2018-12-08';


select top 10 * from Orders 
where [Ship Mode]='First Class';


select top 5 [Order Date],[Quantity] 
from Orders
where [Quantity] >= 5
order by Quantity desc;


select * from Orders
where [Order Date] < '2020-12-08'
order by [Order Date] desc


-- BETWEEN for dates
-- BETWEEN includes both boundary values

select * from Orders
where [Order Date] between '2018-12-08' and '2018-12-12'
Order by [Order Date] desc


-- BETWEEN for numerical values

select * from Orders
where [Quantity] between 3 and 5
Order by [Quantity]


-- IN
-- Selects rows where the value matches any value in the list

select * from Orders
where [Ship Mode] in ('First Class','Same Day')


-- NOT IN
-- Selects rows where the value does not match any value in the list

select *  from Orders
where [Ship Mode] not in ('First Class','Same Day')


-- AND
-- Both conditions must be TRUE

select [Order Date],[Ship Mode],[Segment] 
from Orders
where [Ship Mode] = 'First Class' and [Segment] = 'Consumer'


-- OR
-- At least one condition must be TRUE

select [Order Date],[Ship Mode],[Segment] 
from Orders
where [Ship Mode] = 'First Class' or [Segment] = 'Consumer'


-- ============================================================
-- CAST
-- Casting kar rhe h datetime vaale column(Order Date) mein
-- ============================================================

select cast([Order Date] as date) as Order_Date_New,* 
from Orders
where cast([Order Date] as date) = '2018-11-08'


-- ============================================================
-- CREATING A NEW COLUMN IN THE RESULT
-- ============================================================

-- New column add krne ke liye

select *,Profit/Sales as Ratio,getdate() as Total 
from Orders


-- ============================================================
-- LIKE OPERATOR
-- ============================================================

select [Order ID] ,[Order Date],[Customer Name] from Orders  
-- Give same answer as below because MSSQL Server default is Case Insensitive
where [Customer Name] like '%gute' 
-- matlab pahle kuch bhi lekin last mein 'gute' hi hona chahiye


select [Order ID] ,[Order Date],[Customer Name] from Orders
where [Customer Name] like '%Gute'


-- % means zero or more characters
-- Here 'ee' can occur anywhere in the Customer Name

select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'%ee%' 
-- matlab pehle aur last mein kuch bhi lekin middle me kahin 'ee' honna chahiye 


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'John%'


-- ESCAPE
-- escape '%'ko ek normal string samjhega
-- matlab ab 'John%' check hoga h ki nhi

select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'John%' escape '%'   


-- ============================================================
-- UPPER + LIKE
-- ============================================================

select [Order ID],[Order Date],[Customer Name],
upper([Customer Name]) as Name_Upper 
from Orders
where upper([Customer Name]) like 'A%A'


-- ============================================================
-- UNDERSCORE (_) WITH LIKE
-- ============================================================

select [Order ID],[Order Date],[Customer Name],
upper([Customer Name]) as name_upper 
from Orders 
-- matlab third character L hona chahiye 
where upper([Customer Name]) like '__L%' 
-- uske baad kuch bhi ho skta h, '_' ka matlab any character of anytype


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'_la%'


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'%_la%'


-- ============================================================
-- CHARACTER SETS WITH LIKE
-- ============================================================

select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'C[albo]%'  
-- matlab Start 'C' se aur uske baad 'a','l','b','o' hi hona chahiye
-- aur insab ke baad kuch bhi


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'%C[^albo]%'
-- ^ means NOT
-- C ke baad a, l, b, o nahi hona chahiye


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'%C[albo]%'  


-- Character range
-- [a-o] means any character from a to o

select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'%C[a-o]%'


select [Order ID],[Order Date],[Customer Name] from Orders
where [Customer Name] like'C[a-o]%' 
-- matlab pehle 'C' hona chahiye aur uske turant baad [a-o] ki range
-- mein koi bhi character
-- phir uske baad kuch bhi