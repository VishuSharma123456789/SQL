--Q1- write a query to find premium customers from orders data. 
-- Premium customers are those who have done more orders than average no of orders per customer.
select * from Neworders

-- By Subquery
select Customer_Name,count(distinct Order_ID)
from Neworders
group by Customer_Name
having count(distinct Order_ID) >
(select avg(distinct_count) as avg_orders
from
(select Customer_Name , count(distinct Order_ID) as distinct_count
from Neworders
group by Customer_Name) as table1)

-- By CTE

with no_of_orders_each_customer as(
select Customer_Name , count(distinct Order_ID) as distinct_count
from Neworders
group by Customer_Name)
select * from no_of_orders_each_customer where distinct_count > ( select(avg (distinct_count)) from no_of_orders_each_customer)

--Q2- write a query to find employees whose salary is more than average salary of employees in their department

select * from dept
select * from employee


select e.* 
from employee e
inner join 
(select dept_id, avg(salary) as avg_by_dept
from employee
group by dept_id) d on e.dept_id = d.dept_id
where e.salary > avg_by_dept

-- By another method
SELECT e.emp_name
FROM employee e
WHERE e.salary >
(
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.dept_id = e.dept_id
);

--Q3- write a query to find employees whose age is more than average age of all the employees.
select* from employee
select emp_name,emp_age
from employee
where emp_age >
(select avg(emp_age) from employee)

--Q4- write a query to print emp name, salary and dep id of highest salaried employee in each department 

select emp_name,salary,dept_id
from employee e 
where e.salary =
(select max(e2.salary)
from employee e2
where e2.dept_id = e.dept_id)

--Another way
select e.* 
from employee e
inner join 
(select dept_id, max(salary) as max_by_dept
from employee
group by dept_id) d on e.dept_id = d.dept_id
where e.salary = max_by_dept

--Q5- write a query to print emp name, salary and dep id of highest salaried employee overall
select emp_name,salary,dept_id
from employee
where salary = (select max(salary) from employee as max_salary_employee)

--Q6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category
select * from Neworders

with product_quantity as
(select Category,Product_ID,sum(Quantity) as total_quantity
from Neworders
group by Category,Product_ID),
cat_max_quantity as
(select Category,max(total_quantity) as max_quantity from product_quantity
group by Category)

select * from
product_quantity pq
inner join cat_max_quantity cmq on
pq.Category = cmq.Category
where pq.total_quantity = cmq.max_quantity


--By another method
select A1.*
from
(select Category,Product_ID,sum(Quantity) as total_quantity
from Neworders
group by Category,Product_ID) A1
inner join
(select Category,max(total_quantity) as max_quantity 
from
(select Category,Product_ID,sum(Quantity) as total_quantity
from Neworders
group by Category,Product_ID) A
group by Category) A2
on A1.Category = A2.Category
where A1.total_quantity = A2.max_quantity
