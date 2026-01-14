-- =====================================
-- Basic Filtering Examples
-- Queries using SELECT, WHERE, AND, OR, IN, LIKE, IS NULL, IS NOT NULL
-- =====================================

-- 1. Select all columns from a table
SELECT * FROM world;

-- 2. Filter population of a single country
SELECT population FROM world
  WHERE name = 'Germany';

-- 3. Filter population for multiple countries
SELECT name, population FROM world
  WHERE name IN ('Sweden','Norway','Denmark');

-- 4. Filter countries that start with 'United'
SELECT name FROM world
    WHERE name LIKE '%United%';

-- 5. Filter countries with NULL population
SELECT name FROM world
    WHERE population IS NULL;

-- 6. Filter countries with population > 100 million and have name ending with 'a'
SELECT name, population FROM world
    WHERE population > 100000000 
    AND name LIKE '%a';
