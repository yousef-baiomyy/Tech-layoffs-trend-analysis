-- =========================================================
-- STEP 1: Verify data was imported successfully (12,000 rows expected)
-- =========================================================
SELECT COUNT(*) FROM tech_layoffs_cleaned;


-- Quick visual check: preview first 5 rows to confirm columns look correct
SELECT * FROM tech_layoffs_cleaned LIMIT 5;


-- Data integrity check: make sure no record_id is missing (should return 0)
SELECT COUNT(*) - COUNT(record_id) AS null_ids FROM tech_layoffs_cleaned;


-- =========================================================
-- ANALYSIS 1: Total layoffs by industry
-- Purpose: Identify which industries were hit hardest by layoffs
-- =========================================================
SELECT industry, 
       SUM(layoffs_count) AS total_layoffs,
       ROUND(AVG(layoff_percentage), 2) AS avg_percentage,
       COUNT(*) AS records
FROM tech_layoffs_cleaned
GROUP BY industry
ORDER BY total_layoffs DESC;


-- =========================================================
-- ANALYSIS 2: Total layoffs by country
-- Purpose: Compare layoff impact and open job availability across countries
-- =========================================================
SELECT country, 
       SUM(layoffs_count) AS total_layoffs,
       SUM(open_roles) AS total_open_roles
FROM tech_layoffs_cleaned
GROUP BY country
ORDER BY total_layoffs DESC;


-- =========================================================
-- ANALYSIS 3: Layoffs breakdown by reason
-- Purpose: Understand the main drivers behind layoffs (AI automation, 
-- cost cutting, restructuring, etc.) to inform workforce planning
-- =========================================================
SELECT reason_for_layoffs,
       COUNT(*) AS num_cases,
       SUM(layoffs_count) AS total_layoffs,
       ROUND(AVG(layoff_percentage), 2) AS avg_percentage
FROM tech_layoffs_cleaned
GROUP BY reason_for_layoffs
ORDER BY total_layoffs DESC;


-- =========================================================
-- ANALYSIS 4: Layoffs by company size
-- Purpose: Check whether larger companies (Big Tech/Enterprise) show 
-- higher average layoffs than smaller ones (Startup/Mid-size)
-- Note: Earlier exploration in Python showed these values are surprisingly 
-- close across company sizes, which is unusual for real-world layoff data
-- =========================================================
SELECT company_size,
       COUNT(*) AS num_records,
       AVG(layoffs_count) AS avg_layoffs,
       MAX(layoffs_count) AS max_layoffs
FROM tech_layoffs_cleaned
GROUP BY company_size
ORDER BY avg_layoffs DESC;


-- =========================================================
-- ANALYSIS 5: Top 10 month/year combinations with highest layoffs
-- Purpose: Spot any time-based spikes or seasonal patterns in layoffs
-- =========================================================
SELECT year, month, SUM(layoffs_count) AS total_layoffs
FROM tech_layoffs_cleaned
GROUP BY year, month
ORDER BY total_layoffs DESC
LIMIT 10;



-- =========================================================
-- ANALYSIS 6: Month-over-month change in layoffs
-- Purpose: Track whether layoffs are increasing or decreasing 
-- compared to the previous month, to spot trends over time
-- =========================================================
SELECT 
    year,
    month,
    SUM(layoffs_count) AS total_layoffs,
    LAG(SUM(layoffs_count)) OVER (ORDER BY year, 
        FIELD(month,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
    ) AS previous_month_layoffs
FROM tech_layoffs_cleaned
GROUP BY year, month
ORDER BY year, 
    FIELD(month,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
    
    
    

-- =========================================================
-- ANALYSIS 7: Percentage change in layoffs month-over-month
-- Purpose: Quantify how much layoffs increased/decreased vs previous month
-- =========================================================
SELECT *,
    ROUND(
        (total_layoffs - previous_month_layoffs) / previous_month_layoffs * 100, 2
    ) AS pct_change
FROM (
    SELECT 
        year,
        month,
        SUM(layoffs_count) AS total_layoffs,
        LAG(SUM(layoffs_count)) OVER (ORDER BY year, 
            FIELD(month,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
        ) AS previous_month_layoffs
    FROM tech_layoffs_cleaned
    GROUP BY year, month
) AS monthly_data
ORDER BY year, FIELD(month,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');




-- =========================================================
-- ANALYSIS 8: Rank companies by total layoffs
-- Purpose: Identify the top companies with highest layoff numbers
-- =========================================================
SELECT 
    company_name,
    SUM(layoffs_count) AS total_layoffs,
    RANK() OVER (ORDER BY SUM(layoffs_count) DESC) AS layoff_rank
FROM tech_layoffs_cleaned
GROUP BY company_name
ORDER BY layoff_rank
LIMIT 15;



-- =========================================================
-- VIEW: Monthly summary for Power BI dashboard
-- Purpose: Pre-aggregated view combining key metrics by month, 
-- ready to be connected directly to Power BI
-- =========================================================
CREATE VIEW monthly_summary AS
SELECT 
    year,
    month,
    industry,
    country,
    company_size,
    SUM(layoffs_count) AS total_layoffs,
    ROUND(AVG(layoff_percentage), 2) AS avg_layoff_pct,
    SUM(open_roles) AS total_open_roles,
    ROUND(AVG(employee_sentiment), 2) AS avg_sentiment
FROM tech_layoffs_cleaned
GROUP BY year, month, industry, country, company_size;


