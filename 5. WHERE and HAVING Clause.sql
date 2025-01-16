-- Just HAVING Clause
SELECT gender, AVG(age) 
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- Both HAVING and WHERE Clause
SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING avg(salary) > 75000;
