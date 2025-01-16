-- Temporary Tables

CREATE TEMPORARY TABLE temp_table
(
first_name VARCHAR(50),
last_name VARCHAR(50),
favourite_movie VARCHAR(100)
)
;

SELECT *
FROM temp_table
;

INSERT INTO temp_table
VALUES('Jan Carlo','Taguibulos','Toy Story 2')
;

SELECT *
FROM temp_table
;

SELECT *
FROM employee_salary
;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM salary_over_50k
;

