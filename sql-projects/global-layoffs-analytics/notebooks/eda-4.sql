-- 🔍 VISUALIZATION PART 4: Comprehensive Layoffs Analysis Queries --

-- 🔍 Annual Top 3 Industries by Layoffs
-- Shows the top 3 most impacted industries by layoffs for each year (2020–2023)
WITH IndustryLayoffsByYear AS (
    SELECT
        industry,
        YEAR(`date`) AS `year`,
        SUM(total_laid_off) AS total_layoffs_yearly
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY industry, `year`
),
RankedIndustryLayoffs AS (
    SELECT
        industry,
        `year`,
        total_layoffs_yearly,
        RANK() OVER(PARTITION BY `year` ORDER BY total_layoffs_yearly DESC) AS industry_rank
    FROM IndustryLayoffsByYear
)
SELECT
    industry,
    `year`,
    total_layoffs_yearly,
    industry_rank
FROM RankedIndustryLayoffs
WHERE industry_rank <= 3 -- Show only top 3 per year
ORDER BY `year` ASC, industry_rank ASC;

-- 💸 Layoffs by Company Funding Level
-- Categorizes companies based on how much funding they raised and analyzes their average & total layoffs
SELECT
    CASE
        WHEN funds_raised_millions < 100 THEN 'Under $100M'
        WHEN funds_raised_millions >= 100 AND funds_raised_millions < 500 THEN '$100M - $500M'
        WHEN funds_raised_millions >= 500 AND funds_raised_millions < 1000 THEN '$500M - $1B'
        WHEN funds_raised_millions >= 1000 THEN 'Over $1B'
        ELSE 'Unknown/No Funds Data'
    END AS funds_raised_category,
    ROUND(AVG(total_laid_off)) AS average_layoffs,
    SUM(total_laid_off) AS total_layoffs_in_category,
    COUNT(company) AS number_of_companies
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL AND total_laid_off IS NOT NULL
GROUP BY funds_raised_category
ORDER BY total_layoffs_in_category DESC;

-- 🌍 Yearly Global Layoff Progression (Cumulative View)
-- Calculates total and cumulative layoffs globally over time to observe growth trend
WITH CountryLayoffsByYear AS (
    SELECT
        YEAR(`date`) AS `year`,
        SUM(total_laid_off) AS total_layoffs_yearly
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY `year`
)
SELECT
    `year`,
    total_layoffs_yearly,
    SUM(total_layoffs_yearly) OVER(ORDER BY `year`) AS cumulative_layoffs_by_country
FROM CountryLayoffsByYear
ORDER BY  `year`;

-- 🗺️ Top 10 Layoff Hotspots by Company HQ Location
-- Highlights cities/locations with the highest total layoffs and number of companies affected
SELECT
    location AS headquarters_location,
    SUM(total_laid_off) AS total_layoffs_by_location,
    COUNT(DISTINCT company) AS num_companies_affected
FROM layoffs_staging2
GROUP BY location
ORDER BY total_layoffs_by_location DESC
LIMIT 10;

-- 📉 Average Layoffs Percentage by Industry
-- Calculates average percentage of workforce laid off per industry to identify sectors with the highest employee risk
SELECT
    industry,
    ROUND(AVG(percentage_laid_off) * 100) AS average_percentage_laid_off,
    COUNT(*) AS num_layoff_events
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL AND industry IS NOT NULL
GROUP BY industry
ORDER BY average_percentage_laid_off DESC
LIMIT 10;
