DROP TABLE IF EXISTS buoc_1;
DROP TABLE IF EXISTS buoc_2; 
DROP TABLE IF EXISTS buoc_0; 
    CREATE TEMP TABLE buoc_0 AS (
    SELECT 
        d.skills,
        ROUND(AVG(salary_year_avg), 0) AS market_avg
    FROM job_postings_fact j
    INNER JOIN skills_job_dim s ON s.job_id = j.job_id
    INNER JOIN skills_dim d ON d.skill_id = s.skill_id
    WHERE salary_year_avg IS NOT NULL
    GROUP BY d.skills
);
create temp table buoc_1 as (
    select 
        skills,
        c.name as company_name,
        round(avg (salary_year_avg),0) as company_avg,
        count (j.job_id) as tuyen
    from job_postings_fact as j 
    inner join company_dim as c on c.company_id = j.company_id
    inner join skills_job_dim as s on s.job_id = j.job_id
    inner join skills_dim as d on d.skill_id = s.skill_id
    where salary_year_avg is not null
    group by c.name, skills
);
create temp table buoc_2 as (
    select
    buoc_0.skills as skills,
    company_name,
    company_avg,
    market_avg,
    ROW_NUMBER() OVER (PARTITION BY company_name ORDER BY tuyen DESC) as tuyen_1
    from buoc_1
    jOIN buoc_0 ON buoc_0.skills = buoc_1.skills
);
select
skills,
company_name,
company_avg,
round (market_avg,0),
round (company_avg - market_avg,0) as difference
from buoc_2
where tuyen_1 = 1
order by difference desc
limit 15;