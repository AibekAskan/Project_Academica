#  Создание и импорт файлов

CREATE DATABASE customers_transactions;
USE customers_transactions;

# Там где есть пустые значение я задаю NULL значения (для Gender, Age)
UPDATE customers SET Gender = NULL WHERE Gender = '';
UPDATE customers SET Age = NULL WHERE Age = '';

# Меняем тип Age с формата Text на Integer
ALTER TABLE customers MODIFY Age INT NULL;

# Проверяем все ли правильно импортнулся
SELECT * FROM customers; -- все норм

# Создаем таблицу transaction вручную, так как double при импорте теряет точность нежели decimal
CREATE TABLE transactions
(
	data_new DATE,
	Id_check INT,
	ID_client INT,
	Count_products DECIMAL(10,3),
	Sum_payment DECIMAL(10,2)
);

# Была проблема с ';' в excel его не было видно, решил открыв файл в блокноте и вуаля, 
# увидел что после каждой строки есть ';' через найти и заменить удалил, сохранил в формате '.csv' и вуаля, все работает
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\transactions_final.csv"
INTO TABLE transactions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# проверка пути
SHOW VARIABLES LIKE 'secure_file_priv';

# Проверяем все ли правильно импортнулся после доп махинации
SELECT * FROM transactions; -- все гуд