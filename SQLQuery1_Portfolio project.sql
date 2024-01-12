Select * from [Portfolio project].. CovidDeaths$
order by 3,4
Select *
From [Portfolio project]..[CovidVaccinations$]
order by 3,4

-- select data that we are going to be using 

Select Location , date , total_cases, new_cases, total_deaths, population
From [Portfolio project]..CovidDeaths$
order by 1,2

-- Looking at Total Cases vs Total Deatths

Select Location , date , total_cases, total_deaths, (total_deaths/total_cases)* 100 as DeathPercentage
From [Portfolio project]..CovidDeaths$
Where location like '%states%'
order by 1,2


-- Looking at countries with highest infection rate Compared to the population
Select Location , population, MAX(total_cases) As HighestInfectionCount, Max((total_cases/population))*100 as
  PercentPopulationInfected
From [Portfolio project]..CovidDeaths$
-- Where location like %states%
Group by Location, Population
order by PercentPopulationInfected desc

-- showing countries with highest death count per population


Select Location, MAX(cast(total_deaths as int)) As TotalDeathCount
From [Portfolio project]..CovidDeaths$
-- Where location like %states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc

-- LETS's Break things down by continent
Select location, MAX(cast(total_deaths as int)) As TotalDeathCount
From [Portfolio project]..CovidDeaths$
-- Where location like %states%'
Where continent is not null
Group by location 
order by TotalDeathCount desc


-- showing continents with highest death count per population 
Select continent, MAX(cast(total_deaths as int)) As TotalDeathCount
From [Portfolio project]..CovidDeaths$
-- Where location like %states%'
Where continent is not null
Group by continent 
order by TotalDeathCount desc



-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(new_cases)*100 as
DeathPercentage
From [Portfolio project]..CovidDeaths$
-- Where location like %states%'
Where continent is not null
Group by date 
order by 1,2

-- lOOKING ON TOTAL POPULATION VS VACCINATIONS 

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location,
dea.Date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
from [Portfolio project]..CovidDeaths$ dea
Join [Portfolio project]..CovidVaccinations$ vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- USE CTE
WITH PopsVsVac (Continent, Location, Date ,Population,New_Vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location,
dea.Date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
from [Portfolio project]..CovidDeaths$ dea
Join [Portfolio project]..CovidVaccinations$ vac
     On dea.location = vac.location
	 and dea.date = vac.date
-- where dea.continent is not null
-- order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopsVsVac


-- Temp table
Drop table if exists #PercentPopulationVaccinated
create table  #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location,
dea.Date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
from [Portfolio project]..CovidDeaths$ dea
Join [Portfolio project]..CovidVaccinations$ vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
-- order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- creating view to store data for later visualisation
Create view PercentPopulationVaccinated as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location,
dea.Date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
from [Portfolio project]..CovidDeaths$ dea
Join [Portfolio project]..CovidVaccinations$ vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
-- order by 2,3

Select * From PercentPopulationVaccinated