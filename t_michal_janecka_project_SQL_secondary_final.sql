-- Table 2: creation
CREATE OR REPLACE TABLE t_michal_janecka_project_SQL_secondary_final AS
	SELECT *
	FROM v_michal_yoy_price_growth vmypg 
	JOIN v_michal_yoy_wage_growth vmywg 
	ON vmypg.selected_year = vmywg.payroll_year
	JOIN economies
	ON vmywg.payroll_year = economies.`year`;