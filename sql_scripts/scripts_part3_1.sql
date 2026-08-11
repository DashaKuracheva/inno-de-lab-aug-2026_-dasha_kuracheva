--count customers in each country
SELECT country,
	   COUNT(*) AS customer_count
FROM CUSTOMERS C -- table "customers"
GROUP BY country
ORDER BY country DESC;
