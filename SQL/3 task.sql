# ЗАДАНИЕ 3

# Возрастные группы клиентов с шагом 10 лет и отдельно клиентов, у которых нет данной информации, 
# с параметрами сумма и количество операций за весь период
SELECT
  CASE
    WHEN c.Age BETWEEN 10 AND 19 THEN '10-19'
    WHEN c.Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN c.Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN c.Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN c.Age BETWEEN 50 AND 59 THEN '50-59'
    WHEN c.Age BETWEEN 60 AND 69 THEN '60-69'
    WHEN c.Age >= 70 THEN '70+'
    ELSE 'NA'
  END AS age_group,
  COUNT(*) AS operations,
  ROUND(SUM(t.Sum_payment), 2) AS total_sum
FROM transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.data_new BETWEEN '2015-06-01' AND '2016-05-31'
GROUP BY age_group
ORDER BY age_group;

# поквартально - средние показатели и %.
SELECT
  CONCAT(YEAR(t.data_new), '-Q', QUARTER(t.data_new)) AS quarter,
  CASE
    WHEN c.Age BETWEEN 10 AND 19 THEN '10-19'
    WHEN c.Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN c.Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN c.Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN c.Age BETWEEN 50 AND 59 THEN '50-59'
    WHEN c.Age BETWEEN 60 AND 69 THEN '60-69'
    WHEN c.Age >= 70 THEN '70+'
    ELSE 'NA'
  END AS age_group,
  COUNT(*) AS operations,
  ROUND(AVG(t.Sum_payment), 2) AS avg_check
FROM transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.data_new BETWEEN '2015-06-01' AND '2016-05-31'
GROUP BY quarter, age_group
ORDER BY quarter, age_group;
