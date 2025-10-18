-- نام کشور همراه با مجموع کل مبتلایان و مجموع کل فوت‌شده‌ها به‌صورت نزولی مجموع کل فوت‌شده‌ها‌
SELECT country,
SUM(new_cases)  AS total_case,
SUM(new_deaths) AS total_death
FROM covid
GROUP BY country
ORDER BY total_death DESC;


-- مجموع تعداد مبتلایان و تعداد فوت‌شده‌ها‌ی کشور ایران
SELECT
SUM(new_cases)  AS total_case,
SUM(new_deaths) AS total_death
FROM covid
WHERE country = 'Iran (Islamic Republic of)';


-- نام کشور به همراه رنک آن
WITH totals AS (
  SELECT country, SUM(new_deaths) AS total_death
  FROM covid
  GROUP BY country
)
SELECT country, RANK() OVER (ORDER BY total_death DESC) AS death_rank
FROM totals
ORDER BY death_rank, country;


-- رنک کشور ایران در کوئری سوم
WITH totals AS (
  SELECT
    country,
    SUM(new_cases)  AS total_case,
    SUM(new_deaths) AS total_death
  FROM covid
  GROUP BY country
),
ranked AS (
  SELECT
    country,
    RANK() OVER (ORDER BY total_death DESC) AS death_rank
  FROM totals
)
SELECT death_rank
FROM ranked
WHERE country = 'Iran (Islamic Republic of)';