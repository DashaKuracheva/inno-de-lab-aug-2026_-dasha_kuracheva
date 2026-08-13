--total sum of orders for that customer
SELECT  order_id,
		customer_id,
		item,
		amount,
	SUM(amount) OVER(PARTITION BY customer_id) AS total_by_customer
FROM orders;