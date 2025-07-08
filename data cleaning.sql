-- 1. INITIAL EXPLORATION OF RAW DATA
-- View unique countries to identify inconsistencies
SELECT DISTINCT country FROM layoffs ORDER BY country;

-- Identify potential typos in country names
SELECT * FROM layoffs WHERE country LIKE '%States%';

-- View structure and sample of staging table
SELECT * FROM layoffs_staging;

-- Check inconsistent industry naming
SELECT DISTINCT industry FROM layoffs_staging ORDER BY industry;
SELECT * FROM layoffs_staging WHERE industry LIKE '%crypto%';

-- Check unusual or misspelled location values
SELECT DISTINCT location FROM layoffs_staging ORDER BY location;

SELECT * FROM layoffs_staging WHERE location LIKE '%floria%';


--  2. STANDARDIZE COUNTRY NAMES
-- Fix inconsistent naming for "United States"
select distinct country from layoffs order by country;
select * from layoffs where country like '%States%';

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert into layoffs_staging
select * from layoffs;

select * from layoffs_staging;

--  3. STANDARDIZE COUNTRY NAMES
-- Fix inconsistent naming for "United States"
select * from layoffs_staging where country like '%States%';

update layoffs_staging
set country = 'United States'
where country like '%States%';

select distinct country from layoffs_staging order by country;

select * from layoffs_staging;

--  4. STANDARDIZE INDUSTRY NAMES
-- Fix inconsistent casing or duplicates like 'crypto', 'Crypto'
select distinct industry from layoffs_staging order by industry;
select * from layoffs_staging where industry like '%crypto%';
update layoffs_staging
set industry = "Crypto"
where industry like "%Crypto%";

--  5. FIX TYPOGRAPHICAL ERRORS IN LOCATION NAMES
select distinct location from layoffs_staging order by location;
select * from layoffs_staging where location like "%floria%";

update layoffs_staging
set location = "Florianópolis"
where location like "%floria%";

select * from layoffs_staging where location like "%sseldorf%";

update layoffs_staging
set location = "Dusseldorf"
where location like "%sseldorf%";

select * from layoffs_staging where location like "%malm%";
update layoffs_staging
set location = "Malmo"
where location like "%malm%";

select * from layoffs_staging;

-- 6. REMOVE DUPLICATES USING ROW_NUMBER()
with dup_rows as (
select *,
row_number() over(partition by company,location, industry,total_laid_off, percentage_laid_off,
`date`, stage,country,funds_raised_millions) as row_num
from layoffs_staging

)
select * from dup_rows where company="Wildlife Studios";

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging2 
select *,
row_number() over(partition by company,location, industry,total_laid_off, percentage_laid_off,
`date`, stage,country,funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2 where row_num>1;

delete from layoffs_staging2 where row_num>1;

--  7. TRIM WHITESPACE FROM COMPANY NAMES
select company,trim(company)
from layoffs_staging2 order by company;

update layoffs_staging2
set company=trim(company);

--  8. CONVERT DATE FORMAT TO SQL DATE TYPE
select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select * from layoffs_staging2;

select distinct stage from layoffs_staging2 order by stage;

--  9. CLEAN NULL OR EMPTY STRINGS IN INDUSTRY COLUMN
select t1.company, t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
where (t1.industry is null or t1.industry="")
and t2.industry is not null;

update layoffs_staging2
set industry= NULL
where industry="";

update layoffs_staging2 as t1
join layoffs_staging2 as t2
on t1.company=t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select * from layoffs_staging2;

select * from layoffs_staging2 where industry is null;

select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

--  10. REMOVE ROWS WHERE BOTH LAYOFF FIELDS ARE NULL
delete from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

select * from layoffs_staging2;

--  11. DROPPING THE ROW_NUM COLUMN
alter table layoffs_staging2
drop column row_num;

--  12. IMPUTE MISSING FUNDS_RAISED VALUES BASED ON RESEARCH
update layoffs_staging2
set funds_raised_millions = 1.5
where company = "Loja Integrada";

update layoffs_staging2
set funds_raised_millions = 112
where company = "Willow";

update layoffs_staging2
set funds_raised_millions = 2
where company = "WeTrade";


update layoffs_staging2
set funds_raised_millions = 579
where company = "Weedmaps";

update layoffs_staging2
set funds_raised_millions = 46
where company = "Swyftx";

update layoffs_staging2
set funds_raised_millions = 0
where company = "Philips";

update layoffs_staging2
set funds_raised_millions = 11
where company = "Callisto Media";

update layoffs_staging2
set funds_raised_millions = 125
where company = "AppGate";

update layoffs_staging2
set funds_raised_millions = 0
where company = "Clear Capital";

update layoffs_staging2
set funds_raised_millions = 910
where company = "Booking.com";

update layoffs_staging2
set funds_raised_millions = 1
where company = "Bybit";

update layoffs_staging2
set funds_raised_millions = 0
where company = "Airy Rooms";

UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Agoda';
UPDATE layoffs_staging2 SET funds_raised_millions = 230 WHERE company = 'Akili Labs';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Ambev Tech';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Amdocs';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Article';
UPDATE layoffs_staging2 SET funds_raised_millions = 4.4 WHERE company = 'Artnight';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Autodesk';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Avast';
UPDATE layoffs_staging2 SET funds_raised_millions = 237 WHERE company = 'Bolt';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Capital One';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Cognyte';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Daniel Wellington';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Daraz';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Definitive Healthcare';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Dell';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'EMX Digital';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Envato';
UPDATE layoffs_staging2 SET funds_raised_millions = 2 WHERE company = 'F5';
UPDATE layoffs_staging2 SET funds_raised_millions = 730 WHERE company = 'Fivetran';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'IBM';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Lam Research';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'LendingTree';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Match Group';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'National Instruments';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'NCC Group';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'NetApp';
UPDATE layoffs_staging2 SET funds_raised_millions = 300 WHERE company = 'Newfront Insurance';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Oracle';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'PagSeguro';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Pegasystems';
UPDATE layoffs_staging2 SET funds_raised_millions = 2200 WHERE company = 'Playtika';
UPDATE layoffs_staging2 SET funds_raised_millions = 262 WHERE company = 'Productboard';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Qualcomm';
UPDATE layoffs_staging2 SET funds_raised_millions = 20 WHERE company = 'Relevel';
UPDATE layoffs_staging2 SET funds_raised_millions = 5 WHERE company = 'Ruggable';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'ScaleFocus';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Share Now';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'SkySlope';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'SSense';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Synopsys';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'TomTom';
UPDATE layoffs_staging2 SET funds_raised_millions = 0 WHERE company = 'Viant';
UPDATE layoffs_staging2 SET funds_raised_millions = 103 WHERE company = 'Bamboo Health';


--  13. FILLING MISSING TOTAL_LAID_OFF VALUES BASED ON EXTERNAL RESEARCH
select company, location, industry, `date`,country,total_laid_off,percentage_laid_off from layoffs_staging2
where total_laid_off is null;

select * from layoffs_staging2
where company like '%amount%';

UPDATE layoffs_staging2 SET total_laid_off = 1437 WHERE company = '2U';
UPDATE layoffs_staging2 SET total_laid_off = 24 WHERE company = '80 Acres Farms';
UPDATE layoffs_staging2 SET total_laid_off = 50 WHERE company = '5B Solar';
UPDATE layoffs_staging2 SET total_laid_off = 34 WHERE company = '98point6';
UPDATE layoffs_staging2 SET total_laid_off = 135 WHERE company = 'ActiveCampaign';
UPDATE layoffs_staging2 SET total_laid_off = 26 WHERE company = 'Affirm' and `date` = 2022-11-03;
UPDATE layoffs_staging2 SET total_laid_off = 110 WHERE company = 'Aiven';
UPDATE layoffs_staging2 SET total_laid_off = 90 WHERE company = 'Amber Group';
UPDATE layoffs_staging2 SET total_laid_off = 108 WHERE company = 'Amount' and `date`=2022-06-27;
UPDATE layoffs_staging2 SET total_laid_off = 44 WHERE company = 'Apollo';
UPDATE layoffs_staging2 SET total_laid_off = 31 WHERE company = 'Apollo Insurance';
UPDATE layoffs_staging2 SET total_laid_off = 800 WHERE company = 'Arrival';
UPDATE layoffs_staging2 SET total_laid_off = 41 WHERE company = 'Astra' and `date` = '2022-11-08' ;
UPDATE layoffs_staging2 SET total_laid_off = 12 WHERE company = 'Atlanta Tech Village' and `date` = '2020-04-02' ;
UPDATE layoffs_staging2 SET total_laid_off = 195 WHERE company = 'Attentive' and `date` = '2023-01-05' ;
UPDATE layoffs_staging2 SET total_laid_off = 60 WHERE company = 'Brightline' and `date` = '2022-11-01' ;
UPDATE layoffs_staging2 SET total_laid_off = 30 WHERE company = 'Brodmann17' and `date` = '2022-12-09' ;
UPDATE layoffs_staging2 SET total_laid_off = 56 WHERE company = 'Bustle Digital Group' and `date` = '2023-02-01' ;
UPDATE layoffs_staging2 SET total_laid_off = 46 WHERE company = 'Butterfly Network' and `date` = '2022-08-02' ;
UPDATE layoffs_staging2 SET total_laid_off = 104 WHERE company = 'Butterfly Network' and `date` = '2023-01-04' ;
UPDATE layoffs_staging2 SET total_laid_off = 250 WHERE company = 'Bybit' and `date` = '2022-12-03' ;
UPDATE layoffs_staging2 SET total_laid_off = 200 WHERE company = 'Callisto Media' and `date` = '2022-10-25' ;
UPDATE layoffs_staging2 SET total_laid_off = 300 WHERE company = 'Camp K12' and `date` = '2023-01-23' ;
UPDATE layoffs_staging2 SET total_laid_off = 37 WHERE company = 'Capitolis' and `date` = '2022-11-18' ;
UPDATE layoffs_staging2 SET total_laid_off = 122 WHERE company = 'Capsule' and `date` = '2022-07-19' ;
UPDATE layoffs_staging2 SET total_laid_off = 400 WHERE company = 'Carsome' and `date` = '2022-09-30' ;
UPDATE layoffs_staging2 SET total_laid_off = 200 WHERE company = 'Carta' and `date` = '2023-01-11' ;
UPDATE layoffs_staging2 SET total_laid_off = 90 WHERE company = 'Casavo' and `date` = '2023-02-13' ;
UPDATE layoffs_staging2 SET total_laid_off = 100 WHERE company = 'Cedar' and `date` = '2022-07-07' ;
UPDATE layoffs_staging2 SET total_laid_off = 102 WHERE company = 'CircleCI' and `date` = '2022-12-07' ;
UPDATE layoffs_staging2 SET total_laid_off = 163 WHERE company = 'Circulo Health' and `date` = '2022-06-16' ;
UPDATE layoffs_staging2 SET total_laid_off = 2200 WHERE company = 'Citrix' and `date` = '2023-01-10' ;
UPDATE layoffs_staging2 SET total_laid_off = 100 WHERE company = 'CoachHub' and `date` = '2023-01-24' ;
UPDATE layoffs_staging2 SET total_laid_off = 59 WHERE company = 'Codexis' and `date` = '2022-11-29' ;
UPDATE layoffs_staging2 SET total_laid_off = 20 WHERE company = 'Core Scientific' and `date` = '2022-08-12' ;
UPDATE layoffs_staging2 SET total_laid_off = 14 WHERE company = 'Corvus Insurance' and `date` = '2023-01-24' ;
UPDATE layoffs_staging2 SET total_laid_off = 490 WHERE company = 'Crypto.com' and `date` = '2023-01-12' ;
UPDATE layoffs_staging2 SET total_laid_off = 35 WHERE company = 'Cyteir Therapeutics' and `date` = '2023-01-20' ;
UPDATE layoffs_staging2 SET total_laid_off = 16 WHERE company = 'D2L' and `date` = '2022-11-16' ;
UPDATE layoffs_staging2 SET total_laid_off = 50 WHERE company = 'Daily Harvest' and `date` = '2022-08-08' ;
UPDATE layoffs_staging2 SET total_laid_off = 100 WHERE company = 'Dapper Labs' and `date` = '2023-02-23' ;
UPDATE layoffs_staging2 SET total_laid_off = 234 WHERE company = 'DataRobot' and `date` = '2022-08-23' ;
UPDATE layoffs_staging2 SET total_laid_off = 35 WHERE company = 'Deep Instinct' and `date` = '2022-06-06' ;
UPDATE layoffs_staging2 SET total_laid_off = 200 WHERE company = 'DeHaat' and `date` = '2023-01-15' ;
UPDATE layoffs_staging2 SET total_laid_off = 45 WHERE company = 'Desktop Metal' and `date` = '2022-06-13' ;
UPDATE layoffs_staging2 SET total_laid_off = 90 WHERE company = 'Devo' and `date` = '2022-11-21' ;
UPDATE layoffs_staging2 SET total_laid_off = 20 WHERE company = 'DriveWealth' and `date` = '2023-01-26' ;

