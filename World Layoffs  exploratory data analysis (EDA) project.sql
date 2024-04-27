-- EDA

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers

-- normally when you start the EDA process you have some idea of what you're looking for

-- with this info we are just going to look around and see what we find!

select * from `layoffs_staging2`;
-- Warmup query
select company ,max(total_laid_off) from `layoffs_staging2`
group by company
order by max(total_laid_off) desc;


-- Looking at Percentage to see how big these layoffs were
-- Which companies had 100 percent of their company laid off

update layoffs_staging2
set percentage_laid_off= percentage_laid_off*100;

select * from layoffs_staging2 where
percentage_laid_off=100
order by funds_raised_millions desc;

-- Companies with the most Total Layoffs

select company ,sum(total_laid_off) from `layoffs_staging2`
group by company
order by 2 desc;

-- Looking at date range

select min(date), max(date) from layoffs_staging2;

-- Industries with the most Total Layoffs

select industry ,sum(total_laid_off) from `layoffs_staging2`
group by industry
order by 2 desc;

-- Countries with the most Total Layoffs

select country  ,sum(total_laid_off),year(date) from `layoffs_staging2`
group by country,year(date)
order by 2 desc;

-- Years with the most Total Layoffs

select year(date) ,sum(total_laid_off) from `layoffs_staging2`
group by year(date)
order by 2 desc;

-- Most Total Layoffs by company stage

select stage ,sum(total_laid_off) from `layoffs_staging2`
group by stage
order by 2 desc;

-- Looking at perecentages again

select company, max(percentage_laid_off) from layoffs_staging2
group by company
order by 2 desc;


-- Rolling Total of Layoffs Per Month
with cte as(
select year(date) year,month(date) month ,sum(total_laid_off) total_laid_off from `layoffs_staging2`
where month(date) is not null
group by 1,2
order by 1,2 )
select year,month,total_laid_off,sum(total_laid_off) over(order by year,month) rollingSum 
from cte;

select company,year(date) ,sum(total_laid_off) from `layoffs_staging2`
group by company,year(date)
order by 3 desc;

-- looking at companies with most layoffs per year
with company_cte as(
select Company,year(date) Years ,sum(total_laid_off) Total_Laid_Off from `layoffs_staging2`
group by company,year(date)
order by 3 desc),
company_year_rank as(
select * , dense_rank() over(partition by years order by Total_Laid_Off desc) Ranking
from company_cte
where years is not null )
select * from company_year_rank 
where ranking<=5






