SELECT
    d.skills as skills,
    count (j.job_id) as so_luong_vi_tri_can_tuyen,
    round(avg(salary_year_avg),0) as luong_trung_binh
from job_postings_fact as j
INNER JOIN skills_job_dim as s on j.job_id = s.job_id
INNER JOIN skills_dim as d on s.skill_id = d.skill_id 
where job_title_short ilike '%Data Analyst%'
and salary_year_avg is not null
GROUP BY d.skills
order by so_luong_vi_tri_can_tuyen desc
limit 10;