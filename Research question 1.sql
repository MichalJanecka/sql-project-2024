-- Vytvoření zdrojové tabulky 
CREATE OR REPLACE TABLE t_michal_janecka_project_SQL_primary_final AS
SELECT 
	cpc.name AS food_category,
	cpc.code AS food_code,
	cpr.value AS price, 
	cpr.date_from, 
	cpr.date_to, 
	cpay.value AS average_wage, 
	cpay.payroll_year,
	cpib.name AS industry
FROM czechia_price AS cpr
JOIN czechia_payroll AS cpay 
	ON YEAR(cpr.date_from) = cpay.payroll_year
	AND cpay.value_type_code = 5958
JOIN czechia_price_category cpc 
	ON cpr.category_code = cpc.code 
JOIN czechia_payroll_industry_branch cpib 
	ON cpay.industry_branch_code = cpib.code;

-- Určení časového období 
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

-- Primární řešení: Porovnání průměrné hrubé mzdy v jednotlivých letech souhrnně napříč odvětvími
SELECT 
	payroll_year,
	round(avg(average_wage),0) AS average_wage,
RANK() OVER (ORDER BY average_wage) AS ranking
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL
GROUP BY payroll_year
ORDER BY average_wage;

-- Alternativní řešení: Porovnání průměrné hrubé mzdy v jednotlivých letech dle konkrétního odvětví
SELECT 
	industry, 
	payroll_year,
	round(avg(average_wage),0) AS average_wage,
	RANK() OVER (PARTITION BY industry ORDER BY average_wage) AS ranking
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL
GROUP BY industry, payroll_year
ORDER BY industry, payroll_year; 





