SELECT location,date, total_cases, new_cases,total_deaths
FROM `skilful-charmer-407223.covid_dataset.death` death
ORDER BY 1,2

--LOOKING AT RATE 
SELECT location,date, total_cases, total_deaths, (total_deaths/NULLIF(total_cases, 0))*100 AS death_rate
FROM `skilful-charmer-407223.covid_dataset.death` 
WHERE location = 'United States'
ORDER BY 1,2
-- see the ratio of covid patients out of the whole population
SELECT location,date, total_cases, population, (total_cases/population)*100 AS covid_perc
FROM `skilful-charmer-407223.covid_dataset.death` 
WHERE location like '%China%'
ORDER BY 1,2
-- showing countries with the highest covid rates
SELECT location,population, MAX(total_cases) AS highest_rate, MAX( (total_cases/population)) *100 AS covid_perc
FROM `skilful-charmer-407223.covid_dataset.death` 
GROUP BY location,population
ORDER BY covid_perc DESC


--showing countries with the highest death count per population 
SELECT location, MAX(total_deaths) AS highest_death_count
FROM `skilful-charmer-407223.covid_dataset.death` 
WHERE continent is not NULL
GROUP BY location
ORDER BY highest_death_count DESC

-- showing the continent with the highest death count per population  this seems only include America in North America
SELECT continent, MAX(total_deaths) AS total_death_count
 FROM `skilful-charmer-407223.covid_dataset.death` 
 WHERE continent is not null
 GROUP BY continent
 ORDER BY total_death_count DESC

--Global numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths
FROM `skilful-charmer-407223.covid_dataset.death` 
WHERE continent is not null
ORDER BY 1,2

--
SELECT dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations -- new vac per day
FROM `skilful-charmer-407223.covid_dataset.death` dea
JOIN `skilful-charmer-407223.covid_dataset.vaccine` vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.location = 'Canada'
order by 2
