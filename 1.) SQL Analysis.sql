SELECT * FROM transactions where market_code='Mark001'

SELECT * from transactions where year(order_date) =2020

##revenue in any year here 2019 for ex
SELECT SUM(sales_amount) as total_revenue, year(order_date) as year FROM sales.transactions 
GROUP BY year(order_date) HAVING year= 2019

##revenue in year 2020 and month january
SELECT SUM(sales_amount) as total_revenue, year(order_date) as year,month(order_date) as month  FROM sales.transactions 
GROUP BY year(order_date), month(order_date) HAVING year= 2020 and month =1

##revenue in chennai
SELECT sum(sales_amount) as total_revenue from transactions WHERE market_code = 'Mark001' and year(order_date) =2020

##distinct product in chennai

SELECT distinct product_code from transactions WHERE market_code = 'Mark001'

##revenue in january 2020

select SUM(sales_amount) from transactions WHERE month(order_date) = 1 and year(order_date) = 2020

