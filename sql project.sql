Create database Delhiincomeanalysis;
Use Delhiincomeanalysis;
create table district_income(district_name VARCHAR(100) PRIMARY KEY,
pci_current DECIMAL(10,2),
growth_rate DECIMAL(5,2)
);
INSERT INTO district_income VALUES
('Central Delhi', 461910.00, 7.40),
('North Delhi', 421000.00, 7.40),
('South Delhi', 501000.00, 7.40),
('East Delhi', 392500.00, 7.40),
('West Delhi', 405300.00, 7.40),
('New Delhi', 475000.00, 7.40),
('North East Delhi', 389000.00, 7.40),
('North West Delhi', 398200.00, 7.40),
('South East Delhi', 432000.00, 7.40),
('South West Delhi', 415000.00, 7.40),
('Shahdara', 387500.00, 7.40);
SELECT district_name, pci_current
FROM district_income
ORDER BY pci_current DESC
LIMIT 5;
SELECT district_name, pci_current
FROM district_income
ORDER BY pci_current ASC
LIMIT 5;
SELECT
  ROUND(AVG(pci_current), 2) AS avg_pci,
  MIN(pci_current) AS min_pci,
  MAX(pci_current) AS max_pci,
  MAX(pci_current) - MIN(pci_current) AS pci_range
FROM district_income;
SELECT district_name, pci_current
FROM district_income
WHERE pci_current > (SELECT AVG(pci_current) FROM district_income)
ORDER BY pci_current DESC;
SELECT
  district_name,
  pci_current,
  ROUND(pci_current / (1 + growth_rate/100), 2) AS pci_last_year,
  growth_rate
FROM district_income;

CREATE TABLE delhi_income (
    district VARCHAR(100),
    year INT,
    per_capita_income FLOAT
);
INSERT INTO delhi_income VALUES
('Delhi NCT', 2018, 338730),
('Delhi NCT', 2019, 355798),
('Delhi NCT', 2020, 389529),
('Delhi NCT', 2021, 444768);

SELECT district, AVG(per_capita_income) AS avg_income
FROM delhi_income
GROUP BY district;


iNSERT INTO delhi_income VALUES
('Central Delhi', 2022, NULL),
('East Delhi',    2022, NULL),
('New Delhi',     2022, NULL),
('North Delhi',   2022, NULL),
('North East Delhi',2022,NULL),
('North West Delhi',2022,NULL),
('Shahdara',      2022, NULL),
('South Delhi',   2022, NULL),
('South East Delhi',2022,NULL),
('South West Delhi',2022,NULL),
('West Delhi',    2022, NULL);

SELECT year, per_capita_income
FROM delhi_income
WHERE district = 'Delhi NCT'
ORDER BY year;

SELECT district 
FROM delhi_income
WHERE per_capita_income IS NULL;

SELECT 
  year,
  per_capita_income,
  LAG(per_capita_income) OVER (ORDER BY year) AS previous_income,
  ROUND(((per_capita_income - LAG(per_capita_income) OVER (ORDER BY year)) 
         / LAG(per_capita_income) OVER (ORDER BY year)) * 100, 2) AS growth_rate_percent
FROM delhi_income
WHERE district = 'Delhi NCT';

SELECT district, year, per_capita_income,
       RANK() OVER (PARTITION BY year ORDER BY per_capita_income DESC) AS income_rank
FROM delhi_income
WHERE per_capita_income IS NOT NULL;
SELECT year, COUNT(*) AS missing_data_count
FROM delhi_income
WHERE per_capita_income IS NULL
GROUP BY year
ORDER BY missing_data_count DESC;

SELECT year, COUNT(*) AS records_per_year
FROM delhi_income
GROUP BY year
ORDER BY year;












