
SELECT
    DATE_TRUNC('month', job_posted_date) as thang,
    ROUND(AVG(salary_year_avg), 0) as avg_salary,
    LAG(ROUND(AVG(salary_year_avg),0)) OVER (ORDER BY DATE_TRUNC('month', job_posted_date)) as prev_month,
    ROUND(AVG(salary_year_avg),0) - LAG(ROUND(AVG(salary_year_avg),0)) OVER (ORDER BY DATE_TRUNC('month', job_posted_date)) as change
FROM job_postings_fact
WHERE job_title_short ILIKE '%Data Analyst%'
AND salary_year_avg IS NOT NULL
GROUP BY thang
ORDER BY thang ASC;