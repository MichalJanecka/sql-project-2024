-- Determination of time period
SELECT 
	DISTINCT payroll_year 
FROM t_michal_janecka_project_SQL_primary_final
ORDER BY payroll_year ASC
LIMIT 1;

SELECT 
	DISTINCT payroll_year 
FROM t_michal_janecka_project_SQL_primary_final
ORDER BY payroll_year DESC
LIMIT 1;

-- Primary solution: Comparison of average gross wages in each year and aggregated across sectors
SELECT 
	payroll_year,
	ROUND(AVG(average_wage),0) AS average_wage,
RANK() OVER (ORDER BY average_wage) AS ranking
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL
GROUP BY payroll_year
ORDER BY average_wage;

-- Secondary (alternative) solution: Comparison of average gross wages in each year by specific sector
SELECT 
	industry, 
	payroll_year,
	ROUND(AVG(average_wage),0) AS average_wage,
	RANK() OVER (PARTITION BY industry ORDER BY average_wage) AS ranking
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL
GROUP BY industry, payroll_year
ORDER BY industry, payroll_year; 





