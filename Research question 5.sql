-- Table 2: creation
CREATE OR REPLACE TABLE t_michal_janecka_project_SQL_secondary_final AS
	SELECT *
	FROM v_michal_yoy_price_growth vmypg 
	JOIN v_michal_yoy_wage_growth vmywg 
	ON vmypg.selected_year = vmywg.payroll_year
	JOIN economies
	ON vmywg.payroll_year = economies.`year`;

-- Correlation of GDP growth, average gross wages and food prices
SELECT 
	country,
	selected_year,
	average_price,
	ROUND((average_price - LAG(average_price, 1) OVER (ORDER BY selected_year)) / LAG(average_price, 1) OVER (ORDER BY selected_year), 4) * 100 AS YOY_groceries_perc_change,
	average_wage,
	ROUND((average_wage - LAG(average_wage, 1) OVER (ORDER BY payroll_year)) / LAG(average_wage, 1) OVER (ORDER BY payroll_year), 4) * 100 AS YOY_wage_perc_change,
	GDP,
	ROUND((GDP - LAG(GDP, 1) OVER (ORDER BY `year`)) / LAG(GDP, 1) OVER (ORDER BY `year`), 4) * 100 AS YOY_GDP_perc_change
FROM t_michal_janecka_project_sql_secondary_final tmjpssf
WHERE country = 'Czech Republic' AND `year` BETWEEN 2006 AND 2018
ORDER BY YOY_GDP_perc_change DESC;



	




