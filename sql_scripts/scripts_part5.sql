--customer whose order has the max amount
SELECT c.first_name,
       c.last_name,
       o.amount
FROM customers c
JOIN orders o 
	ON c.customer_id = o.customer_id
WHERE amount = (
		SELECT MAX(amount) 
		FROM orders);


