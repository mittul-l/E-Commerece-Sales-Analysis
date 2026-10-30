
use Economic_Analystics;
select count(*) as Total_Customers
from dbo.olist_customers_dataset;
select count(*) as Total_order_items
from dbo.olist_order_items_dataset;
select count(*) as Total_orders
from dbo.olist_orders_dataset;
select c.customer_unique_id, 
count(o.order_id) as Total_orders
from dbo.olist_customers_dataset c
join dbo.olist_orders_dataset o
on c.customer_id = o.customer_id
group by c.customer_unique_id
order by Total_orders desc;
with customer_order as 
(select c.customer_unique_id,
count(o.order_id) as Total_orders
from dbo.olist_customers_dataset c
join dbo.olist_orders_dataset o
on c.customer_id = o.customer_id
where o.order_status = 'delivered'
group by c.customer_unique_id
)
select count(*) as Total_customers,
sum(case when Total_orders = 1 then 1 else 0 end)
as one_time_customers,
sum(case when total_orders > 1 then 1 else 0 end)
as repeat_customers,
round(100.0 * sum(case when Total_orders > 1 then 1 else 0 end) / nullif(count(*), 0), 2)
as repeat_customer_percentage
from customer_order;
SELECT
    LEFT(o.order_purchase_timestamp, 7) AS month,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM dbo.olist_orders_dataset o
JOIN dbo.olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY LEFT(o.order_purchase_timestamp, 7)
ORDER BY month;
select
round(sum(oi.price) / count(distinct(o.order_id)), 2) as average_order_value
from dbo.olist_orders_dataset o
join dbo.olist_order_items_dataset oi 
on o.order_id = oi.order_id
where o.order_status = 'delivered';
select Top 10 c.customer_state, 
round(sum(oi.price), 2) as total_sales
from dbo.olist_customers_dataset c
join dbo.olist_orders_dataset o
on c.customer_id = o.customer_id
join dbo.olist_order_items_dataset oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by c.customer_state
order by total_sales desc;
select Top 10 oi.product_id,
count(*) as units_sold
from dbo.olist_order_items_dataset oi
join dbo.olist_orders_dataset o 
on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by oi.product_id
order by units_sold desc;
select top 10
oi.seller_id,
round(sum(oi.price), 2) as total_sales
from dbo.olist_order_items_dataset oi
join dbo.olist_orders_dataset o
on oi.order_id = o.order_id
group by oi.seller_id
order by total_sales desc;
select order_status,
count(*) as total_orders
from dbo.olist_orders_dataset
group by order_status 
order by total_orders desc;
select
avg(datediff(day, 
try_convert(datetime2, order_purchase_timestamp, 126),
TRY_CONVERT(datetime2, order_delivered_customer_date, 126)
) * 1.0) as avg_delivery_days
from dbo.olist_orders_dataset
where order_status = 'delivered';
select 
count(*) as late_orders
from dbo.olist_orders_dataset
where order_status = 'delivered'
and cast(TRY_CONVERT(datetime2, 
order_delivered_customer_date, 126) as date)
>
cast(TRY_CONVERT(datetime2, 
order_estimated_delivery_date, 126) as date);
