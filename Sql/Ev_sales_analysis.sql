-- Total market size
SELECT SUM(ev_sales_quantity) AS total_ev_sales
FROM ev_sales;
-- Market size Calculation @2024 Approx ~3593811

-- Yearly Sales
SELECT year, SUM(ev_sales_quantity) AS yearly_sales
FROM ev_sales
GROUP BY year
ORDER BY yearly_sales DESC
--With each year sales are increasing

-- Year over year growth 
Select 
	year,
    SUM(ev_sales_quantity) AS yearly_sales,
    LAG(SUM(ev_sales_quantity)) OVER (ORDER BY year) AS prev_year,
    SUM(ev_sales_quantity)
      - LAG(SUM(ev_sales_quantity)) OVER (ORDER BY year) AS growth
FROM ev_sales
GROUP BY year
ORDER BY year;
-- Consistent Yearly growth can be seen

-- Top 10 By EV adoption 
SELECT state, SUM(ev_sales_quantity) AS total_sales
FROM ev_sales
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;
 -- UP, Maharastra, Karnataka, Delhi, Rajasthan Being the top 5 Respectively

--top 5 states contribution to the market share
SELECT 
  SUM(total_sales) * 100.0 / (SELECT SUM(ev_sales_quantity) FROM ev_sales) AS contribution_percentage
FROM (
  SELECT state, SUM(ev_sales_quantity) AS total_sales
  FROM ev_sales
  GROUP BY state
  ORDER BY total_sales DESC
  LIMIT 5
) t;
-- Top 5 states contribute to ~ 54% of the total market share

-- State wise growth
SELECT state, year, SUM(ev_sales_quantity) AS yearly_sales
FROM ev_sales
GROUP BY state, year
ORDER BY state, year;
-- Each State shows growth in yearly_sales

-- Vehicle category performance
SELECT vehicle_category, SUM(ev_sales_quantity) AS total_sales
FROM ev_sales
GROUP BY vehicle_category
ORDER BY total_sales DESC;
-- 2 Wheelers shows the highest sales followed by 3 and 4 wheelers

-- Vehicle category market share
SELECT 
  vehicle_category,
  SUM(ev_sales_quantity) * 100.0 / (SELECT SUM(ev_sales_quantity) FROM ev_sales) AS percentage
FROM ev_sales
GROUP BY vehicle_category
ORDER BY percentage DESC;
-- 2 wheelers contribute to ~50% of the total market share followed by 3 wheelers and 4 wheelers

-- Vehicle class analysis
SELECT vehicle_class, SUM(ev_sales_quantity) AS total_sales
FROM ev_sales
GROUP BY vehicle_class
ORDER BY total_sales DESC;
-- M_cycle, E-rickshaw, Motor car being the top 3

-- Monthly Sales Trend
SELECT
    month_name,
    SUM(ev_sales_quantity) AS monthly_sales
FROM ev_sales
GROUP BY month_name
Order by monthly_sales DESC;
-- Nov, Dec records the highest EV sales while Feb shows the lowest EV adoption.