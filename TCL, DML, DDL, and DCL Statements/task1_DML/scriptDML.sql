--INSERT 2 new employees in the table 'Employees'
INSERT INTO Employees (firstname, lastname, department, salary)
VALUES 
	('Josh', 'Brook', 'Analytics', 75000.00),
	('Alex', 'Miller', 'Marketing', 55000.00);

--Select all employees from the table 'Employees'
SELECT *
FROM Employees;

--Select only FirstName and LastName of employees from the 'IT' 
SELECT  firstname,
		lastname
FROM Employees
WHERE department = 'IT';

--Update Salary 'Alice Smith' to 65000.00
UPDATE Employees
SET salary=65000.00
WHERE firstname = 'Alice' 
	AND lastname = 'Smith';

--Delete employee 'Eve Davis'
DELETE FROM Employees
WHERE firstname = 'Eve' 
	AND lastname = 'Davis'; 

--Check all changes
SELECT *
FROM Employees;