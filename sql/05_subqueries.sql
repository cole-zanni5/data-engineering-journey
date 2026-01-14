-- =====================================
-- Subquery Examples
-- Queries using a SELECT inside another SELECT
-- Both correlated and uncorrelated subqueries
    -- Correlated subquery: The inner query depends on the outer query (runs once per outer row)
    -- Uncorrelated subquery: The inner query runs independently of the outer query (runs once total)

-- =====================================

-- 1. Uncorrelated: List countries in the same continents as Argentina or Australia
-- Uses a subquery in WHERE with IN
SELECT name, continent FROM world
WHERE continent IN (
    SELECT continent FROM world
    WHERE name = 'Argentina' OR name = 'Australia'
)
ORDER BY name ASC;

-- 2. Uncorrelated: Find countries with population between United Kingdom and Germany
-- Uses subqueries to set bounds
SELECT name, population FROM world
WHERE population > (
        SELECT population FROM world
        WHERE name = 'United Kingdom'
    )
  AND population < (
        SELECT population FROM world
        WHERE name = 'Germany'
    );

-- 3. Show each European country's population as a percentage of Germany's population
-- Uses a subquery inside an expression
SELECT name, CONCAT(ROUND(population * 100 / (
                SELECT population FROM world
                WHERE name = 'Germany'
            )
        ),
        '%'
    ) AS percentage
FROM world
WHERE continent = 'Europe';

-- 4. Uncorrelated: Find countries in Europe with the highest GDP
-- Uses a subquery with ALL
SELECT name, gdp FROM world
WHERE gdp > ALL (
    SELECT gdp FROM world
    WHERE continent = 'Europe' AND gdp > 0
);

-- 5. Correlated: List countries with population above the average of their continent
SELECT w1.name, w1.continent, w1.population FROM world w1
WHERE w1.population > (
    SELECT AVG(w2.population)
    FROM world w2
    WHERE w2.continent = w1.continent
);

-- 6. Correlated: List countries with GDP higher than the average GDP in their continent
SELECT w1.name, w1.continent, w1.gdp FROM world w1
WHERE w1.gdp > (
    SELECT AVG(w2.gdp)
    FROM world w2
    WHERE w2.continent = w1.continent
    AND w2.gdp > 0
);