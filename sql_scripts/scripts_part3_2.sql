--total number of orders, average amount for each product
SELECT item,
	   COUNT(*) AS order_count,
	   ROUND(AVG(amount), 2) AS avg_amount --rounding to 2 digits
FROM ORDERS O -- table "orders"
GROUP BY item
ORDER BY item;