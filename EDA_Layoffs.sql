-- ───────────────────────────────────────────────────────────────
--  1. DATA PREVIEW AND BASIC INSPECTION
-- ───────────────────────────────────────────────────────────────

-- Preview the full dataset (limit recommended in actual analysis)
SELECT * FROM layoffs_staging2;

-- Check unique funding stages (helps with categorization)
SELECT DISTINCT stage FROM layoffs_staging2
WHERE stage IS NOT NULL;

-- Max, min, and average number of layoffs per record
SELECT MAX(total_laid_off), MIN(total_laid_off), AVG(total_laid_off)
FROM layoffs_staging2;

-- ───────────────────────────────────────────────────────────────
--  2. HIGH-LEVEL AGGREGATES: INDUSTRY, COUNTRY, STAGE
-- ───────────────────────────────────────────────────────────────

-- Total layoffs by industry
SELECT industry, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Total layoffs by country
SELECT country, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY country
ORDER BY Total_Laid_Off DESC
limit 7;

-- Total layoffs by funding stage
SELECT stage, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY stage
ORDER BY Total_Laid_Off DESC;

-- ───────────────────────────────────────────────────────────────
--  3. TIME SERIES ANALYSIS: MONTHLY, YEARLY, CUMULATIVE
-- ───────────────────────────────────────────────────────────────

-- Monthly layoff totals (to observe seasonality or spikes)
SELECT MONTHNAME(`date`) AS `Month`, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY `Month`
ORDER BY Total_Laid_Off DESC;


-- Yearly layoff totals
SELECT YEAR(`date`) AS Year, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY Total_Laid_Off DESC;

-- Monthly rolling cumulative total layoffs
WITH rolling_total AS (
  SELECT SUBSTRING(`date`, 1, 7) AS Layoff_Date, SUM(total_laid_off) AS Total
  FROM layoffs_staging2
  WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
  GROUP BY SUBSTRING(`date`, 1, 7)
  ORDER BY Layoff_Date
)
SELECT *, SUM(Total) OVER (ORDER BY Layoff_Date) AS Rolling_Total
FROM rolling_total;

-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. INDUSTRY-LEVEL TRENDS AND DISPARITIES
-- ═══════════════════════════════════════════════════════════════════════════════

-- These queries explore industry-wise layoff trends over years,
-- and identify outliers or spikes in layoffs by comparing across years.
-- For each industry, we look at yearly totals and then deep-dive into the year
-- with the largest layoff to explore top companies, percentage laid off,
-- and funding raised to understand the context.

-- Yearly trend for 'Consumer' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Consumer'
group by year(`date`)
order by 1 asc;

-- Deep dive into 2022 for 'Consumer' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Consumer'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Retail' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Retail'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Retail' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Retail'
and year(`date`) = 2022
order by 3 desc, 5 desc;


--  Yearly trend for 'Transportation' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Transportation'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Transportation' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Transportation'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Finance' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Finance'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Finance' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Finance'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Healthcare' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Healthcare'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Healthcare' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Healthcare'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Food' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Food'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Food' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Food'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Real Estate' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Real Estate'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2022 for 'Real Estate' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Real Estate'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Travel' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Travel'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2020 for 'Travel' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Travel'
and year(`date`) = 2020
order by 3 desc, 5 desc;

--  Yearly trend for 'Education' industry
select industry, year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Education'
group by industry, year(`date`)
order by 2 asc;

--  Deep dive into 2022 for 'Education' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Education'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Hardware' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Hardware'
group by year(`date`)
order by 1 asc;

--  Deep dive into 2023 for 'Hardware' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Hardware'
and year(`date`) = 2023
order by 3 desc, 5 desc;

--  Yearly trend for 'Sales' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Sales'
group by year(`date`)
order by 1 asc;


--  Deep dive into 2023 for 'Sales' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Sales'
and year(`date`) = 2023
order by 3 desc, 5 desc;


--  Yearly trend for 'Crypto' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Crypto'
group by year(`date`)
order by 1 asc;

-- Deep dive into 2022 for 'Crypto' industry
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Crypto'
and year(`date`) = 2022
order by 3 desc, 5 desc;

--  Yearly trend for 'Marketing' industry
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Marketing'
group by year(`date`)
order by 1 asc;

--  Yearly trend for the other industries that haven't been mentioned
select year(`date`),sum(total_laid_off) as Total_Layoffs
from layoffs_staging2
where industry = 'Other'
and year(`date`) is not null
group by year(`date`)
order by 1 asc;

-- Deep dive into 2023 those industries
select company, industry, total_laid_off, percentage_laid_off, funds_raised_millions
from layoffs_staging2
where industry = 'Other'
and year(`date`) = 2023
order by 3 desc, 5 desc;


-- ───────────────────────────────────────────────────────────────
--  5. COMPANY-LEVEL ANALYSIS
-- ───────────────────────────────────────────────────────────────

-- Top 10 companies with the highest total layoffs
SELECT company, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY company
ORDER BY Total_Laid_Off DESC
LIMIT 10;

-- Companies with multiple layoffs (>=2) — repeated rounds of cuts
SELECT company, country, COUNT(*) AS Number_of_Layoffs, SUM(total_laid_off) AS Total
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY company, country
HAVING Number_of_Layoffs > 1
ORDER BY 3 DESC;


-- Top 5 companies with highest layoffs per stage
WITH stage_and_company_laid_off AS (
  SELECT stage, company, SUM(total_laid_off) AS total_laid_offs
  FROM layoffs_staging2
  WHERE stage IS NOT NULL
  GROUP BY stage, company
), ranked_layoffs AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY stage ORDER BY total_laid_offs DESC) AS Rankings
  FROM stage_and_company_laid_off
)
SELECT * FROM ranked_layoffs
WHERE Rankings <= 5;

-- ───────────────────────────────────────────────────────────────
--  6. COUNTRY / INDUSTRY DEEP DIVES
-- ───────────────────────────────────────────────────────────────

-- Top 5 companies by total layoffs in each country
WITH country_wise_total AS (
  SELECT country, company, SUM(total_laid_off) AS total
  FROM layoffs_staging2
  GROUP BY country, company
  HAVING total IS NOT NULL
), ranking AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY country ORDER BY total DESC) AS `Rank`
  FROM country_wise_total
)
SELECT * FROM ranking
WHERE `Rank` <= 5;

-- Top 5 companies by total layoffs in each industry
WITH industry_wise AS (
  SELECT industry, company, SUM(total_laid_off) AS total
  FROM layoffs_staging2
  WHERE industry IS NOT NULL
  GROUP BY industry, company
), ranking AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY industry ORDER BY total DESC) AS `Rank`
  FROM industry_wise
)
SELECT * FROM ranking
WHERE `Rank` <= 5;

-- ───────────────────────────────────────────────────────────────
--  7. EXTREME CASES: FULL LAYOFFS, COLLAPSE, BANKRUPTCY SIGNALS
-- ───────────────────────────────────────────────────────────────

-- Companies that laid off 100% of their staff
SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;  

-- Companies that laid off 100% and raised funds — possible sudden collapse
SELECT company, industry, stage, country, COUNT(*) AS Layoff_Count,
       SUM(funds_raised_millions) AS Total_Funds_Raised
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY company, industry, stage, country
HAVING SUM(funds_raised_millions) IS NOT NULL
ORDER BY Total_Funds_Raised DESC;

-- Layoff count per stage where companies fully laid off (shutdown pattern)
SELECT stage, COUNT(*) AS Layoff_Count
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY stage
ORDER BY Layoff_Count DESC;

-- Industry-wise count of collapsed startups (100% layoffs in early stages)
SELECT industry, COUNT(DISTINCT company) AS Total_Bankruptcies
FROM (
  SELECT * FROM layoffs_staging2
  WHERE stage IN ('Seed', 'Series A', 'Series B') AND percentage_laid_off = 1
) AS Startups
GROUP BY industry
ORDER BY Total_Bankruptcies DESC;

-- ───────────────────────────────────────────────────────────────
--  8. COMPANY SIZE CLASSIFICATION: STARTUP vs INTERMEDIATE vs MNC
-- ───────────────────────────────────────────────────────────────

-- Classify companies by funding stage and show which ones laid off 100%
SELECT company_size_bin, COUNT(DISTINCT company) AS Company_Count
FROM (
  SELECT *,
    CASE
      WHEN stage IN ('Seed', 'Series A', 'Series B') THEN 'Startup'
      WHEN stage IN ('Series C', 'Series D', 'Series E', 'Series F') THEN 'Intermediate'
      WHEN stage IN ('Series G', 'Series H', 'Series I', 'Series J', 'Post-IPO', 'Private Equity', 'Acquired', 'Subsidiary') THEN 'MNC'
      ELSE 'Unknown'
    END AS company_size_bin
  FROM layoffs_staging2
  where percentage_laid_off = 1
) AS binned
GROUP BY company_size_bin
ORDER BY Company_Count DESC;

-- ───────────────────────────────────────────────────────────────
--  9. INDUSTRY-LEVEL YEARLY TRENDS
-- ───────────────────────────────────────────────────────────────

-- Top 5 most affected industries by layoffs each year
WITH yearly_layoffs_by_industry AS (
  SELECT YEAR(`date`) AS `Year`, industry, SUM(total_laid_off) AS Total_Laid_Off
  FROM layoffs_staging2
  GROUP BY YEAR(`date`), industry
), ranking_on_yearly_industry_layoffs AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY `Year` ORDER BY Total_Laid_Off DESC) AS `Rank`
  FROM yearly_layoffs_by_industry
  WHERE Total_Laid_Off IS NOT NULL AND `Year` IS NOT NULL
)
SELECT * FROM ranking_on_yearly_industry_layoffs
WHERE `Rank` <= 5;
