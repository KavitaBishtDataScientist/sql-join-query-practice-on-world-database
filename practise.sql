use world;
/*🟢 Basic JOIN Practice
List all cities with their country names.*/
select c.name,co.name from city c
inner join country co
on c.countrycode = co.code;

/*Show city name, district, and country name for all cities in Asia.*/

select  c.name,c.district,co.name from city c
inner join country co
on c.countrycode=co.code
where continent= 'asia';

/*List all countries and their official languages.*/

select co.name, cl.language from country co 
inner join countrylanguage cl
on co.code=cl.countrycode
where cl.isofficial='t';

select * from countrylanguage;

/*Display city names and their population along with the country population.*/

select  c.name,c.population, co.population,co.name from city c
inner join country co
on c.countrycode=co.code;

/*Find all cities in countries where English is an official language.*/

select c.name,co.name from country co
inner join city c
on c.countrycode=co.code
inner join countrylanguage cl
on co.code=cl.countrycode
where language = 'english';
use world;

/*List country name and number of cities in each country.*/
 

SELECT co.name, COUNT(c.id) AS city_count
FROM country co
INNER JOIN city c ON co.code = c.countrycode
GROUP BY co.name
ORDER BY city_count DESC;

/*Show countries with more than 10 cities in the database.*/
 select co.name,count(c.id) from country co
 inner join city c
on co.code=c.countrycode
group by co.code
having count(c.id)> 10;

/*Find the total population of cities for each country.*/


SELECT co.name AS country_name, SUM(c.population) AS total_city_population
FROM country co 
INNER JOIN city c ON co.code = c.countrycode
GROUP BY co.name;

/*List languages spoken in each country along with the country’s continent.*/

select co.name,co.continent,cl.language 
from country co 
inner join countrylanguage cl
on co.code=cl.countrycode;

/*Show all cities in countries located in Europe with population > 1 million.*/

select co.name,c.name,co.continent ,c.population from country co 
inner join city c
on co.code=c.countrycode
where co. continent ='europe' and c.population > 1000000;

/*Find countries where the capital city population is greater than 5 million.
(Hint: Country.Capital = City.ID*/

select co.name,co.capital,c.name,c.population 
from country co
inner join city c
on co.capital=c.id
where c.population> 5000000; 

/*Display country name, language, and percentage spoken where percentage > 50%.*/

select co.name,cl.language,cl.percentage
from country co
inner join countrylanguage cl
on co.code=cl.countrycode
where cl.percentage > 50;

/*Find the top 5 most populated cities with their country and continent.*/

select c.name,c.population,co.name,co.continent
from country co 
inner join city c
on co.code=c.countrycode 
order by c.population desc
limit 5;

/* List countries where the majority language is NOT official.
(Hint: Percentage > 50 AND IsOfficial = 'F')*/

select co.name,cl.language,cl.percentage,cl.isofficial from country co
inner join countrylanguage cl
on co.code=cl.countrycode
where percentage >50 and isofficial ='f';

/*Show countries that have more than 3 official languages.*/

select co.name,count(cl.language) 
from country co
inner join countrylanguage cl
on co.code=cl.countrycode
where cl.isofficial='t'
group by co.name
having count(cl.language )>3;

/*Find the continent with the highest total city population.*/

SELECT co.continent, SUM(c.population) AS total_population
FROM country co
INNER JOIN city c ON co.code = c.countrycode
GROUP BY co.continent
ORDER BY total_population DESC
LIMIT 1;

/*List countries where the capital city is also the largest city in that country.*/

SELECT co.name AS country_name, c.name AS capital_city, c.population
FROM country co
INNER JOIN city c ON co.capital = c.id
WHERE c.population = (SELECT MAX(population) FROM city WHERE countrycode = co.code);


-- /*Show the average city population per country.*/

SELECT co.name AS country_name, AVG(c.population) AS average_city_population
FROM city c 
INNER JOIN country co ON co.code = c.countrycode
GROUP BY co.name;

-- /*Find countries where more than 50% of the population speaks a single language.*/

SELECT co.name AS country_name, cl.language, cl.percentage
FROM country co
INNER JOIN countrylanguage cl ON co.code = cl.countrycode
WHERE cl.percentage > 50
ORDER BY cl.percentage DESC;

-- /* List countries that have cities in more than 3 different districts.*/

SELECT co.name AS country_name, COUNT(DISTINCT c.district) AS district_count
FROM country co
INNER JOIN city c ON co.code = c.countrycode
GROUP BY co.name
HAVING COUNT(DISTINCT c.district) > 3
ORDER BY district_count DESC;