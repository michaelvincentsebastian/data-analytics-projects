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

-- 📌 PROJECT VISUALIZATION 2: Trend & Time Analysis of Layoffs (2020–2023)

-- 1. 🔍 Total Layoffs by Year
-- Get the total layoffs per year to identify macro trends
SELECT 
    YEAR(`date`) AS `year`, 
    SUM(total_laid_off) AS total_layoffs_by_year
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY `year`
ORDER BY `year` ASC;

-- 2. 📅 Total Layoffs by Month-Year
-- Identify monthly fluctuations and peak periods
SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS `year_month`,
    SUM(total_laid_off) AS total_layoffs_monthly
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `year_month`
ORDER BY `year_month` ASC;

-- 3. 📈 Cumulative Monthly Layoffs
-- Show running total of layoffs across months to see the long-term trend
WITH MonthlyLayoffs AS (
    SELECT 
        DATE_FORMAT(`date`, '%Y-%m') AS `year_month`,
        SUM(total_laid_off) AS sum_layoffs_monthly
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY `year_month`
)
SELECT 
    year_month,
    sum_layoffs_monthly,
    SUM(sum_layoffs_monthly) OVER(ORDER BY year_month) AS cumulative_layoffs_total
FROM MonthlyLayoffs;

-- 4. 📊 3-Month Rolling Sum & Average of Layoffs
-- Detect short-term trends and smooth out seasonal volatility
WITH MonthlyLayoffs AS (
    SELECT 
        DATE_FORMAT(`date`, '%Y-%m') AS `year_month`,
        SUM(total_laid_off) AS sum_layoffs_monthly
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY `year_month`
)
SELECT 
    year_month,
    sum_layoffs_monthly,
    AVG(sum_layoffs_monthly) OVER(ORDER BY year_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_3_months_layoffs,
    SUM(sum_layoffs_monthly) OVER(ORDER BY year_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_sum_3_months_layoffs
FROM MonthlyLayoffs;

-- 🔍 PROJECT VISUALIZATION 3: Most Affected Industries by Total Layoffs in Industry --

-- Identifying which economic sectors took the hardest hit
WITH most_layoffs_industry AS (
  SELECT 
    industry, 
    SUM(total_laid_off) AS total_layoffs_by_industry
  FROM layoffs_staging2
  GROUP BY industry
  ORDER BY total_layoffs_by_industry DESC
  LIMIT 10
)
SELECT *,
  DENSE_RANK() OVER (ORDER BY total_layoffs_by_industry DESC) AS layoffs_rank
FROM most_layoffs_industry;


-- 🌍 Countries with the Most Layoffs: Geographic Distribution
-- Identifying the countries hit hardest by layoffs
WITH country_with_most_layoffs AS (
  SELECT 
    country, 
    SUM(total_laid_off) AS total_layoffs_by_industry
  FROM layoffs_staging2
  GROUP BY country
  ORDER BY total_layoffs_by_industry DESC
  LIMIT 10
)
SELECT *,
  DENSE_RANK() OVER (ORDER BY total_layoffs_by_industry DESC) AS layoffs_rank
FROM country_with_most_layoffs;


-- 🧬 Company Stage with the Most Layoffs: Startup vs Established
-- Understanding whether layoffs are heavier in early-stage or mature companies
WITH stage_with_most_layoffs AS (
  SELECT 
    stage, 
    SUM(total_laid_off) AS total_layoffs_by_industry
  FROM layoffs_staging2
  GROUP BY stage
  ORDER BY total_layoffs_by_industry DESC
  LIMIT 10
)
SELECT *,
  DENSE_RANK() OVER (ORDER BY total_layoffs_by_industry DESC) AS layoffs_rank
FROM stage_with_most_layoffs;


-- 🏆 Top 5 Companies with Most Layoffs Each Year
-- Year-by-year corporate ranking to uncover consistent or one-time major layoffs
WITH company_yearly_layoffs (company, `year`, layoffs_total) AS (
  SELECT
    company,
    DATE_FORMAT(`date`, '%Y') AS `year`,
    SUM(total_laid_off) AS total_layoffs
  FROM layoffs_staging2
  WHERE `date` IS NOT NULL
  GROUP BY company, DATE_FORMAT(`date`, '%Y`)
),
layoffs_ranking_yearly AS (
  SELECT
    company,
    `year`,
    layoffs_total,
    DENSE_RANK() OVER (PARTITION BY `year` ORDER BY layoffs_total DESC) AS layoffs_ranking
  FROM company_yearly_layoffs
)
SELECT
  company,
  `year`,
  layoffs_total,
  layoffs_ranking
FROM layoffs_ranking_yearly
WHERE layoffs_ranking <= 5
ORDER BY `year` ASC, layoffs_ranking ASC;
