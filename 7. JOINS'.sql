
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- INNER JOINS
SELECT ed.employee_id, age, occupation
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
;

-- OUTER JOINS (RIGHT, LEFT)
SELECT *
FROM employee_demographics AS ed
RIGHT JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
;

SELECT *
FROM employee_demographics AS ed
LEFT JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
;

-- SELF JOIN

SELECT emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_elf,
emp2.first_name as first_name_elf,
emp2.last_name as last_name_elf
FROM employee_salary as emp1
JOIN employee_salary as emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;


-- JOINING Multiple Tables

SELECT *
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
INNER JOIN parks_departments AS pd
	ON es.dept_id = pd.department_id
;

SELECT *
FROM parks_departments;















