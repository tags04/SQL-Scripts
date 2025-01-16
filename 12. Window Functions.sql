-- Window Functions

SELECT ed.first_name, ed.last_name, gender, (AVG(salary)) AS avg_salary
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
GROUP BY ed.first_name, ed.last_name, gender;
    

SELECT ed.first_name, ed.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

SELECT ed.first_name, ed.last_name, gender, salary, 
SUM(salary) OVER(PARTITION BY gender ORDER BY ed.employee_id) AS Rolling_Total
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

SELECT ed.employee_id, ed.first_name, ed.last_name, gender, salary,
ROW_NUMBER() OVER()
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

SELECT ed.employee_id, ed.first_name, ed.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;














