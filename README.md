# DA Job Market Analysis — SQL + Power BI

## Dataset
700,000+ job postings — Luke Barousse (2023)

## Tools
PostgreSQL | Power BI

## SQL Techniques Used
- CTEs (multi-level)
- Window Functions: LAG, RANK, ROW_NUMBER, PARTITION BY
- Self JOIN
- Conditional Aggregation (CASE WHEN in AGG)
- Temp Tables

## Key Findings
- SQL most in-demand (3,892 postings)
- Remote AI/ML roles: salary premium vs onsite
- Salary peaks: June (~$102K avg)
- Airflow, Kafka: 75%+ senior-skewed skills

## Dashboard
### 1. Độ hot của từng skill
![Độ hot của từng skill](<Độ hot của từng skill.png>)

### 2. Biến động lương DA
![Biến động lương DA](<Biến động lương DA.png>)

### 3. Xu hướng Onsite vs Remote
![Onsite vs Remote](<Onsite vs Remote.png>)

### 4. So sánh Senior vs Junior
![Senior vs Junior](<Senior vs Junior.png>)

### 5. Tầm quan trọng của kỹ năng theo công ty
![Cty quan trọng kĩ năng](<Cty quan trọng kĩ năng.png>)
