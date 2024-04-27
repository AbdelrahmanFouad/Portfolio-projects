--looking at total cases vs total deaths
--shows the likelyhood of dying if you contract covid in your country

select 
location, date, total_cases,total_deaths,(CAST(total_deaths as decimal)/CAST(total_cases as decimal))*100
as DeathPercentage
from CovidDeaths
where location like 'egypt'
order by 1,2

-- looking at the total cases vs population
-- shows what percentage of population got covid
select 
location, date, total_cases,population,(CAST(total_cases as decimal)/CAST(population as decimal))*100
as perectangeInfected
from CovidDeaths
where location like '%states'
order by 1,2 

--looking at countries with highest infection rate compared to population

select 
location, MAX(cast(total_cases as int)) as highestInfectionCount,
population,max((CAST(total_cases as decimal)/CAST(population as decimal))*100)
as perectangeInfected
from CovidDeaths
--where location like '%states'
group by population, location
order by perectangeInfected desc

-- showing countries with highest death count per population
select max(cast(total_deaths as int))as totalDeathCount, location 
from CovidDeaths
where continent is not null
group by location
order by totalDeathCount desc

-- showing continents with highest death count per population
select max(cast(total_deaths as int))as totalDeathCount, continent 
from CovidDeaths
where continent is not null
group by continent
order by totalDeathCount desc

-- global numbers
select date, sum(new_cases) as totalcases,sum(cast(new_deaths as int)) as totaldeaths
,sum(cast(new_deaths as int))/sum(new_cases)*100
as DeathPercentage
from CovidDeaths
where continent is not null and new_cases>0
group by date
order by DeathPercentage

--looking at total population vs vaccinations
select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations,
sum(convert(decimal,vac.new_vaccinations)) over (partition by dea.location ) rollingpeoplevaccinated
from CovidVaccinations vac
join CovidDeaths dea
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null 
order by 2,3

-- using a cte
with popvsvac(continent,location,date,population,new_vaccinations, rollingpeoplevaccinated)
as (
select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations,
sum(convert(decimal,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date )
rollingpeoplevaccinated
from CovidVaccinations vac
join CovidDeaths dea
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null 
--order by 2,3)
)


select *, (rollingpeoplevaccinated/population)*100 vacpercentage from popvsvac

--using temp table
DROP table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric)

insert into #percentpopulationvaccinated
select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations,
sum(convert(decimal,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date )
rollingpeoplevaccinated
from CovidVaccinations vac
join CovidDeaths dea
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null 
--order by 2,3)
select *, (rollingpeoplevaccinated/population)*100 vacpercentage from #percentpopulationvaccinated


-- creating view to store data for later visualization
create view percentpopulationvaccinated as
select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations,
sum(convert(decimal,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date )
rollingpeoplevaccinated
from CovidVaccinations vac
join CovidDeaths dea
on dea.location=vac.location and dea.date=vac.date
where dea.continent is not null 

select * from percentpopulationvaccinated

