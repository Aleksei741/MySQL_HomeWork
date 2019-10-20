


/*
*1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

DROP DATABASE IF EXISTS kraev_home_work;
CREATE DATABASE kraev_home_work;
USE kraev_home_work;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    created_at VARCHAR(50),
    updated_at VARCHAR(50)
);

INSERT INTO 
	`users` (`firstname`, `lastname`) 
VALUES 
	('Elvie', 'Braun'),
	('Herman', 'Friesen'),
	('Eriberto', 'Fisher'),
	('Drake', 'Haley'),
	('Lucile', 'Thompson')
;

update users 
set
	created_at = now(),
	updated_at = now()
;

/*
*2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
*и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME,
*сохранив введеные ранее значения.
*/

DROP TABLE IF EXISTS users2;
CREATE TABLE users2 (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    created_at VARCHAR(50),
    updated_at VARCHAR(50)
);


INSERT INTO 
	`users2` (`firstname`, `lastname`, created_at, updated_at) 
VALUES 
	('Elvie', 'Braun', '20.10.2013 4:10', '20.09.2019 14:13'),
	('Herman', 'Friesen', '5.03.2012 15:40', '13.12.2018 23:40'),
	('Eriberto', 'Fisher', '03.2.2015 13:55', '23.11.2017 8:15'),
	('Drake', 'Haley', '11.01.2010 16:20', '09.08.2015 4:05'),
	('Lucile', 'Thompson', '30.12.2017 12:39', '03.05.2019 2:10')
;

update 
	users2
set
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i')
;

select STR_TO_DATE('20.09.2019 14:13', '%d.%m.%Y %H:%i');

ALTER TABLE kraev_home_work.users2 MODIFY COLUMN created_at DATETIME;
ALTER TABLE kraev_home_work.users2 MODIFY COLUMN updated_at DATETIME;

/*
 * В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.
 */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    name_product VARCHAR(50),
    value smallint
);

INSERT INTO 
	storehouses_products (name_product, value) 
VALUES 
	('Товар 1', 10),
	('Товар 2', 20),
	('Товар 3', 0),
	('Товар 4', 3),
	('Товар 5', 13),
	('Товар 6', 5),
	('Товар 7', 2),
	('Товар 8', 0),
	('Товар 9', 17),
	('Товар 10', 0),
	('Товар 11', 1)
;

select * from storehouses_products order by 1/value DESC;

/*
 * (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий ('may', 'august')
 */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthday VARCHAR(50)
);



INSERT INTO 
	`users` (`firstname`, `lastname`, birthday) 
VALUES 
	('Elvie', 'Braun', '20 may 2013'),
	('Herman', 'Friesen', '20 september 2013'),
	('Eriberto', 'Fisher', '20 august 2013'),
	('Drake', 'Haley', '20 December 2013'),
	('Lucile', 'Thompson', '20 January 2013')
;

select monthname(STR_TO_DATE(birthday, '%d %M %Y')) from users;

select * from users where monthname(STR_TO_DATE(birthday, '%d %M %Y')) in  ('may', 'august');

/*
 * (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * Отсортируйте записи в порядке, заданном в списке IN.
 */

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    name VARCHAR(50)
);

INSERT INTO 
	catalogs (name) 
VALUES 
	('запись 1'),
	('запись 2'),
	('запись 3'),
	('запись 4'),
	('запись 5'),
	('запись 6'),
	('запись 7'),
	('запись 8')
;

SELECT * FROM catalogs WHERE id IN (5, 1, 2);
SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by field (id, 5, 1, 2); 

/*
 * Подсчитайте средний возраст пользователей в таблице users
 */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthday VARCHAR(50)
);

INSERT INTO 
	`users` (`firstname`, `lastname`, birthday) 
VALUES 
	('Elvie', 'Braun', '20 may 1996'),
	('Herman', 'Friesen', '20 september 2013'),
	('Eriberto', 'Fisher', '20 august 2000'),
	('Drake', 'Haley', '20 December 1990'),
	('Lucile', 'Thompson', '20 January 1998')
;



select  avg(year(now()) - year(STR_TO_DATE(birthday, '%d %M %Y'))) from users;


/*
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 * 
*/

DROP TABLE IF EXISTS birthday_table;
CREATE TABLE birthday_table (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    birthday datetime
);


INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('1', '2000-02-05 05:31:13');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('2', '2009-10-27 12:27:18');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('3', '1999-12-31 07:50:24');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('4', '2010-02-01 07:32:26');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('5', '2000-05-13 10:14:32');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('6', '1999-12-07 00:11:43');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('7', '1974-03-06 00:17:13');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('8', '2004-12-15 05:32:56');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('9', '2006-04-27 14:56:58');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('10', '1973-03-22 14:04:16');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('11', '2013-05-30 05:57:13');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('12', '1997-06-24 20:28:47');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('13', '1999-07-09 22:59:45');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('14', '1984-10-02 05:57:34');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('15', '1995-03-23 19:52:21');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('16', '2016-09-11 07:41:15');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('17', '1997-05-12 17:06:47');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('18', '1984-07-06 02:17:19');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('19', '1975-08-15 20:02:41');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('20', '2012-04-21 14:32:06');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('21', '1974-06-28 20:56:23');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('22', '1988-04-29 21:02:12');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('23', '1974-10-27 21:22:36');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('24', '1990-04-12 13:58:05');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('25', '1971-04-09 07:44:47');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('26', '1982-09-18 04:46:26');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('27', '1970-06-26 08:32:24');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('28', '2001-09-16 21:24:12');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('29', '2019-02-21 02:01:27');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('30', '2017-02-12 12:32:11');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('31', '2001-06-28 23:44:29');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('32', '1985-03-14 00:45:57');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('33', '2018-12-04 06:18:23');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('34', '1985-07-16 21:26:51');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('35', '1989-12-31 00:59:37');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('36', '2007-08-12 19:03:45');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('37', '2000-11-11 02:22:07');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('38', '1980-03-10 17:10:13');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('39', '1986-10-03 18:52:28');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('40', '1986-11-18 15:21:27');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('41', '1999-03-20 14:37:02');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('42', '2018-09-16 11:27:45');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('43', '1972-03-20 23:59:06');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('44', '2007-07-13 05:45:18');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('45', '1973-01-03 17:37:28');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('46', '2003-11-13 01:53:58');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('47', '1978-03-10 20:41:23');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('48', '2000-04-30 13:35:13');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('49', '1997-04-05 19:24:59');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('50', '1980-05-02 11:12:31');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('51', '1996-11-03 16:18:37');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('52', '1973-04-25 13:58:27');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('53', '2015-07-19 16:07:41');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('54', '2003-07-27 14:19:53');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('55', '2002-11-22 03:03:53');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('56', '1999-01-23 10:04:01');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('57', '1988-07-31 10:59:54');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('58', '2001-02-11 01:17:01');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('59', '1998-04-09 06:31:56');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('60', '2013-02-05 20:39:34');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('61', '1971-04-12 18:21:24');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('62', '1972-11-06 11:53:24');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('63', '2004-08-13 06:07:42');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('64', '2017-12-31 01:25:07');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('65', '2019-05-08 11:02:55');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('66', '2007-04-12 04:06:01');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('67', '1999-07-22 11:29:16');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('68', '1984-07-25 02:37:59');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('69', '1983-07-09 16:10:58');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('70', '1981-08-27 13:06:20');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('71', '2017-09-19 00:54:16');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('72', '1977-07-14 01:18:53');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('73', '1983-09-11 04:43:55');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('74', '1982-12-26 04:30:25');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('75', '2012-02-25 22:13:10');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('76', '1983-08-17 04:32:58');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('77', '1977-02-09 21:33:55');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('78', '2004-06-02 05:29:40');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('79', '1976-01-05 17:18:18');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('80', '2014-09-26 13:12:16');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('81', '1979-03-28 10:56:08');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('82', '1974-02-23 13:58:27');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('83', '2017-10-24 10:51:46');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('84', '1979-02-13 19:36:30');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('85', '2009-09-09 08:22:45');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('86', '1987-07-29 01:45:20');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('87', '1970-11-01 09:36:43');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('88', '1970-03-11 05:52:14');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('89', '1999-10-26 19:13:53');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('90', '2017-08-02 18:03:19');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('91', '1985-10-03 00:09:53');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('92', '2010-06-02 09:41:49');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('93', '1995-11-11 18:43:49');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('94', '2019-10-13 02:06:48');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('95', '1996-11-17 01:00:44');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('96', '1988-12-23 15:27:33');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('97', '2006-06-17 06:24:05');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('98', '2012-09-19 03:53:05');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('99', '2009-01-25 01:56:10');
INSERT INTO `birthday_table` (`id`, `birthday`) VALUES ('100', '2008-03-16 08:53:41');



-- order by birthday
select DAYNAME(birthday) = 'Sunday' from birthday_table;

select 
	year(`birthday`) as birthday_year, 
	count(*) as `all_in_year`,
	count(case 
				when DAYNAME(birthday) <=> 'Monday' then 1
				else null
		  end) as Monday,
	count(case 
				when DAYNAME(birthday) <=> 'Tuesday' then 1
				else null
		  end) as Tuesday,	 
	count(case 
				when DAYNAME(birthday) <=> 'Wednesday' then 1
				else null
		  end) as Wednesday,
	count(case 
				when DAYNAME(birthday) <=> 'Thursday' then 1
				else null
		  end) as Thursday,
	count(case 
				when DAYNAME(birthday) <=> 'Friday' then 1
				else null
		  end) as Friday,
	count(case 
				when DAYNAME(birthday) <=> 'Saturday' then 1
				else null
		  end) as Saturday,
	count(case 
				when DAYNAME(birthday) <=> 'Sunday' then 1
				else null
		  end) as Sunday
from birthday_table
group by 
	birthday_year
order by 
	birthday_year;


/*
 * (по желанию) Подсчитайте произведение чисел в столбце таблицы
 */


DROP TABLE IF EXISTS _table_;
CREATE TABLE _table_ (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    `number` INT
);

INSERT INTO `_table_` (`number`) 
VALUES 
	(1),
	(2),
	(3),
	(4),
	(5);


SELECT ceil(exp(sum(ln(`number`)))) as proizvedenie FROM `_table_`;

