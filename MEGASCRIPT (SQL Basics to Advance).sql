-- MEGASCRIPT (SQL Basics-to-Advance)

DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

-- SELECT STATEMENT

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name, last_name, birth_date, age, (age + 10) * 10 + 10 AS aged
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;

-- WHERE CLAUSE

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

-- ORDER/GROUP BY

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY 5, 4;

-- WHERE and HAVING Clause

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

-- LIMIT and ALIASING

-- LIMIT
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- AS aka. Aliasing
SELECT gender, AVG (age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

-- JOINS (INNER, OUTER-LEFT,RIGHT, SELF)

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

-- UNIONS (stacks columns together like a JOIN function)

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'Old Man' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name, last_name, 'Highly Paid Employee' as Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

-- STRING Functions

SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2; 

SELECT UPPER('sky');

SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT TRIM('             sky             ');

SELECT LTRIM('             sky             ');
SELECT RTRIM('             sky             ');

-- number represnts how many letters its going to print from the left and right
SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
-- the two number represents as the starting position and the number of letters that will be printed (in that order)
SUBSTRING(first_name, 3 , 2),
SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;

-- replaces letters with another character
SELECT first_name, REPLACE(first_name, 'a' , 'z')
FROM employee_demographics;

-- shows the location in the string
SELECT LOCATE('x','Alexander');

SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

-- combines two strings together
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name
FROM employee_demographics;

-- CASE Statements

SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END AS age_bracket
FROM employee_demographics;

-- Pay Increase
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

SELECT  first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS New_Salary,

CASE
	WHEN dept_id = 6 THEN salary * 1.10
END AS Bonus
FROM employee_salary;

SELECT *
FROM parks_departments
;

-- SUBQUERIES (similar to join but only adds specific columns in a table)

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

-- WINDOW Functions

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

-- CTEs (COMMON TABLE EXPRESSIONS)

WITH CTE_Example (gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS (
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count
FROM employee_demographics AS ed
JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example
;

SELECT AVG(avg_sal)
FROM (SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count
FROM employee_demographics AS ed
JOIN employee_salary AS es
	ON ed.employee_id = es.employee_id
GROUP BY gender
) 
example_subquery;

WITH CTE_Example AS (
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- TEMPORARY TABLES

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

-- STORED Procedures

SELECT *
FROM employee_salary
WHERE salary >= 50000
;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

CALL large_salaries();


DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000
	;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000
	;
END $$
DELIMITER ;

CALL large_salaries3();


DELIMITER $$
CREATE PROCEDURE large_salaries4(eldenlord INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = eldenlord
	;
END $$
DELIMITER ;

CALL large_salaries4(1);

-- TRIGGERS and EVENTS

SELECT * 
FROM employee_demographics
;

SELECT *
FROM employee_salary
;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES ('13','Jean-Ralphio', 'Saperstien', 'Entertainment 720 CEO', '1000000', NULL);

-- EVENTS

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees1
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';

