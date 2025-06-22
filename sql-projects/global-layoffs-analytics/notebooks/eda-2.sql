-- 📌 VISUALIZATION PART 2: Trend & Time Analysis of Layoffs (2020–2023)

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
