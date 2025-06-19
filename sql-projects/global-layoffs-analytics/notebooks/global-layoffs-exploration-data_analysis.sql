-- 🔍 PROJECT VISUALIZATION 1: Workforce Intelligence Dashboard --

-- Q1: Do prestigious job titles always equate to higher salaries?
-- This query reveals average salary and total headcount per occupation, helping identify overpaid or underpaid roles.
SELECT 
  es.occupation,
  COUNT(*) AS total_employee,
  ROUND(AVG(es.salary), 0) AS avg_salary
FROM employee_salary es
GROUP BY es.occupation
ORDER BY avg_salary DESC;


-- Q2: Are there any records missing department data?
-- It's crucial to ensure no NULL values exist in dept_id for accurate department-based analysis.
SELECT * 
FROM employee_salary
WHERE dept_id IS NULL;


-- Q3: What is the gender distribution across departments?
-- This query provides insights into gender representation within each department.
SELECT 
  d.department_name,
  ed.gender,
  COUNT(*) AS total_count
FROM employee_salary es
JOIN employee_demographics ed ON es.employee_id = ed.employee_id
JOIN parks_departments d ON es.dept_id = d.department_id
GROUP BY d.department_name, ed.gender;


-- Q4: What are the average age and salary per department?
-- Useful for understanding workforce demographics and compensation trends at the department level.
SELECT 
  d.department_name,
  ROUND(AVG(ed.age), 0) AS avg_age,
  ROUND(AVG(es.salary), 0) AS avg_salary
FROM employee_salary es
JOIN employee_demographics ed ON es.employee_id = ed.employee_id
JOIN parks_departments d ON es.dept_id = d.department_id
GROUP BY d.department_name;


-- Q5: Who are the top 3 highest-paid employees?
-- Leverages window function RANK() to find the top earners in the organization.
WITH salary_rank AS (
  SELECT 
    es.employee_id,
    es.first_name,
    es.last_name,
    es.salary,
    RANK() OVER (ORDER BY es.salary DESC) AS ranking
  FROM employee_salary es
)
SELECT *
FROM salary_rank
WHERE ranking <= 3;


-- Q6: What are the age and gender characteristics of leadership roles?
-- Focuses on strategic roles (Director, Manager, Planner) to analyze age diversity and gender distribution.
WITH strategic_roles AS (
  SELECT 
    s.occupation, 
    d.age,
    d.gender
  FROM employee_salary s
  JOIN employee_demographics d ON s.employee_id = d.employee_id
  WHERE s.occupation LIKE '%Director%'
     OR s.occupation LIKE '%Manager%'
     OR s.occupation LIKE '%Planner%'
)
SELECT 
  occupation,
  gender,
  COUNT(*) AS total_employee,
  ROUND(AVG(age), 0) AS avg_age,
  MAX(age) AS oldest,
  MIN(age) AS youngest
FROM strategic_roles
GROUP BY occupation, gender;
