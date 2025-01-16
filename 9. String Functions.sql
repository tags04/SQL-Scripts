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

















