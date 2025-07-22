
CREATE TABLE employee (
    empid SERIAL PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    dept VARCHAR(50),
    salary DECIMAL(10,2) DEFAULT 30000.00,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO employee (fname, lname, email, dept, salary, hire_date) 
VALUES
('Raj', 'Sharma', 'raj.sharma@example.com', 'IT', 50000.00, '2020-01-15'),
('Priya', 'Singh', 'priya.singh@example.com', 'HR', 45000.00, '2019-03-22'),
('Arjun', 'Verma', 'arjun.verma@example.com', 'IT', 55000.00, '2021-06-01'),
('Suman', 'Patel', 'suman.patel@example.com', 'Finance', 60000.00, '2018-07-30'),
('Kavita', 'Rao', 'kavita.rao@example.com', 'HR', 47000.00, '2020-11-10'),
('Amit', 'Gupta', 'amit.gupta@example.com', 'Marketing', 52000.00, '2020-09-25'),
('Neha', 'Desai', 'neha.desai@example.com', 'IT', 48000.00, '2019-05-18'),
('Rahul', 'Kumar', 'rahul.kumar@example.com', 'IT', 53000.00, '2021-02-14'),
('Anjali', 'Mehta', 'anjali.mehta@example.com', 'Finance', 61000.00, '2018-12-03'),
('Vijay', 'Nair', 'vijay.nair@example.com', 'Marketing', 50000.00, '2020-04-19');

SELECT * FROM employee;

INSERT INTO employee (fname, lname, email, dept, salary, hire_date)
VALUES 
('Ra', 'Sharma', 'ra.sharma@example.com', 'IT', 50000.00, '2020-01-25');

SELECT * FROM employee;

INSERT INTO employee (fname, lname, email, dept, salary)
VALUES 
('ba', 'Sharma', 'ba.sharma@example.com', 'IT', 50000.00);

SELECT * FROM employee;

INSERT INTO employee (fname, lname, email, dept)
VALUES 
('ka', 'Sharma', 'ka.sharma@example.com', 'IT');

SELECT * FROM employee;

SELECT * FROM employee 
WHERE salary <=50000;




SELECT * FROM employee
WHERE dept = 'Finance' OR dept = 'HR';

SELECT * FROM employee
WHERE dept = 'HR'
AND salary <= 45000;


SELECT * FROM employee
WHERE dept IN ('HR','IT','Finance');

SELECT * FROM employee
WHERE dept NOT IN ('HR','IT','Finance');

SELECT * FROM employee
WHERE dept IN ('HR','IT','Finance')
AND salary >= 45000;

SELECT DISTINCT dept FROM employee;

SELECT * FROM employee ORDER BY fname;

SELECT * FROM employee ORDER BY fname desc;

SELECT * FROM employee ORDER BY fname DESC LIMIT 3;

SELECT * FROM employee 
WHERE dept LIKE 'M%' OR dept LIKE '%m';

SELECT * FROM employee 
WHERE dept LIKE 'M%';

SELECT * FROM employee 
WHERE fname LIKE 'A%';

SELECT * FROM employee 
WHERE fname LIKE 'A%';

SELECT * FROM employee 
WHERE Lower(LEFT(fname, 1)) = 'a';

SELECT COUNT(empid) FROM employee;

SELECT SUM(salary) FROM employee;

SELECT AVG(salary) FROM employee;

SELECT MAX(salary) FROM employee;

SELECT dept, COUNT(dept) FROM employee
GROUP BY dept;


SELECT dept, Sum(salary) FROM employee
GROUP BY dept;

SELECT dept, AVG(salary) FROM employee
GROUP BY dept;

SELECT dept, AVG(salary) FROM employee
WHERE dept = 'IT'
GROUP BY dept;

SELECT concat(fname, lname) AS fullname FROM employee;

SELECT concat(fname,' ', lname) fullname FROM employee;

SELECT concat_ws('-',fname, lname) fullname FROM employee;

SELECT * FROM employee;


SELECT substring(email, 1, position('@' IN email) - 1) AS username FROM employee;
SELECT  substring(email, position('@' IN email) + 1, length(email) - position('@' IN email)) AS domai FROM employee;

SELECT 
    empid,
    fname,
    lname,
    email,
    substring(email, 1, position('@' IN email) - 1) AS username,
    substring(email, position('@' IN email) + 1, length(email) - position('@' IN email)) AS domain,
    dept,
    salary,
    hire_date
FROM employee;


SELECT dept, replace(dept,'IT','Information Technology') 
FROM employee;

SELECT empid, fname, replace(dept,'IT','Information Technology'), salary FROM employee;

SELECT UPPER(fname) FIRSTname 
FROM employee;

SELECT fname, length(fname) AS name 
FROM employee;

SELECT concat_ws(':', empid, fname, dept, salary) AS Status 
FROM employee;

SELECT concat_ws(':', empid, concat(fname,' ',lname), dept, salary) AS Status 
FROM employee;

SELECT concat(left(dept, 1), empid), fname 
FROM employee;

SELECT fname FROM employee
WHERE fname LIKE '____';

SELECT * FROM employee 
ORDER BY salary DESC LIMIT 1;

SELECT * FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

SELECT * FROM employee 
WHERE salary = (SELECT MIN(salary) FROM employee);

SELECT * FROM employee;


SELECT *,
 CASE 
	WHEN salary >= 50000 THEN 'high'
	ELSE 'low'
 END AS salary_type 
FROM employee;


SELECT *,
CASE 
	WHEN salary > 50000 THEN 'High'
	WHEN salary BETWEEN 40000 AND 50000 THEN 'Mid'
	ELSE 'low'
END AS SalaryType
FROM employee;

SELECT *,
CASE
	WHEN salary > 50000 THEN round(salary * 0.10)
	WHEN salary BETWEEN 40000 AND 50000 THEN round(salary * 0.07)
	ELSE round(salary*0.05)
END AS bonus
FROM employee;

SELECT
CASE 
	WHEN salary > 50000 THEN 'High'
	WHEN salary BETWEEN 40000 AND 50000 THEN 'Mid'
	ELSE 'low'
END AS SalaryType, COUNT(empid) 
FROM employee GROUP BY SalaryType;


SELECT  * FROM employee;




CREATE OR REPLACE PROCEDURE update_emp_salary(
    p_employee_id INT,
    p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employee
    SET salary = p_new_salary
    WHERE empid = p_employee_id;
END;
$$;

CALL update_emp_salary (3, 81000);

SELECT * FROM employee ORDER BY empid;


CREATE OR REPLACE FUNCTION dept_max_sal_emp(dept_name VARCHAR)
RETURNS TABLE(
    empid INT, 
    fname VARCHAR(50), 
    salary DECIMAL(10,2)
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.empid, e.fname, e.salary
    FROM 
        employee e
    WHERE 
        e.dept = dept_name
        AND e.salary = (
            SELECT MAX(emp.salary)
            FROM employee emp
            WHERE emp.dept = dept_name
        );
END;
$$;

SELECT * FROM dept_max_sal_emp ('IT');


SELECT fname, salary, sum(salary) over(ORDER BY salary)
FROM employee;

SELECT fname, salary, AVG(salary) over(ORDER BY salary)
FROM employee;

SELECT row_number() over(ORDER BY fname), empid,
fname, dept, salary FROM employee;

SELECT row_number() over(PARTITION BY dept), empid,
fname, dept, salary FROM employee;

SELECT fname, salary, DENSE_Rank() over(ORDER BY salary DESC)
FROM employee;

SELECT fname, salary, LEAD(salary) over()
FROM employee;

SELECT fname, salary, LAG(salary) over()
FROM employee;

SELECT fname, salary, LEAD(salary) over(ORDER BY salary DESC )
FROM employee;

SELECT fname, salary, (salary - LEAD(salary) over(ORDER BY salary DESC ))
FROM employee;



WITH avg_sal AS (
    SELECT dept, AVG(salary) AS avg_salary
    FROM employee 
    GROUP BY dept
)
SELECT e.empid, e.fname, e.dept, e.salary, a.avg_salary
FROM employee e
JOIN avg_sal a ON e.dept = a.dept;


WITH avg_sal AS (
    SELECT dept, AVG(salary) AS avg_salary
    FROM employee 
    GROUP BY dept
)
SELECT e.empid, e.fname, e.dept, e.salary, a.avg_salary
FROM employee e
JOIN avg_sal a ON e.dept = a.dept
WHERE e.salary > a.avg_salary;

 WITH max_sal AS (
 SELECT dept, MAX(salary) AS max_salary 
 FROM employee GROUP BY dept
)  
SELECT e.empid, e.fname, e.dept, e.salary FROM employee e
JOIN max_sal m ON e.dept = m.dept
WHERE e.salary = m.max_salary;
 
 
 

