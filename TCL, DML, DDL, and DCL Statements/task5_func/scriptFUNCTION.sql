-- function CalculateAnnualBonus
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
	employeeid INTEGER,
	salary NUMERIC(10,2)
	)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS $$
	BEGIN 
	
		RETURN salary*0.1;
		
	END;
$$;
	
SELECT  employeeid,
		firstname,
		lastname,
		salary,
		CalculateAnnualBonus(employeeid,salary) AS bonusSalary
FROM employees;

--creating VIEW
CREATE OR REPLACE VIEW IT_Department_View AS
SELECT  firstname,
		lastname,
		salary
FROM employees
WHERE department IN ('IT', 'Senior IT');

SELECT * 
FROM IT_Department_View;