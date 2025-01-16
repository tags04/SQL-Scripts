-- Subqueries

-- similar to join but only adds specific columns in a table
SELECT *
FROM employee_demographics
WHERE employee_id IN 
					(SELECT employee_id
                    FROM employee_salary
                    WhERE dept_id = 1) 
;

SELECT first_name, salary,
	(SELECT AVG(salary)
    FROM employee_salary)
FROM employee_salary;



SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT AVG(`MAX(age)`)
FROM(
SELECT gender, AVG(age) , MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_Table
;

SELECT AVG(max_age) AS max_age
FROM(
SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age,
MIN(age) AS min_age, 
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_Table
;