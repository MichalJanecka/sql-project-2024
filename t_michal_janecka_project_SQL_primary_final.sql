-- Table 1: creation
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
	

	
