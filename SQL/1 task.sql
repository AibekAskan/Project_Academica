# ЗАДАНИЕ 1

# список клиентов с непрерывной историей за год, 
# то есть каждый месяц на регулярной основе без пропусков за указанный годовой период, 
SELECT ID_client
FROM (
    SELECT ID_client, COUNT(DISTINCT DATE_FORMAT(data_new, '%Y-%m')) AS active_months
    FROM transactions
    WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
    GROUP BY ID_client
) AS monthly_activity
WHERE active_months = 12;

# Средний чек за период с 01.06.2015 по 01.06.2016
SELECT ID_client, ROUND(AVG(Sum_payment), 2) AS avg_check
FROM transactions
WHERE data_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client;

# средняя сумма покупок за месяц, 
SELECT ROUND(AVG(monthly_total), 2) AS avg_monthly_purchase
FROM (
    SELECT 
        DATE_FORMAT(data_new, '%Y-%m') AS month,
        SUM(Sum_payment) AS monthly_total
    FROM transactions
    WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
    GROUP BY month
) AS monthly_sums;

# количество всех операций по клиенту за период;
SELECT ID_client, COUNT(*) AS count_operations
FROM transactions
WHERE data_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client
ORDER BY count_operations DESC;
