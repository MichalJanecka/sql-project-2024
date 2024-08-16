-- Codes for food categories (bread and milk)
SELECT 
	DISTINCT food_category,
	food_code
FROM t_michal_janecka_project_SQL_primary_final;

-- Average gross wage in 2006 and 2018
SELECT 
	payroll_year,
	ROUND(AVG(average_wage),0) AS average_wage
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL AND payroll_year IN ('2006', '2018') 
GROUP BY payroll_year; 

-- Average price of bread in 2006 and 2018
SELECT 
	food_code,
	YEAR(date_from) AS selected_year,
	ROUND(AVG(price), 2) AS avg_price_bread
FROM t_michal_janecka_project_SQL_primary_final
WHERE food_code = 111301 AND YEAR(date_from) IN ('2006', '2018')
GROUP BY food_code, YEAR(date_from);

-- Average price of milk in 2006 and 2018
SELECT 
	food_code,
	YEAR(date_from) AS selected_year,
	ROUND(AVG(price), 2) AS avg_price_milk
FROM t_michal_janecka_project_SQL_primary_final
WHERE food_code = 114201 AND YEAR(date_from) IN ('2006', '2018')
GROUP BY food_code, YEAR(date_from);

-- Overall quantity (2006)
-- BREAD
SELECT 20754 DIV 16.12;
-- MILK
SELECT 20754 DIV 14.44;

-- Overall quantity (2018)
-- BREAD 
SELECT 32536 DIV 24.24;
-- MILK
SELECT 32536 DIV 19.82;


