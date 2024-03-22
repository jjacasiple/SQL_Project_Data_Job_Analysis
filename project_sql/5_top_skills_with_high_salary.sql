
WITH in_demand_skills AS(
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) as skills_to_job
    FROM
        job_postings_fact

        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_work_from_home = 'True'
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
),

top_skills_salary AS(
    SELECT
        skills_job_dim.skill_id,
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
        skills_job_dim.skill_id, skills_dim.skills
    
)

SELECT
in_demand_skills.skill_id,
in_demand_skills.skills,
in_demand_skills.skills_to_job as demand_count,
top_skills_salary.salary_average
    FROM
        in_demand_skills
    INNER JOIN
        top_skills_salary
            ON in_demand_skills.skill_id = top_skills_salary.skill_id
ORDER BY
    demand_count desc
LIMIT 10







