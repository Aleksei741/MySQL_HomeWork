USE kraev_home_work;

/*Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

INSERT INTO `users` (name, birthday_at, created_at, updated_at) VALUES 
('ferstname1 lastname1','1980-06-10','2015-11-24 06:20:02','1989-11-12 05:34:04'),
('ferstname2 lastname2','1980-06-10','2015-11-24 06:20:02','1989-11-12 05:34:04'),
('ferstname3 lastname3','1980-06-10','2015-11-24 06:20:02','1989-11-12 05:34:04'),
('ferstname4 lastname4','1980-06-10','2015-11-24 06:20:02','1989-11-12 05:34:04');

select * from users;

select * from orders;

select *
from users
where exists (select 1 from orders where users.id = orders.user_id)

/*Выведите список товаров products и разделов catalogs, который соответствует товару.*/
 
 INSERT INTO catalogs VALUES
  (101, 'Процессоры'),
  (102, 'Материнские платы'),
  (103, 'Видеокарты'),
  (104, 'Жесткие диски'),
  (105, 'Оперативная память');
 
INSERT INTO products
  (name, desription, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 101),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 101),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 101),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 101),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 102),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 102),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 102);
 
select * from catalogs;

SELECT
  products.name,
  catalogs.name
from products join catalogs   
on catalogs.id = products.catalog_id;


/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов. */

DROP DATABASE IF EXISTS kraev_home_work2;
CREATE DATABASE kraev_home_work2;
USE kraev_home_work2;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255)
);

INSERT INTO flights (`from`, `to`)
VALUES
('Moscow', 'St. Petersburg'),
('Yekaterinburg', 'Tomsk'),
('Omsk', 'St. Petersburg'),
('Moscow', 'Tagil'),
('Yekaterinburg', 'St. Petersburg'),
('Moscow', 'Tomsk'),
('Moscow', 'St. Petersburg'),
('Tagil', 'St. Petersburg')
;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO cities  
VALUES
('Moscow', 'Москва'),
('St. Petersburg', 'Санкт-петербург'),
('Yekaterinburg', 'Екатеринбург'),
('Tomsk', 'Томск'),
('Omsk', 'Омск'),
('Tagil', 'Тагил')
;

select * from flights;
select * from cities;

select * from catalogs;

select
  cities.name
from cities join flights
on cities.label = flights.`from`;

select
  cities.name
from cities join flights
on cities.label = flights.`to`;

select 
	flights.id,
	(select cities.name from cities where cities.label = flights.`from`),
	(select cities.name from cities where cities.label = flights.`to`)	
from
	flights 
	

