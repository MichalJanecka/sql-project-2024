-- Průměrná cena potravin v letech 2006-2018
CREATE OR REPLACE VIEW v_michal_yoy_price_growth AS 
SELECT
	YEAR(date_from) AS selected_year,
	round(avg(price), 1) AS average_price
FROM t_michal_janecka_project_SQL_primary_final
GROUP BY YEAR(date_from);

-- Průměrná výše mzdy v letech 2006-2018
CREATE OR REPLACE VIEW v_michal_yoy_wage_growth AS 
SELECT 
	payroll_year,
	round(avg(average_wage),0) AS average_wage
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL AND payroll_year BETWEEN 2006 AND 2018
GROUP BY payroll_year
ORDER BY average_wage; 

-- Meziroční srovnání (%) růstu cen potravin a mezd
SELECT 
	vmypg.selected_year,
	vmypg.average_price,
	vmywg.payroll_year,
	vmywg.average_wage,
	ROUND((average_price - LAG(average_price, 1) OVER (ORDER BY selected_year)) / LAG(average_price, 1) OVER (ORDER BY selected_year), 4) * 100 AS YOY_groceries_perc_change,
	ROUND((average_wage - LAG(average_wage, 1) OVER (ORDER BY payroll_year)) / LAG(average_wage, 1) OVER (ORDER BY payroll_year), 4) * 100 AS YOY_wage_perc_change
FROM v_michal_yoy_price_growth vmypg 
JOIN v_michal_yoy_wage_growth vmywg 
	ON vmypg.selected_year = vmywg.payroll_year;



