--ProjectName Bob's Johnson where worked > 150 hours
SELECT projectname 
FROM projects pr
JOIN employeeprojects emp 
	ON pr.projectid = emp.projectid
JOIN employees e
	ON emp.employeeid= e.employeeid
WHERE e.firstname = 'Bob'
	AND e.lastname = 'Johnson'
	AND emp.hoursworked > 150;

--Increase 'budget' of projects (10%), where at least one employee from the IT department
UPDATE projects pr
SET budget = budget*1.1
WHERE EXISTS(
	SELECT *
	FROM employeeprojects emp 
	JOIN employees e
		ON emp.employeeid= e.employeeid
	WHERE emp.projectid=pr.projectid
		AND e.department IN ('IT', 'Senior IT')
);


--add project without enddate to complete the next task
INSERT INTO projects (projectname,budget, startdate )
VALUES ('Test Project', 50000, CURRENT_DATE );

-- set enddate = startdate + 1 year without enddate
UPDATE projects
SET enddate = startdate + INTERVAL '1 year'
WHERE enddate IS NULL;


--transaction insert
BEGIN;

INSERT INTO employees (firstname, lastname, department, salary, email)
VALUES ('Kris', 'Morgan', 'IT', 70000.00, 'kris.morgan5@gmail.com')
RETURNING employeeid;

INSERT INTO employeeprojects (projectid, employeeid, hoursworked)
VALUES (
	(
		SELECT projectid
		FROM projects 
		WHERE projectname = 'Website Redesign'
	),
    9, -- id from RETURNING
    80
);

COMMIT;





