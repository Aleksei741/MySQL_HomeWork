/*
 * Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
	catalogs и products в таблицу logs помещается время и дата создания записи, название
	таблицы, идентификатор первичного ключа и содержимое поля name.
 */

use shop;


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME,
	table_name VARCHAR(50),
	ferst_key_id BIGINT,
	name_value VARCHAR(255)
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS insert_in_users;
delimiter //
CREATE TRIGGER insert_in_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs 
		(created_at, table_name, ferst_key_id, name_value)
	VALUES 
		(NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


DROP TRIGGER IF EXISTS insert_in_catalogs;
delimiter //
CREATE TRIGGER insert_in_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs 
		(created_at, table_name, ferst_key_id, name_value)
	VALUES 
		(NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS insert_in_products;
delimiter //
CREATE TRIGGER insert_in_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs 
		(created_at, table_name, ferst_key_id, name_value)
	VALUES 
		(NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users 
	(name, birthday_at)
VALUES 
	('name1', date(now()));


SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES 
	('Notebook1'),
	('Notebook2')
;


SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, description, price, catalog_id)
VALUES 
	('name1', 'description1', 5000.00, 1),
	('name2', 'description2', 5000.00, 2)
;

