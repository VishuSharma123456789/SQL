-- ============================================================
-- STRING FUNCTIONS
-- ============================================================

--01 len(word or column) , gives lenth of given word or column(important it do not count trailing spaces)
--02 left(word or column,Integer(like 4 or 5 etc)), gives desired character from left of word or column 
--03 right(word or column,Integer(like 4 or 5 etc)), gives desired character from right of word or column
--04 substring(column,starting index,length(how much yo want to print from starting index))
--05 charindex(write character to search like'e',column , starting index) , if starting index not given it will consider as 1
--06 concat(column1,separator,column2) , if sep is not provided it will consider as (' ') 
-- and we can do same by column1+'separator'+column2

select Order_ID,Customer_Name,len(Customer_Name),Segment,left(Customer_Name,4),right(Customer_Name,5),CHARINDEX('e',Customer_Name),
CHARINDEX('e',Customer_Name,CHARINDEX('e',Customer_Name)+1)
from Neworders


select Order_ID,Customer_Name,concat(Order_ID,Customer_Name),concat(Order_ID,'@ ',Customer_Name),Order_ID+' # '+Customer_Name,
left(Customer_Name,CHARINDEX(' ',Customer_Name)),SUBSTRING(Customer_Name,4,2)
from Neworders


--07 trim(string), it will remove all trailing and leading spaces 
--08  reverse(column) , to reverse every strring in specific column
--09 replace(column,string1,string2), to replace string1 with string2 in the selected column
--10 translate(column,string1,string2), to replace string1 with string2 but one by one order(,column,'CA','A$')
--  it will replace 'C' by 'A' and 'A' by '$'

select Customer_Name,reverse(Customer_Name),replace(Customer_Name,'m','Kya'),translate(Customer_Name,'oa','ao')
from Neworders


select Customer_Name, trim('  Vishu Sharma  ')
from Neworders


-- ============================================================
-- NULL HANDLING FUNCTIONS
-- ============================================================

--01 isnull(column,any character or string or value),if column is null then you will get the character or value otherwise column value
-- always remember if column datatype is string then pass only string and if it is integer then pass only integer

--02 coalesce(column1,column2,any value),if column1 is null it will give column2 value and if both are null it will give
-- the value you passed and passed value is also optional if you not provide it will give as null

select Order_ID,City,isnull(City,'Unknown'),isnull(Sales,1),isnull(City,1)
from Neworders


select Order_ID,City,coalesce(City,State,Region) --if City is null,then give State if it so give Region if all are null then give null
from Neworders


select Order_ID,City,coalesce(City,State,Region,'Unknown') --if City is null,then give State if it so give Region if all are null then Give 'Unknown'
from Neworders


-- ============================================================
-- SOME OTHER FUNCTIONS
-- ============================================================

--01 cast(cloumn as 'desired data type')
--02 round(column,round_of_number(like 1 or 2)

select Order_ID , Sales,cast(Sales as int),round(Sales,1),round(Sales,2)
from Neworders


-- ============================================================
-- SET OPERATIONS
-- ============================================================

--01 Union()
--02 Unionall()
--03 intersect(),gives only common values and if there is also duplicates in these common values 
-- like(column1 have 1 row and column2 have 2 rows same so it will delete one duplicate and then gives oone common)
--04 except

-- Important Note:- except union all enery set function removes  duplicates


-- ============================================================
-- CREATING TABLES FOR SET OPERATIONS
-- ============================================================

create table orders_west
(
order_id integer,
region varchar(20),
sales integer
)


create table orders_east
(
order_id integer,
region varchar(20),
sales integer
)


insert into orders_east values(1,'east',200),(2,'east',300),(3,'east',400)

insert into orders_west values(1,'west',200),(2,'west',300),(3,'west',400)

insert into orders_east values(2,'west',300)


select * from orders_east
union all
select * from orders_west


select * from orders_east
union
select * from orders_west


select * from orders_west
intersect
select * from orders_east


select * from orders_west

select * from orders_east


select * from orders_west
except
select * from orders_east;


-- ============================================================
-- EXCEPT WITH DIFFERENT DIRECTIONS
-- ============================================================

(select * from orders_east
except
select * from orders_west)


(select * from orders_west
except
select * from orders_east)


-- Combining both EXCEPT results using UNION

(select * from orders_east
except
select * from orders_west)
union
(select * from orders_west
except
select * from orders_east)