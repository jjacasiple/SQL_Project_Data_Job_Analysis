
SELECT
    ROUND(AVG(job_postings_fact.salary_year_avg),2) as salary_average,
    skills_dim.skills
FROM
job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'
GROUP BY
    skills
ORDER BY
    salary_average DESC

    