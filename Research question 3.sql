-- Average price of food categories in a given year (2006-2018)
SELECT
	food_code,
	YEAR(date_from) AS selected_year,
	ROUND(AVG(price), 1) AS avg_price
FROM t_michal_janecka_project_SQL_primary_final
GROUP BY food_code, YEAR(date_from)
ORDER BY food_code, selected_year;

-- View for subsequent calculation of year-on-year comparison
CREATE OR REPLACE VIEW v_michal_yoy_growth AS
SELECT
	food_code,
	YEAR(date_from) AS selected_year,
	ROUND(AVG(price), 1) AS avg_price
FROM t_michal_janecka_project_SQL_primary_final 
GROUP BY food_code, YEAR(date_from)
ORDER BY food_code, selected_year;

-- Primary solution: Overall year-on-year comparison (2006-2018)
WITH YearlyChanges AS (
    SELECT 
        food_code,
        selected_year,
        avg_price,
        (avg_price - LAG(avg_price) OVER (PARTITION BY food_code ORDER BY selected_year)) / LAG(avg_price) OVER (PARTITION BY food_code ORDER BY selected_year) * 100 AS YOY_Perc_Difference
    FROM v_michal_yoy_growth
)
SELECT 
    food_code,
    ROUND(AVG(YOY_Perc_Difference), 2) AS Avg_YOY_Perc_Difference
FROM YearlyChanges
GROUP BY food_code
ORDER BY Avg_YOY_Perc_Difference;

-- Secondary (alternative) solution: Year-on-year comparison of prices within the individual years
SELECT 
	food_code,
	selected_year,
	avg_price,
	avg_price - LAG(avg_price) OVER (PARTITION BY food_code ORDER BY food_code, selected_year) AS YOY_Total_Difference,
	ROUND((avg_price - LAG(avg_price, 1) OVER (PARTITION BY food_code ORDER BY food_code, selected_year)) / LAG(avg_price, 1) OVER (PARTITION BY food_code ORDER BY food_code, selected_year), 4) * 100 AS YOY_Perc_Difference
FROM v_michal_yoy_growth
ORDER BY YOY_Perc_Difference;
