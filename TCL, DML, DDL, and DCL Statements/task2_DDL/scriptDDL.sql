--Create table 'Department'
CREATE TABLE Departments(
	DepartmentID SERIAL PRIMARY KEY,
	DepartmentName VARCHAR(50) UNIQUE NOT NULL,
	Location VARCHAR(50)
);

--Alter the table 'Employees' 
ALTER TABLE Employees ADD COLUMN Email VARCHAR(100);

--Fill the Email column 
UPDATE Employees 
SET Email = LOWER(firstname || '.' || lastname || employeeid || '@gmail.com');

--Add a UNIQUE constraint to the Email column in the table 'Employees' 
ALTER TABLE Employees ADD CONSTRAINT UQ_Email UNIQUE(Email);

--Rename the 'Location' in the Departments table to 'OfficeLocation'
ALTER TABLE Departments RENAME COLUMN Location TO OfficeLocation;