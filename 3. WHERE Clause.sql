SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary <= 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender != 'Female';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01';

-- AND OR NOT -- Logical Operators

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '%09%';