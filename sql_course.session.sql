WITH salary_info_provided AS (
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
    job_postings_fact.salary_hour_avg
FROM
    job_postings_fact
WHERE
    job_postings_fact.salary_year_avg IS NOT NULL
    OR
    job_postings_fact.salary_hour_avg IS NOT NULL
),

salary_not_provided AS (
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
    job_postings_fact.salary_hour_avg
FROM
    job_postings_fact
WHERE
    job_postings_fact.salary_year_avg IS NULL
    AND
    job_postings_fact.salary_hour_avg IS NULL
)

SELECT
    salary_info_provided.job_id,
    salary_info_provided.job_title,
    salary_info_provided.salary_year_avg,
    salary_info_provided. salary_hour_avg
FROM
    salary_info_provided

UNION ALL

SELECT
    salary_not_provided.job_id,
    salary_not_provided.job_title,
    salary_not_provided.salary_year_avg,
    salary_not_provided.salary_hour_avg
FROM
    salary_not_provided

-- Query for job postings with salary information
(SELECT 
    job_id,
    job_title,
    'With Salary Info' AS salary_info
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL)

UNION ALL

-- Query for job postings without salary information
(SELECT 
    job_id,
    job_title,
    'Without Salary Info' AS salary_info
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NULL AND salary_hour_avg IS NULL
)
ORDER BY    
    salary_info desc, job_id 

SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_location,
    job_postings_fact.job_via,
    skills_dim.skills,
    skills_dim.type
FROM
    job_postings_fact
    INNER JOIN
        skills_job_dim
            ON
            job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim  
            ON
            skills_dim.skill_id = skills_job_dim.skill_id

CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

