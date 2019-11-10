--Table: world(name, continent, area, population, gdp)

--1. List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world 
WHERE population >
  (SELECT population FROM world 
    WHERE name = 'Russia');
    
--2. Show the names of countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world 
WHERE continent ='Europe' AND 
  gdp/population>
    (SELECT gdp/population AS per_capita_gdp 
      FROM world WHERE name= 'United Kingdom');
    
--3. List the name and continent of countries in the continents containing either Argentina 
--or Australia. Order by name of the country.

SELECT name, continent FROM world 
WHERE continent IN
  (SELECT continent FROM world 
    WHERE name ='Argentina' OR name ='Australia')
ORDER BY name;

--4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population FROM world 
WHERE population>
  (SELECT population FROM world 
   WHERE name ='Canada')AND 
      population<
  (SELECT population FROM world 
   WHERE name ='Poland');
   
--5. Germany (population 80 million) has the largest population of the countries in Europe. 
--Austria (population 8.5 million) has 11% of the population of Germany.

SELECT name, population, 
	CONCAT(ROUND(population/(SELECT population FROM world WHERE name ='Germany')*100, 0),'%')
FROM world
WHERE continent ='Europe';
