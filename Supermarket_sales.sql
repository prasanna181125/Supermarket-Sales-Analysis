CREATE TABLE SupermarketSales (
    Row_ID INT,
    Order_ID text,
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode text,
    Customer_ID text,
    Customer_Name text,
    Segment text,
    Country text,
    City text,
    State text,
    Postal_Code text,
    Region text,
    Product_ID text,
    Category text,
    Sub_Category text,
    Product_Name text,
    Sales FLOAT,  -- Changed from INT to FLOAT
    Quantity INT,
    Discount FLOAT,  -- Changed from INT to FLOAT
    Profit FLOAT,  -- Changed from INT to FLOAT
    Order_Priority text,
    Shipping_Cost FLOAT,  -- Changed from INT to FLOAT
    Customer_Tenure text,
    Marketing_Channel text,
    Product_Rating FLOAT,  -- Changed from INT to FLOAT
    Return_Status text,
    Payment_Method text
);


SELECT product_id, SUM(sales) AS total_sales
FROM supermarketsales
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;


Select region,AVG(ship_date - order_date) AS avg_shipping_days 
from supermarketsales
group by region

SELECT 
    order_id, 
    return_status, 
    AVG(ship_date - order_date) AS delay
FROM supermarketsales
WHERE return_status = 'Yes'
GROUP BY order_id, return_status
HAVING AVG(ship_date - order_date) > 5;

SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM supermarketsales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

select sum(sales) as Total_Sales,sum(profit) as Total_Profit,segment
from supermarketsales
group by segment;

Select sub_category, category,sum(profit) as total_profit
from supermarketsales
group by sub_category,category
order by  total_profit desc

select category, count(order_id) as total_order,count(case when return_status='Yes' then 1 end) as Return,
ROUND(
        COUNT(CASE WHEN return_status = 'Yes' THEN 1 END) * 100.0 / COUNT(order_id),
        2
    ) AS return_percentage
from supermarketsales
group by category

SELECT DISCOUNT, COUNT(RETURN_STATUS) AS TOTAL_RETURN, SUM(SALES) AS TOTAL_SALES
FROM SUPERMARKETSALES
WHERE RETURN_STATUS ='Yes'
GROUP BY DISCOUNT

SELECT * FROM SUPERMARKETSALES
WHERE PROFIT <0 AND DISCOUNT>0.3

SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,RETURN_STATUS,AVG(SALES) AS AVERGAE_SALES,COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM SUPERMARKETSALES
GROUP BY RETURN_STATUS,TO_CHAR(order_date, 'YYYY-MM')
ORDER BY MONTH;

SELECT STATE, SUM(SALES) AS TOTAL_SALES,SUM(PROFIT) AS TOTAL_PROFIT,AVG(PROFIT) AS AVG_PROFIT,COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM SUPERMARKETSALES
GROUP BY STATE
HAVING SUM(SALES) > 500000;

SELECT CUSTOMER_ID,CUSTOMER_NAME, COUNT(ORDER_ID) AS TOTAL_ORDER
FROM SUPERMARKETSALES
GROUP BY CUSTOMER_ID,CUSTOMER_NAME
HAVING COUNT(ORDER_ID) > 5

SELECT CATEGORY,PRODUCT_ID,PRODUCT_NAME
FROM SUPERMARKETSALES
GROUP BY category,PRODUCT_ID,PRODUCT_NAME

select region ,segment, avg(discount) as Avg_discount
from supermarketsales
group by region, segment



SELECT *
FROM supermarketsales
WHERE 
    
    sales > 200
    AND segment IN ('Consumer', 'Corporate')
    AND region IN ('East', 'South', 'Central')
    AND (
        return_status = 'Yes' 
        OR profit < 0 
        OR discount >= 0.20
    )
ORDER BY order_date
LIMIT 50000;

