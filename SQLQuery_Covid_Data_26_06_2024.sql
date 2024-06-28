-- Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths
ORDER BY location, date

-- Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

SET ARITHABORT OFF   
SET ANSI_WARNINGS OFF  

SELECT location, date, total_cases, total_deaths,(cast(total_deaths as int)/cast(total_cases as int))*100 AS DeathPercentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE location like '%america%'
ORDER BY location, date

Select Location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
From PortfolioProject..CovidDeaths

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT location, date, population, total_cases,(cast(total_cases as int)/cast(population as int))*100 AS PercentPopulationInfected
FROM PortfolioProject.dbo.CovidDeaths
WHERE location like '%america%'
ORDER BY location, date

-- Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((cast(total_cases as int)/cast(population as int)))*100 AS PercentPopulationInfected
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing Countries with Highest Death Count per Population

SELECT location, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

SELECT *
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location

--LET'S break things down by Continent

SELECT continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY continent, TotalDeathCount DESC

SELECT location, continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, continent
ORDER BY location, TotalDeathCount DESC

SELECT location, continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, continent
ORDER BY TotalDeathCount DESC



--Showing continents with the highest death count per population

SELECT continent, MAX(cast(Total_deaths as int)) AS TotalDeathCount 
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as new_total_cases, SUM(cast(new_deaths as int)) as new_total_deaths, SUM(cast(new_deaths as int)/cast(new_cases as int))*100 AS NewDeathPercentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date

SELECT SUM(new_cases) as new_total_cases, SUM(cast(new_deaths as int)) as new_total_deaths, (SUM(cast(new_deaths as int))/SUM(new_cases)*100) AS NewDeathPercentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL

SELECT *
FROM PortfolioProject.dbo.CovidVaccinations

-- Looking for Total Polulation vs Vaccinations

SET ARITHABORT OFF   
SET ANSI_WARNINGS OFF 

SELECT * 
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date


SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases, vac.population,
SUM(cast(dea.new_cases as int)) 
OVER (Partition by dea.location)
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3

SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases, vac.population,
SUM(CONVERT(int,dea.new_cases)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.Date ROWS UNBOUNDED PRECEDING) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3

SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases, vac.population,
SUM(CONVERT(int,dea.new_cases)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.Date ROWS UNBOUNDED PRECEDING) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2,3

-- USE CTE

WITH PopvsVac (Continent, location, Date,population, new_cases, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases,
SUM(CONVERT(int,dea.new_cases)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.Date ROWS UNBOUNDED PRECEDING) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac

--TEMP Table

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_cases numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases,
SUM(CONVERT(int,dea.new_cases)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.Date ROWS UNBOUNDED PRECEDING) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
SELECT *, (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated

-- Creating View to store for late visualizations

CREATE VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, dea.new_cases,
SUM(CONVERT(int,dea.new_cases)) 
OVER (Partition by dea.location ORDER BY dea.location, dea.Date ROWS UNBOUNDED PRECEDING) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths as dea
JOIN
PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL

--DROP VIEW IF EXISTS PercentPopulationVaccinated
SELECT *
FROM PercentPopulationVaccinated 

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_vaccinations INT

SELECT new_vaccinations
FROM PortfolioProject..CovidDeaths
WHERE new_vaccinations = '175.0'