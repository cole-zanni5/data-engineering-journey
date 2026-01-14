-- =====================================
-- Aggregation Examples
-- Queries using COUNT(), SUM(), AVG(), MIN(), MAX(), GROUP BY / HAVING
-- =====================================

-- 1. Count total number of countries 
SELECT COUNT(*) AS total_countries
FROM world;

-- 2. Find total population of all countries in Asia
SELECT SUM(population) AS total_population_asia
FROM world
WHERE continent = 'Asia';

-- 3. Calculate average area of countries in Europe
SELECT AVG(area) AS average_area_europe
FROM world
WHERE continent = 'Europe';

-- 4. Number of countries per continent
SELECT continent, COUNT(*) AS countries_count
FROM world
GROUP BY continent;

-- 5. Continents with total population over 1 billion
SELECT continent, SUM(population) AS total_pop
FROM world
GROUP BY continent
HAVING SUM(population) > 1000000000;

-- 9. Find continents where the largest country population exceeds 500 million
SELECT continent, MAX(population) AS largest_population
FROM world
GROUP BY continent
HAVING MAX(population) > 500000000;
