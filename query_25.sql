--find how many products falls into customer budget along with list of products.

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);


--select * from products
--select * from customer_budget


with cte as (
select *, 
sum(cost) over(order by cost asc) as cumulative_sum_cost
from products)
, be_afford as (
select *
from cte c
inner join customer_budget cb on cb.budget > c.cumulative_sum_cost)

select customer_id, budget, count(product_id) as no_of_products, string_agg(product_id, ',') as list_of_products
from be_afford
group by customer_id, budget

