--- Creating our dataset table
CREATE DATABASE IF NOT EXISTS corona_data;

-- Cleaning and checking the dataset details 
SELECT * FROM corona_data.`corona virus dataset`;

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
USE corona_data;
SELECT COUNT(*) AS null_value
FROM corona_data.`corona virus dataset`
WHERE 'ALL COLUMNS' IS NULL;
-- Anwer: We have 0 null values, which means we do not have any missing values..

-- Q2. If NULL values are present, update them with zeros for all columns. 
-- Anwer : Because no null values were present, we do not need to update any of the columns.

-- Q3. check total number of rows
USE corona_data;
SELECT COUNT(*) AS total_number_of_rows
FROM corona_data.`corona virus dataset`;
-- Anwer:The total number of rows is 78386

-- Q4. Check what is start_date and end_date
USE corona_data;
SELECT 
    MIN(STR_TO_DATE(Date, '%d-%m-%Y')) AS start_date,
    MAX(STR_TO_DATE(Date, '%d-%m-%Y')) AS end_date
FROM 
    corona_data.`corona virus dataset`;
-- Anwer: The start_date is '2020-01-22' and the end_date is '2021-06-13'

-- Q5. Number of month present in dataset
USE corona_data;
SELECT COUNT(DISTINCT MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))) AS num_of_months
FROM corona_data.`corona virus dataset`;
-- Anwer: Number of month present is 12

-- Q6. Find monthly average for confirmed, deaths, recovered
USE corona_data;
SELECT 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM corona_data.`corona virus dataset`
GROUP BY MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY MONTH;
-- Anwer: The code displays monthly averages for confirmed, deaths, and recovered cases. 
-- 

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
USE corona_data;
SELECT 
	MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month, 
    MAX(Confirmed) AS most_frequent_confirmed,
    MAX(Deaths) AS most_frequent_deaths,
    MAX(Recovered) AS most_frequent_recovered
FROM (
    SELECT 
        Date,
        Confirmed,
        Deaths,
        Recovered,
        COUNT(*) AS frequency
    FROM corona_data.`corona virus dataset`
    GROUP BY Date, Confirmed, Deaths, Recovered
) AS subquery
GROUP BY MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY MONTH;
-- Anwer:After running the code, the most frequent values for confirmed, deaths, and recovered cases can be found. 


-- Q8. Find minimum values for confirmed, deaths, recovered per year
USE corona_data;
SELECT
    YEAR(STR_TO_DATE(Date, '%d-%m-%Y')) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM 
 `corona virus dataset`   
GROUP BY 
    YEAR(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY YEAR;
-- Anwer: The minimum values for confirmed, deaths, and recovered per year are zero(0), 
-- indicating that there is no minimum value for any case.

-- 9. Find maximum values of confirmed, deaths, recovered per year
USE corona_data;
SELECT 
    YEAR(STR_TO_DATE(Date, '%d-%m-%Y')) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM 
    `corona virus dataset`
GROUP BY 
    YEAR(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY 
    YEAR;
-- Anwer: :Run the code to see the maximum values for confirmed, deaths, and recovered cases per year. 


-- Q10. The total number of case of confirmed, deaths, recovered each month
USE corona_data;
SELECT 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    SUM(Confirmed) AS total_confirmed_cases,
    SUM(Deaths) AS total_death_cases,
    SUM(Recovered) AS total_recovered_cases
FROM 
    `corona virus dataset`
GROUP BY 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY 
    MONTH;
-- Anwer:The code displays the total number of confirmed cases, deaths, and recovered cases for each month. 


-- 11. Check how corona virus spread out with respect to confirmed case
-- (Eg.: total confirmed cases, their average, variance & STDEV )
USE corona_data;
SELECT 
    SUM(Confirmed) AS total_confirmed_cases,
    AVG(Confirmed) AS average_confirmed_cases,
    VARIANCE(Confirmed) AS variance_confirmed_cases,
    STDDEV(Confirmed) AS stddev_confirmed_cases
FROM 
    `corona virus dataset`;
-- Anwer: The total corona virus spread is '169065144' for total confirmed cases, '2156.8283' for average confirmed cases,
-- '157288925.07796532' for variance confirmed cases, and '12541.488152446875' for standard deviation confirmed cases.




-- Q12. Check how corona virus spread out with respect to death case per month
-- (Eg.: total confirmed cases, their average, variance & STDEV )
USE corona_data;
SELECT 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    SUM(Deaths) AS total_death_cases,
    AVG(Deaths) AS average_death_cases,
    VARIANCE(Deaths) AS variance_death_cases,
    STDDEV(Deaths) AS stddev_death_cases
FROM 
    `corona virus dataset`
GROUP BY 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY 
    MONTH;
    
-- 12(B) how the coronavirus spread out with respect to death cases per month
USE corona_data;
SELECT 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    SUM(Deaths) AS total_death_cases
FROM 
    `corona virus dataset`
GROUP BY 
    MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY 
    MONTH;


-- Q13. Check how corona virus spread out with respect to recovered case
--  (Eg.: total confirmed cases, their average, variance & STDEV )
USE corona_data;
SELECT 
    SUM(Recovered) AS total_recovered_cases,
    AVG(Recovered) AS average_recovered_cases,
    VARIANCE(Recovered) AS variance_recovered_cases,
    STDDEV(Recovered) AS stddev_recovered_cases
FROM 
    `corona virus dataset`;
    

-- Q14. Find Country having highest number of the Confirmed case
USE corona_data;
SELECT 
    `Country/Region` AS Country,
	MAX(Confirmed) AS Highest_Confirmed_Cases
FROM 
    `corona virus dataset`
GROUP BY
    `Country/Region`
ORDER BY
    Highest_Confirmed_Cases DESC
LIMIT 1;
-- Anwer:The country with highest confirmed cases is 'Turkey'

-- Q15. Find Country having lowest number of the death case
USE corona_data;
SELECT 
    `Country/Region`,
    MIN(Deaths) AS lowest_death_cases
FROM 
    `corona virus dataset`
GROUP BY 
    `Country/Region`
ORDER BY 
    lowest_death_cases ASC
LIMIT 1;
-- Anwer: The country with the lowest number of death case is 'Afghanistan'


-- Q16. Find top 5 countries having highest recovered case
USE corona_data;
SELECT 
    `Country/Region`,
    SUM(Recovered) AS highest_recovered_cases
FROM 
    `corona virus dataset`
GROUP BY 
    `Country/Region`
ORDER BY 
    highest_recovered_cases DESC
LIMIT 5;
-- Anwer: The countries with the highest reported cases are India, Brazil, the United States, Turkey, and Russia.























