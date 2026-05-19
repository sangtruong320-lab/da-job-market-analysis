drop table if EXISTS step_1;
drop table if EXISTS step_2;
create temp table step_1 as (
SELECT
    d.skills as skills,
    count(case WHEN
        salary_year_avg >= 100000 then 1 end) as Senior_DA,
    count(case WHEN
        salary_year_avg < 100000 then 1 end) as Junior_DA,
        count (*) as total_market_DA,
        Round(AVG(salary_year_avg),0) as luong_trung_binh_theo_skill
from job_postings_fact as j
    inner join skills_job_dim as s on s.job_id = j.job_id
    inner join skills_dim as d on d.skill_id = s.skill_id
where job_title_short ilike '%data analyst%'
and salary_year_avg is not null
group by d.skills);
create temp table step_2 as (
    SELECT 
     d.skills as skills,
        round(avg (case when salary_year_avg >= 100000 then salary_year_avg end),0) 
        as AVG_Senior_DA,
        round(avg (case when salary_year_avg < 100000 then salary_year_avg end),0) 
        as AVG_Junior_DA
    from job_postings_fact as j
    inner join skills_job_dim as s on s.job_id = j.job_id
    inner join skills_dim as d on d.skill_id = s.skill_id
    where job_title_short ilike '%data analyst%'
    and salary_year_avg is not null
    group by d.skills);
    select *
    from step_2
    limit 10;
SELECT
    step_1.skills as skills,
    Senior_DA,
    Junior_DA,
    total_market_DA,
    luong_trung_binh_theo_skill,
    AVG_Senior_DA,
    AVG_Junior_DA,
    round(Senior_DA * 100.0 / total_market_DA, 1) as senior_pct
from step_1
    join step_2 on step_1.skills = step_2.skills
where total_market_DA >= 50
limit 10;
