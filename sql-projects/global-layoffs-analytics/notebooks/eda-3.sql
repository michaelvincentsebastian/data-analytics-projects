-- 🔍 VISUALIZATION PART 3: Most Affected Industries by Total Layoffs in Industry --

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