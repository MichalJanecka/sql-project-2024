-- Table 1: creation
CREATE TEMPORARY TABLE temp_czechia_price AS
SELECT *
FROM czechia_price
WHERE region_code IS NULL;

CREATE TEMPORARY TABLE temp_czechia_payroll AS
SELECT *
FROM czechia_payroll
WHERE value_type_code = '5958';

CREATE OR REPLACE TABLE t_Michal_Janecka_project_SQL_primary_final AS
SELECT
    cpc.name AS food_category,
	cpc.code AS food_code,
	cpr.value AS price, 
	cpr.date_from, 
	cpr.date_to, 
	cpay.value AS average_wage, 
	cpay.payroll_year,
	cpib.name AS industry
FROM temp_czechia_price AS cpr
JOIN temp_czechia_payroll AS cpay 
    ON YEAR(cpr.date_from) = cpay.payroll_year
JOIN czechia_price_category AS cpc 
    ON cpr.category_code = cpc.code
JOIN czechia_payroll_industry_branch AS cpib 
    ON cpay.industry_branch_code = cpib.code;

   

	
