-- Created database hr to store the csv file data in a table

use hr;

-- Viewing all the rows of the table

SELECT * FROM hr;

-- Renaming column ï»¿id to emp_id

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- Checking datatypes of the columns

DESCRIBE hr;

-- Selecting records from birthdate column

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

-- Changing the records in birthdate column to "YYYY-mm-dd" format

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Changing the datatype of birthdate colum  to DATE

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Changing the records in hire_date column to "YYYY-mm-dd" format

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

SELECT hire_date FROM hr;

-- Changing the datatype of hire_date colum  to DATE

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


-- Changing the records in termdate column to "YYYY-mm-dd" format

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- Changing the datatype of termdate colum  to DATE

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Adding one column Age 

ALTER TABLE hr ADD COLUMN age INT;

-- Calculating Age by year of birthdate and current date

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

UPDATE hr
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

SELECT termdate FROM hr;
