--Create a new user 'hr_user' and password
CREATE USER hr_user WITH PASSWORD 'hruser123';

--Grant hr_user SELECT permission on the table 'Employees'
GRANT SELECT ON Employees TO hr_user;

--Grant hr_user INSERT and UPDATE to the table 'Employees'
GRANT INSERT, UPDATE ON Employees TO hr_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO hr_user;--доступ к автоинкременту в employeerid