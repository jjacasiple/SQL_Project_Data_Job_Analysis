/*
**Question: What are the most in-demand skills for data analysts?**

- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in 
 the job market, providing insights into the most valuable skills 
 for job seekers.*/

 
 WITH query_1 as (
 SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.job_posted_date,
    job_postings_fact.salary_year_avg,
    company_dim.name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.job_location = 'Anywhere'
    AND job_postings_fact.salary_year_avg IS NOT NULL
ORDER BY
    job_postings_fact.salary_year_avg desc
LIMIT 10
 ),

query_2 AS(
 SELECT
   query_1.*,
   skills_dim.skill_id,
   skills_dim.skills
FROM
    query_1
  
    INNER JOIN skills_job_dim ON query_1.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    query_1.salary_year_avg DESC
)

--Query for the top 10 data analyst job listing
SELECT
    query_2.skills,
    COUNT(query_1.job_id) as job_to_skill
FROM
    query_1
    INNER JOIN query_2 ON query_2.job_id = query_1.job_id
GROUP BY
    query_2.skills
ORDER BY
    job_to_skill desc
LIMIT 5

--Query for all job postings

SELECT
    skills,
    COUNT(skills_job_dim.job_id) as skills_to_job
FROM
    job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_work_from_home = 'True'
GROUP BY
    skills
ORDER BY
    skills_to_job desc
LIMIT 5

