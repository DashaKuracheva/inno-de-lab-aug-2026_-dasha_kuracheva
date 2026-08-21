--Increase 'salary' of all employees in the 'HR' department by 10%
UPDATE employees	
SET salary = salary *1.1
WHERE department='HR';

--Upgrade 'department' of employee with a Salary above 'salary' > 70,000.00 to 'Senior IT'
UPDATE employees	
SET department = 'Senior IT'
WHERE salary > 70000.00;

--Delete all employees who don't have a project in table 'EmployeeProjects'
DELETE FROM employees e
WHERE NOT EXISTS(
	SELECT *
	FROM employeeprojects emp
	WHERE emp.employeeid = e.employeeid
);


BEGIN;

INSERT INTO projects(projectname, budget, startdate, enddate)
VALUES ('Desktop app for city lightings', 250000.00, '2026-08-16', '2027-01-16');

INSERT INTO employeeprojects(employeeid, projectid, hoursworked)
VALUES 
    (
        (SELECT employeeid FROM employees WHERE firstname = 'Diana' AND lastname = 'Prince'),
        (SELECT projectid FROM projects WHERE projectname = 'Desktop app for city lightings'),
        345
    ),
    (
        (SELECT employeeid FROM employees WHERE firstname = 'Alice' AND lastname = 'Smith'),
        (SELECT projectid FROM projects WHERE projectname = 'Desktop app for city lightings'),
        345
    );

COMMIT;


