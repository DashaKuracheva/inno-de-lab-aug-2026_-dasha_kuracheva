--clients from 'USA' and age > 25
SELECT first_name,
	   last_name,
	   country,
	   age
FROM  customers c
WHERE country IN ('USA')
	AND c.age > 25;