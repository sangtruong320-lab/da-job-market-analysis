with bang_loc as(SELECT
    d.skills as skills,
    round(avg(salary_year_avg),0) as luong_trung_binh,
    count(case WHEN
    job_work_from_home = TRUE then 1 end) as remote,
    count(case WHEN
    job_work_from_home = FALSE then 1 end) as onsite,
    round(avg(case when job_work_from_home = TRUE then salary_year_avg end),0) as avg_remote,
    round(avg(case when job_work_from_home = FALSE then salary_year_avg end),0) as avg_onsite
from job_postings_fact as j
INNER JOIN skills_job_dim as s on j.job_id = s.job_id
INNER JOIN skills_dim as d on s.skill_id = d.skill_id 
where job_title_short ilike '%Data Analyst%'
and salary_year_avg is not null
GROUP BY d.skills
order by luong_trung_binh desc
limit 100)
select
    skills,
    luong_trung_binh,
    remote,
    onsite,
    avg_remote,
    avg_onsite
from bang_loc 
where avg_remote is not null
and avg_onsite is not null
limit 10;
