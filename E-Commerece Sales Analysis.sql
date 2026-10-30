USE Test_DB;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;
select
datename(weekday, order_date) as Day_Name,
count(distinct order_id) as Total_Orders
from pizza_sales
group by datename(weekday, order_date);
select
datepart(hour, order_time) AS Hour,
count(distinct order_id) AS Total_Orders
from pizza_sales
group by datepart(hour, order_time)
order by Hour;
SELECT
    pizza_category,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Percentage_Sales DESC;
SELECT
    pizza_size,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_Sales DESC;
SELECT
pizza_category,
SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;
SELECT TOP 5
pizza_name,
SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;
SELECT TOP 5
pizza_name,
SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC;