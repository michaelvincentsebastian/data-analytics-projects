-- 🧹 DATA CLEANING: WORLD LAYOFFS (2020–2023)
-- Objective: Prepare and clean tech layoff dataset to be analysis-ready by removing duplicates, standardizing entries, handling NULLs, and finalizing structure.

-- 1️⃣ REMOVE DUPLICATES
-- Step 1: Create a staging table as a clone of the original "layoffs" table
CREATE TABLE layoffs_staging LIKE layoffs;

-- Step 2: Populate staging table with raw data
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- Step 3: Identify duplicates using ROW_NUMBER across all fields
WITH duplicate_cte AS (
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
	FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Step 4: Create a second staging table with an additional column `row_num` to help with deletion
CREATE TABLE layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
);

-- Step 5: Insert data with ROW_NUMBER logic into second staging table
INSERT INTO layoffs_staging2
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	) AS row_num
FROM layoffs_staging;

-- Step 6: Remove duplicate rows
DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- ✅ Duplicates removed

-- 2️⃣ STANDARDIZE THE DATA
-- Step 1: Trim white spaces from `company` names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Step 2: Normalize inconsistent spellings in the `industry` column
-- Example: Convert all variations like 'Crypto Currency' to simply 'Crypto'
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE '%Crypto%';

-- Step 3: Remove special characters (e.g., trailing dots) in `country` names
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- Step 4: Convert `date` column from TEXT to DATE format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Step 5: Alter the column type of `date` from TEXT to DATE
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- ✅ Data standardized

-- 3️⃣ HANDLE NULL OR BLANK VALUES
-- Step 1: Convert blank strings to NULL (especially in `industry`)
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Step 2: Fill missing `industry` using duplicate entries with the same `company` and `location`
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Note: Other NULLs such as `total_laid_off`, `percentage_laid_off`, or `funds_raised_millions` remain untouched if there's no reliable source to infer values.

-- ✅ NULLs handled where possible

-- 4️⃣ REMOVE UNNECESSARY ROWS OR COLUMNS
-- Step 1: Delete rows with NULL in both `total_laid_off` and `percentage_laid_off` — assumed invalid
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Step 2: Drop the helper column `row_num` as it's no longer needed
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- ✅ Dataset is now cleaned and ready for EDA

-- 🔍 Final Check: View cleaned dataset
SELECT * FROM layoffs_staging2;
