select * from employee


-- ============================================================
-- WINDOW FUNCTIONS
-- ============================================================

select *,
row_number() over(partition by dept_id order by salary desc) as row,
rank() over(partition by dept_id order by salary desc),
dense_rank() over(partition by dept_id order by salary desc) 
from employee


-- ============================================================
-- Print top 5 products from each category in terms of sales
-- ============================================================

with cat_product_sales as
(
    select Category,Product_ID,sum(Sales) as category_sales
    from Neworders
    group by Category,Product_ID
),
rnk_sales as
(
    select *,
    rank() over(partition by Category order by category_sales desc) as rn 
    from cat_product_sales
)

select * 
from rnk_sales
where rn <= 5


-- Another way of doing the same

with rnk_sales as
(
    select Category,Product_ID,
    rank() over(partition by Category order by sum(Sales) desc) as rn 
    from Neworders
    group by Category,Product_ID
)

select * 
from rnk_sales
where rn <= 5


-- Important:
-- Always keep the granularity in mind.
-- For example: whether aggregation is required,
-- and whether partitioning is required.


-- ============================================================
-- LEAD FUNCTION
-- ============================================================

-- LEAD gives the value from the next row
-- based on PARTITION BY and ORDER BY.
--
-- lead(column, index, default_value)
-- index and default_value are optional.
--
-- If there is no next value, LEAD returns NULL
-- unless a default value is provided.

select *,
lead(salary,1) over(partition by dept_id order by emp_name) as lead_sal
from employee

select *,
lead(salary,1,salary) over(partition by dept_id order by emp_name) as lead_sal
from employee

select *,
lead(salary,1,emp_age) over(partition by dept_id order by emp_name) as lead_sal
from employee

select *,
lead(salary,1,0) over(partition by dept_id order by emp_name) as lead_sal
from employee


-- ============================================================
-- LAG FUNCTION
-- ============================================================

-- LAG is opposite of LEAD.
-- It gives the value from the previous row.

select *,
lag(salary,1) over(partition by dept_id order by emp_name) as lead_sal
from employee

select *,
lag(salary,1,salary) over(partition by dept_id order by emp_name) as lead_sal
from employee


-- Important:
-- Reversing the ORDER BY can make LEAD and LAG
-- produce the same result.

select *,
lead(salary,1) over(partition by dept_id order by emp_name) as lead_sal
from employee

select *,
lag(salary,1) over(partition by dept_id order by emp_name desc) as lead_sal
from employee
-- Both give the same result