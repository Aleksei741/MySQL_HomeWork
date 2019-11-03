/*
 * 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер",
 * с 00:00 до 6:00 — "Доброй ночи".
 */
DROP database IF EXISTS test;
create database test;
USE test;
DELIMITER ||
CREATE FUNCTION hello()
RETURNS TEXT NO SQL
BEGIN
	DECLARE var TINYINT DEFAULT HOUR(now());
	
	IF (var >= 6 AND var < 12) THEN
		RETURN 'Доброе утро';
	ELSEIF (var >= 12 AND var < 18) THEN
		RETURN 'Добрый день';
	ELSEIF (var >= 18) THEN
		RETURN 'Добрый вечер';
	ELSEIF (var >= 0 AND var < 6) THEN
		RETURN 'Доброй ночи';
	END IF;
END||

DELIMITER ;

SELECT hello();

-- SELECT HOUR(now());

DROP FUNCTION IF EXISTS hello;


/*
 * 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */
USE shop; 

DELIMITER //
DROP TRIGGER IF EXISTS shop_products_insert_not_two_null//
CREATE TRIGGER shop_products_insert_not_two_null BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF ((NEW.name IS NULL) AND (NEW.description IS NULL)) THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, not two null' ;
	END IF;
END //

-- INSERT INTO products (name, description, price, catalog_id) VALUES (NULL, NULL, 7890.00, 1);
 
-- INSERT INTO products (name, description, price, catalog_id) VALUES ('NULL', NULL, 123, 1);

-- INSERT INTO products (name, description, price, catalog_id) VALUES (NULL, 'NULL', 456, 1);

DROP TRIGGER IF EXISTS shop_products_update_not_two_null//
CREATE TRIGGER shop_products_update_not_two_null BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF ((NEW.name IS NULL) AND (OLD.description IS NULL)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, not two null (NEW.name IS NULL, OLD.description IS NULL)' ;
	ELSEIF ((OLD.name IS NULL) AND (NEW.description IS NULL)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled, not two null (OLD.name IS NULL, NEW.description IS NULL)' ;
	END IF;
END //

-- UPDATE products SET name = NULL WHERE description IS NULL;

-- UPDATE products SET description = NULL WHERE name IS NULL;
/* 
 * 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 * Вызов функции FIBONACCI(10) должен возвращать число 55.
 */
DELIMITER ;
USE test;
DELIMITER ||
DROP FUNCTION IF EXISTS fibonachi||
CREATE FUNCTION fibonachi (number_fibonachi INT)
RETURNS INT NO SQL
BEGIN
	DECLARE result_f INT DEFAULT 2;
	DECLARE last_result_f INT DEFAULT 1;
	DECLARE bufer INT DEFAULT 0;
	
	IF number_fibonachi = 0 THEN
		SET result_f = 0;
	ELSEIF number_fibonachi = 1 THEN
		SET result_f = 1;
	ELSEIF number_fibonachi = 2 THEN
		SET result_f = 1;
	ELSE
		WHILE number_fibonachi > 3 DO
			SET bufer = result_f;
			SET result_f = result_f + last_result_f;
			SET last_result_f = bufer;
		
			SET number_fibonachi = number_fibonachi - 1;
		END WHILE;
	END IF;
	
	RETURN result_f;
END||

DELIMITER ;

SELECT fibonachi(10);


