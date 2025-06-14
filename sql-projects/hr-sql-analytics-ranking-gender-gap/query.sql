-- SETUP --
SELECT * FROM parks_and_recreation.employee_demographics;
SELECT * FROM parks_and_recreation.employee_salary;
SELECT * FROM parks_and_recreation.parks_departments;

-- STUDY CASE 1
-- Cumulative Sallary (Rolling Total) per Gender based on the First Name
SELECT CONCAT_WS(' ', dem.first_name, dem.last_name) AS full_name,
		gender,
        sal.salary,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY dem.first_name) AS row_num,
        SUM(salary) OVER(PARTITION BY gender ORDER BY dem.first_name) AS rolling_salary
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- STUDY CASE 2
-- Salary Rank per Department
SELECT employee_id,
		CONCAT_WS(' ', first_name, last_name) AS full_name,
		pd.department_name,
        salary,
        ROW_NUMBER() OVER(PARTITION BY pd.department_id ORDER BY salary DESC) AS salary_rank
FROM parks_and_recreation.employee_salary sal
JOIN parks_and_recreation.parks_departments pd
	ON sal.dept_id = pd.department_id;

-- STUDY CASE 3
-- Who earns above the average for their gender?
SELECT *
FROM (
  SELECT 
    dem.employee_id,
    CONCAT_WS(' ', dem.first_name, dem.last_name) AS full_name,
    gender,
    salary,
    AVG(salary) OVER(PARTITION BY gender) AS average_salary_by_gender
  FROM parks_and_recreation.employee_demographics dem
  JOIN parks_and_recreation.employee_salary sal
    ON dem.employee_id = sal.employee_id
) AS sub
WHERE salary > average_salary_by_gender;

-- STUDY CASE 4
-- Check the Salary Gap within Department
SELECT 
  department_name,
  MAX(max_salary) AS max_salary,
  MIN(min_salary) AS min_salary,
  MAX(max_salary) - MIN(min_salary) AS salary_gap
FROM (
  SELECT pd.department_name,
         MAX(salary) OVER(PARTITION BY department_id) AS max_salary,
         MIN(salary) OVER(PARTITION BY department_id) AS min_salary
  FROM parks_and_recreation.employee_salary sal
  JOIN parks_and_recreation.parks_departments pd
    ON sal.dept_id = pd.department_id
) AS sub
GROUP BY department_name;
