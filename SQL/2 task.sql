# ЗАДАНИЕ 2

# Информацию в разрезе месяцев:

# a) средняя сумма чека в месяц;
SELECT ROUND(AVG(monthly_sum_check), 2) AS avg_check_per_month
FROM (
    SELECT 
        DATE_FORMAT(data_new, '%Y-%m') AS month,
        SUM(Sum_payment) AS monthly_sum_check
    FROM transactions
    WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
    GROUP BY month, Id_check
) AS monthly_checks;

# b) среднее количество операций в месяц;
SELECT ROUND(AVG(monthly_ops), 2) AS avg_operations_per_month
FROM (
    SELECT 
        DATE_FORMAT(data_new, '%Y-%m') AS month,
        COUNT(*) AS monthly_ops
    FROM transactions
    WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
    GROUP BY month
) AS monthly_counts;

# c) среднее количество клиентов, которые совершали операции;
SELECT ROUND(AVG(monthly_active_clients), 2) AS avg_clients_per_month
FROM (
    SELECT 
        DATE_FORMAT(data_new, '%Y-%m') AS month,
        COUNT(DISTINCT ID_client) AS monthly_active_clients
    FROM transactions
    WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
    GROUP BY month
) AS monthly_clients;

# d) долю от общего количества операций за год долю в месяц от общей суммы операций;
SELECT 
    DATE_FORMAT(data_new, '%Y-%m') AS month,
    ROUND(COUNT(*) * 1.0 / (
		SELECT COUNT(*) FROM transactions 
		WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'), 4) AS share_of_operations,
    ROUND(SUM(Sum_payment) * 1.0 / (
		SELECT SUM(Sum_payment) FROM transactions 
		WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'), 4) AS share_of_sum
FROM transactions
WHERE data_new BETWEEN '2015-06-01' AND '2016-05-31'
GROUP BY month
ORDER BY month;

# e) вывести % соотношение M/F/NA в каждом месяце с их долей затрат;
SELECT 
    DATE_FORMAT(t.data_new, '%Y-%m') AS month,
    c.Gender,
    COUNT(DISTINCT t.ID_client) AS clients,
    SUM(t.Sum_payment) AS total_spent
FROM transactions t
JOIN customers c ON t.ID_client = c.Id_client
WHERE t.data_new BETWEEN '2015-06-01' AND '2016-05-31'
GROUP BY month, c.Gender
ORDER BY month, c.Gender;
