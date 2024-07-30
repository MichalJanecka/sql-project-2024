-- Kódy pro položky chléb a mléko
SELECT 
	food_category,
	food_code
FROM t_michal_janecka_project_SQL_primary_final;

-- Výpočet průměrné mzdy pro roky 2006 a 2018
SELECT 
	payroll_year,
	round(avg(average_wage),0) AS average_wage
FROM t_michal_janecka_project_SQL_primary_final
WHERE industry IS NOT NULL AND payroll_year IN ('2006', '2018') 
GROUP BY payroll_year; 

-- Průměrná cena chleba za rok 2006 a 2018
SELECT 
	food_code,
	YEAR(date_from) AS selected_year,
	round(avg(price), 2) AS avg_price_bread
FROM t_michal_janecka_project_SQL_primary_final
WHERE food_code = 111301 AND YEAR(date_from) IN ('2006', '2018')
GROUP BY food_code, YEAR(date_from);

-- Průměrná cena mléka za rok 2006 a 2018
SELECT 
	food_code,
	YEAR(date_from) AS selected_year,
	round(avg(price), 2) AS avg_price_milk
FROM t_michal_janecka_project_SQL_primary_final
WHERE food_code = 114201 AND YEAR(date_from) IN ('2006', '2018')
GROUP BY food_code, YEAR(date_from);

-- Výsledné množství pro rok 2006
-- CHLÉB
SELECT 20754 DIV 16.12;
-- MLÉKO
SELECT 20754 DIV 14.44;

-- Výsledné množství pro rok 2018
-- CHLÉB
SELECT 32536 DIV 24.24;
-- MLÉKO
SELECT 32536 DIV 19.82;


