--list of deliveries with the customer's status and name
SELECT s.status,
	   c.first_name,
	   c.last_name
FROM shippings s
LEFT JOIN customers c --тоже самое как и INNER, при условии, если не будет NULL
	ON s.customer = c.customer_id;
