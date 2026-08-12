--customers have orders>=2 && status = 'Delivered'
SELECT  CONCAT(c.first_name,' ', c.last_name) AS full_name, --gluing columns
		country,
		COUNT(o.order_id) AS total_orders,
		SUM(o.amount) AS total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id=o.customer_id
WHERE EXISTS(
	SELECT *
	FROM orders o2
	INNER JOIN shippings s ON o2.customer_id = s.customer
	WHERE o2.customer_id = c.customer_id --connection with customers
		AND s.status = 'Delivered'
	)
GROUP BY c.first_name, 
		 c.last_name,
		 c.country
HAVING COUNT(o.order_id)>=2;		 


		