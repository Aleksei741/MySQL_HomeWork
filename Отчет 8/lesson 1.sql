/*
 * 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
 */

SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

-- DELETE FROM sample.users WHERE id = 1;

SELECT * FROM sample.users;

/*
 * 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
*/
SELECT * FROM shop.products;
SELECT * FROM shop.catalogs;

SELECT shop.products.name AS prod,  shop.catalogs.name AS cat
FROM 
	shop.products
	JOIN
	shop.catalogs
	ON shop.products.catalog_id = shop.catalogs.id
;

CREATE OR REPLACE VIEW name_name (prod, cat)
AS SELECT shop.products.name AS prod,  shop.catalogs.name AS cat
FROM 
	shop.products
	JOIN
	shop.catalogs
	ON shop.products.catalog_id = shop.catalogs.id
;

SELECT * FROM name_name;

/* 3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
 * если дата присутствует в исходном таблице и 0, если она отсутствует.
 */

/*
 * Не понял задание
 */


/*
 *  4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */

DROP database IF EXISTS test;
create database test;

DROP TABLE IF EXISTS test.dat;
CREATE TABLE test.dat (
  id SERIAL PRIMARY KEY,
  created_at DATETIME
);

INSERT INTO test.dat (created_at) VALUES
  ('2018-06-01'),
  ('2016-01-04'),
  ('2018-08-16'),
  ('2018-02-24'),
  ('2018-06-30'),
  ('2019-01-10'),
  ('2019-05-19'),
  ('2019-11-15')
 ;

SELECT * FROM test.dat ORDER BY  created_at DESC;
SELECT id FROM test.dat ORDER BY created_at DESC LIMIT 5;
SELECT MIN(c.created_at) FROM (SELECT * FROM test.dat ORDER BY created_at DESC LIMIT 5) AS c;

DELETE FROM test.dat WHERE test.dat.created_at < (SELECT MIN(c.created_at) FROM (SELECT * FROM test.dat ORDER BY created_at DESC LIMIT 5) AS c);

SELECT * FROM test.dat ORDER BY  created_at DESC;




