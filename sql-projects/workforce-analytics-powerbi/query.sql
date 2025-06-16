-- 📊 WORKFORCE INTELLIGENCE SQL QUERIES
-- Author: Michael Vincent Sebastian Handojo
-- Purpose: This SQL script is part of a dashboard project to analyze workforce trends using HR data.
-- Focus areas: salary fairness, data quality, gender distribution, departmental insights, and strategic roles.

-- 🔍 1. Average Salary by Occupation
-- Objective: Explore whether prestigious job titles always correlate with higher salaries.
-- Insight: This helps detect underpaid roles that may require HR attention.
SELECT 
  es.occupation,
  COUNT(*) AS total_employee,
  ROUND(AVG(es.salary), 0) AS avg_salary
FROM employee_salary es
GROUP BY es.occupation
ORDER BY avg_salary DESC;

-- ⚠️ 2. Data Quality Check – Missing Department
-- Objective: Identify employees without department info, which may indicate data entry issues or system gaps.
SELECT * FROM employee_salary
WHERE dept_id IS NULL;

-- 👥 3. Gender Distribution by Department
-- Objective: Understand the gender composition across departments for diversity assessment.
-- Insight: Useful for promoting gender balance in the workplace.
SELECT 
  d.department_name,
  ed.gender,
  COUNT(*) AS jumlah
FROM employee_salary es
JOIN employee_demographics ed ON es.employee_id = ed.employee_id
JOIN parks_departments d ON es.dept_id = d.department_id
GROUP BY d.department_name, ed.gender;

-- 🧓 4. Average Age and Salary by Department
-- Objective: Assess both experience (age) and compensation levels across departments.
-- Insight: Helps in succession planning and benchmarking salary fairness by age group.
SELECT 
  d.department_name,
  ROUND(AVG(ed.age), 0) AS rata_usia,
  ROUND(AVG(es.salary), 0) AS rata_gaji
FROM employee_salary es
JOIN employee_demographics ed ON es.employee_id = ed.employee_id
JOIN parks_departments d ON es.dept_id = d.department_id
GROUP BY d.department_name;

-- 🏆 5. Top 3 Highest-Paid Employees
-- Objective: Identify the highest earners in the organization using SQL window functions.
-- Technique: Use RANK() to support scalability in case of salary ties.
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

-- 🎯 6. Strategic Role Demographics: Director, Manager, Planner
-- Objective: Analyze demographics (gender & age) of key leadership and planning positions.
-- Insight: Supports workforce planning, DEI efforts, and leadership succession analysis.
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
