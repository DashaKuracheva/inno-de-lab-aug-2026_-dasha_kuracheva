 SELECT * FROM Employees;
 
 --INSERT a new employee
 INSERT INTO Employees (firstname, lastname, department, salary)
 VALUES ('Test', 'User', 'HR', 50000.00);
 
 --Update employee
 UPDATE Employees
 SET lastname= 'Korner',
 	 email = 'kornerTest@gmail.com'
 WHERE salary = 50000.00;