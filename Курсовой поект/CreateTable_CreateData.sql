DROP database IF EXISTS CourseProject;
CREATE database CourseProject;
use CourseProject;

/*
 * **************************************************************************************
 */

-- Производитель комплектующих элементов
DROP TABLE IF EXISTS Manufacturer;
CREATE TABLE Manufacturer
(	
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) COMMENT 'Название фирмы производителя',
	country VARCHAR(100),
	city VARCHAR(100),
	website VARCHAR(100),
	create_data DATETIME default NOW()
) COMMENT = 'Производитель комплектующих элементов';

INSERT INTO Manufacturer (id, name, country, city, website)
VALUES
	(1, 'Vishay', 'Unites States', 'Малверн', 'http://www.vishay.com/'),
	(2, 'Diodes', '', '', ''),
	(3, 'Atmel', 'Unites States', 'Сан-Хосе', 'http://www.microchip.com/'),
	(4, 'Murata', '', '', ''),
	(5, 'STMicroelectronics', 'Switzerland', 'Женева', 'https://www.st.com'),
	(6, 'Yageo', ' ', '', ''),
	(7, 'Hitano', 'Taiwan', '', 'http://www.hitano.com.tw'),
	(8, 'ON', 'Unites States', 'Феникс', 'http://www.onsemi.com/'),
	(9, 'Infineon', 'Germany', 'Нойбиберг', 'https://www.infineon.com'),
	(10, 'Ti', 'Unites States', 'Техас', 'http://www.ti.com/'),
	(11, 'Littelfuse', '', '', 'https://www.littelfuse.com/')
;


/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS ComponentType;
CREATE TABLE ComponentType
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
) COMMENT = 'Типы комплектующих';

INSERT INTO ComponentType
VALUES
	(1, 'Розетка'),
	(2, 'Соединитель'),
	(3, 'Диод'),
	(4, 'Микросхема'),
	(5, 'Дроссель'),
	(6, 'Конденсатор'),
	(7, 'Предохранитель'),
	(8, 'Резистор'),
	(9, 'Сборка диодная'),
	(10, 'Транзистор')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Department;
CREATE TABLE Department
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
) COMMENT = 'Подразделения на предприятии';

INSERT INTO Department
VALUES
	(1, 'Заводоуправление'),
	(2, 'Отдел 1'),
	(3, 'Отдел 2'),	
	(4, 'Цех 1'),
	(5, 'Цех 2'),
	(6, 'Склад 1')	
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS FunctionEmployees;
CREATE TABLE FunctionEmployees
(
	id SERIAL PRIMARY KEY,
	namefunction VARCHAR(100)
) COMMENT = 'Должность';

INSERT INTO FunctionEmployees
VALUES
	(1, 'Главнюк'),
	(2, 'Рукаводитель подразделения'),
	(3, 'Инженер-конструктор'),
	(4, 'Техник-конструктор'),
	(5, 'Монтажник')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS CompanyEmployees;
CREATE TABLE CompanyEmployees
(
	id SERIAL PRIMARY KEY,
	firstname varchar(100),
	lastname VARCHAR(100),
	middlename VARCHAR(100),
	department_id BIGINT UNSIGNED COMMENT 'Отдел, в котором раб',
	function_id BIGINT UNSIGNED COMMENT 'Должность',
	birthday_at DATE COMMENT 'Дата рождения',
	employed_at DATETIME DEFAULT now() COMMENT 'Работает от',
	-- pathfile VARCHAR(100) COMMENT 'Путь к файлу',
	dismissed BOOL default FALSE,
	
	INDEX firstname_lastname_idx(firstname, lastname),
	
	foreign key (department_id) references Department(id)
	ON DELETE SET NULL 
	ON UPDATE CASCADE,
	
	foreign key (function_id) references FunctionEmployees(id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
) COMMENT = 'Сотрудники предприятия';

INSERT INTO CompanyEmployees(id, firstname, lastname, middlename, department_id, function_id, birthday_at)
VALUES
	(1, 'Главный', 'Главнюк', 'в7поколении', 1, 1, '1979-06-20'),
	(2, 'Имя1', 'Фамилия1', 'Отчество1', 2, 2, '1985-07-25'),
	(3, 'Имя2', 'Фамилия2', 'Отчество2', 2, 3, '1990-12-19'),
	(4, 'Имя3', 'Фамилия3', 'Отчество3', 3, 2, '1989-08-17'),
	(5, 'Имя4', 'Фамилия4', 'Отчество4', 3, 3, '1993-09-05'),
	(6, 'Имя5', 'Фамилия5', 'Отчество5', 3, 4, '1998-03-12'),
	(7, 'Имя6', 'Фамилия6', 'Отчество6', 4, 2, '1991-06-28'),
	(8, 'Имя7', 'Фамилия7', 'Отчество7', 4, 5, '1993-05-22'),
	(9, 'Имя8', 'Фамилия8', 'Отчество8', 5, 2, '1995-06-15'),
	(10, 'Имя9', 'Фамилия9', 'Отчество9', 5, 5, '1994-01-05'),
	(11, 'Имя10', 'Фамилия10', 'Отчество10', 6, 2, '1985-06-07')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS ComponentsDatasheet;
CREATE TABLE ComponentsDatasheet
(
	id SERIAL PRIMARY KEY,
	pathfile VARCHAR(200) COMMENT 'Путь к файлу',
	-- `data` BLOB COMMENT 'datasheet',
	`date` DATETIME DEFAULT NOW() COMMENT 'Дата регистрации'
);

INSERT INTO ComponentsDatasheet(id, pathfile)
VALUES
	(1, '/mnt/dev/datasheet/file1.pdf'),
	(2, '/mnt/dev/datasheet/file2.pdf'),
	(3, '/mnt/dev/datasheet/file3.pdf'),
	(4, '/mnt/dev/datasheet/file4.pdf'),
	(5, '/mnt/dev/datasheet/file5.pdf'),
	(6, '/mnt/dev/datasheet/file6.pdf'),
	(7, '/mnt/dev/datasheet/file7.pdf'),
	(8, '/mnt/dev/datasheet/file8.pdf'),
	(9, '/mnt/dev/datasheet/file9.pdf'),
	(10, '/mnt/dev/datasheet/file10.pdf'),
	(11, '/mnt/dev/datasheet/file11.pdf')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Components;
CREATE TABLE Components
(
	id SERIAL PRIMARY KEY,
	-- partnumber VARCHAR(100) 'Номер части',
	partname VARCHAR(100) COMMENT 'Имя части',
	-- partlable VARCHAR(100) '"Этикетка',
	description TEXT COMMENT 'Описание',
	type_id BIGINT UNSIGNED COMMENT 'тип',
	manufacturer_id BIGINT UNSIGNED COMMENT 'Производитель',
	document_id BIGINT UNSIGNED COMMENT 'Документация',
	createdata DATETIME DEFAULT NOW() COMMENT 'Дата регистрации',
	
	INDEX firstname_lastname_idx(partname),
	
	foreign key (type_id) references ComponentType(id)
	ON DELETE SET NULL 
	ON UPDATE CASCADE,
	
	foreign key (manufacturer_id) references Manufacturer(id)
	ON DELETE SET NULL 
	ON UPDATE CASCADE,
	
	foreign key (document_id) references ComponentsDatasheet(id)
	ON DELETE SET NULL 
	ON UPDATE CASCADE
);

INSERT INTO Components (id, partname, description, type_id, manufacturer_id, document_id)
VALUES
	(1, 'PBSM-4', 'шаг 2.54 мм, 4 контакта', 1, NULL, NULL),
	(2, 'GS1M', '1А, 1000В', 3, 1, 1),
	(3, 'ESD9L3.3ST5G', '3.3В TVS', 3, 8, 2),
	(4, 'SMBJ33A-E3/52', '3.3В TVS', 3, 1, 3),
	(5, 'BLM15AX601SN1D', '600 Ом ±25% 100 МГц 420 мА', 5, 4, 4),
	(6, 'CC0402KRX7R5BB104', 'X7R 0.1 мкФ 6.3В ±10%', 6, 6, 5),
	(7, 'T491A106M006AT', 'Танталовый 10мкФ 6.3В (6В) 20%', 6, 6, 5),
	(8, 'CC0402KRX7R9BB472', 'X7R 4700 пФ 50В ±10%', 6, 6, 5),
	(9, 'NCV7321D10R2G', 'Драйвер LIN', 4, 8, 6),
	(10, 'TLE5009-E1010', 'Датчик угла', 4, 9, 7),
	(11, 'TL431IDBZR.215', 'ИОН, 2.5В ±2% ', 4, 10, 8),
	(12, 'STM8S005K6T6C', 'Микроконтроллер', 4, 5, 9),
	(13, 'LP-NSM012', 'Самовосcт. 120мА 30В', 7, 11, 10),
	(14, 'LP-NSM005', 'Самовосcт. 50мА 60В.', 7, 11, 10),
	(15, 'RC0603JR-071R5L', '1.5 Ом ±5% -200/+300ppm', 8, 6, 11),
	(16, 'RC1206JR-074K7L', '4.7 кОм ±5% ±250ppm', 8, 6, 11),
	(17, 'RC0402JR-0710KL', '10 кОм ±5% ±200ppm', 8, 6, 11),
	(18, 'RC0603JR-07100RL', '100 Ом ±5% ±100ppm', 8, 6, 11),
	(19, 'RC0402JR-071KL', '1 кОм ±5% ±200ppm', 8, 6, 11),
	(20, 'RC0402JR-072K2L', '2.2 кОм ±5% ±200ppm', 8, 6, 11)
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS DocumentType;
CREATE TABLE DocumentType
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)	
) COMMENT = 'Типы документов';

INSERT INTO DocumentType
VALUES
	(1, 'Схема'),
	(2, 'Схема электрическая соединений'),
	(3, 'Схема электрическая принципиальная'),
	(4, 'Технические условия'),
	(5, 'Техническое задание'),
	(6, 'Эскиз'),
	(7, 'Методика испытаний'),
	(8, 'Инструкция по настройке'),
	(9, 'Чертеж'),
	(10, 'Спецификация'),
	(11, 'Перечень элементов')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Documents;
CREATE TABLE Documents
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) COMMENT 'Имя документа',
	type_id BIGINT UNSIGNED COMMENT 'тип документа',
	creator_id BIGINT UNSIGNED COMMENT 'Создал',
	cheking_id BIGINT UNSIGNED COMMENT 'Проверил',
	mod_id BIGINT UNSIGNED COMMENT 'Изменил',
	create_data DATETIME DEFAULT NOW() COMMENT 'Дата создания',
	last_mod_data DATETIME DEFAULT NOW() COMMENT 'Дата последнего изменения',
	decimal_number VARCHAR(100) COMMENT 'Децимальный номер',
	pathfile VARCHAR(100) COMMENT 'Путь к файлу',
	-- `data` BLOB,
	
	INDEX Documents_decimal_number_idx(decimal_number),
	
	foreign key (type_id) references DocumentType(id)
	ON DELETE SET NULL 
	ON UPDATE CASCADE,
	
	foreign key (creator_id) references CompanyEmployees(id)
	ON DELETE NO ACTION 
	ON UPDATE CASCADE,
	foreign key (cheking_id) references CompanyEmployees(id)
	ON DELETE NO ACTION 
	ON UPDATE CASCADE,
	foreign key (mod_id) references CompanyEmployees(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE	
) COMMENT = 'Хранимые документы на изделие';

INSERT INTO Documents (id, name, type_id, creator_id, cheking_id, decimal_number, pathfile)
VALUES
	(1, 'Датчик наклона', 3, 3, 2, 'ЭЮЯИ.345321.001', '/mnt/dev/dokuments/file1.tif'),
	(2, 'Датчик наклона', 11, 3, 2, 'ЭЮЯИ.345321.001', '/mnt/dev/dokuments/file2.tif'),
	(3, 'Датчик температуры', 3, 5, 4, 'ЭЮЯИ.455821.003', '/mnt/dev/dokuments/file3.tif'),
	(4, 'Датчик температуры', 11, 6, 4, 'ЭЮЯИ.455821.003', '/mnt/dev/dokuments/file4.tif'),
	(5, 'Блок контроля', 3, 3, 2, 'ЭЮЯИ.658941.010', '/mnt/dev/dokuments/file5.tif'),
	(6, 'Блок контроля', 11, 3, 2, 'ЭЮЯИ.658941.010', '/mnt/dev/dokuments/file6.tif')
;

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Products;
CREATE TABLE Products
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) COMMENT 'Имя',
	decimal_number VARCHAR(100) COMMENT 'Децимальный номер',
	description TEXT COMMENT 'Описание',
	model VARCHAR(50) COMMENT 'сокращенное название модели',
	create_data DATETIME DEFAULT NOW() COMMENT 'Дата создания',
	last_mod_data DATETIME DEFAULT NOW() COMMENT 'Дата последнего изменения',
	creator_id BIGINT UNSIGNED COMMENT 'Создал',
	mod_id BIGINT UNSIGNED COMMENT 'Изменил',
	
	INDEX Products_decimal_number_idx(decimal_number),
	
	foreign key (creator_id) references CompanyEmployees(id)
	ON DELETE NO ACTION 
	ON UPDATE CASCADE,
	
	foreign key (mod_id) references CompanyEmployees(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
	
) COMMENT = 'Продукция';

INSERT INTO Products (id, name, decimal_number, description, model, creator_id)
VALUES
	(1, 'Датчик наклона', 'ЭЮЯИ.345321.001', 'Датчик наклона с цифровым выходом k-line. Адресс 0x5A', 'ДН1.01', 3),
	(2, 'Датчик наклона', 'ЭЮЯИ.345321.002', 'Датчик наклона с цифровым выходом k-line. Адресс 0x6F', 'ДН1.02', 3),
	(3, 'Датчик температуры', 'ЭЮЯИ.455821.003', 'Датчик температуры с цифровым выходом k-line. Адресс 0x44', 'ДП1', 5),
	(4, 'Блок контроля', 'ЭЮЯИ.658941.010', 'Блок обработки данных с датчиков и передачи по линии CAN', 'БК10', 2)
;


/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Products_Component;
CREATE TABLE Products_Component
(
	products_id BIGINT UNSIGNED NOT NULL COMMENT 'Изделие в котором устанавливается компонент',
	component_id BIGINT UNSIGNED NOT NULL COMMENT 'Компонент',
	`position` VARCHAR(50) NOT NULL COMMENT 'Позиция',
	`count` TINYINT NOT NULL COMMENT 'Количество',
	note VARCHAR(100) COMMENT 'Примечание',
	
	foreign key (products_id) references Products(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	foreign key (component_id) references Components(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
) COMMENT = 'Состав компонентов в продукте';

INSERT INTO Products_Component (products_id, component_id, `position`, `count`, note)
VALUES
	(1, 1, 'X1', 1, ''),
	(1, 2, 'VD1', 1, ''),
	(1, 5, 'L1', 1, ''),
	(1, 12, 'DD1', 1, 'Устанавливать по ключу'),
	(1, 15, 'R1, R2, R3, R6', 4, ''),
	(1, 6, 'C1, C2, C3', 3, ''),
	(1, 18, 'R4, R5', 2, ''),
	(1, 9, 'DD2', 1, ''),
	(1, 10, 'DA1', 1, ''),
	(2, 1, 'X1', 1, ''),
	(2, 2, 'VD1', 1, ''),
	(2, 5, 'L1', 1, ''),
	(2, 12, 'DD1', 1, 'Устанавливать по ключу'),
	(2, 15, 'R1, R2, R3, R6', 4, ''),
	(2, 6, 'C1, C2, C3', 3, ''),
	(2, 18, 'R4, R5', 2, ''),
	(2, 9, 'DD2', 1, ''),
	(2, 10, 'DA1', 1, ''),
	(3, 20, 'R8, R6, R9', 3, ''),
	(3, 19, 'R1, R2, R3, R4, R5', 5, ''),
	(3, 17, 'R7', 1, ''),
	(3, 12, 'DD1', 1, 'Устанавливать по ключу'),
	(3, 9, 'DD2', 1, ''),
	(3, 11, 'DA1', 1, ''),
	(3, 7, 'C5, C6', 2, ''),
	(3, 6, 'C1, C2, C3, C4', 4, ''),
	(4, 12, 'DD1', 1, ''),
	(4, 3, 'VD1', 1, ''),
	(4, 4, 'VD2', 1, ''),
	(4, 1, 'X1', 1, ''),
	(4, 7, 'C3, C4', 2, ''),
	(4, 6, 'C1, C2, C5, C6, C8', 5, ''),
	(4, 8, 'C7', 1, ''),
	(4, 20, 'R8, R6, R9', 3, ''),
	(4, 19, 'R1, R2, R3, R4, R5', 5, ''),
	(4, 17, 'R7', 1, ''),
	(4, 9, 'DA1', 1, '');

/*
 * **************************************************************************************
 */

DROP TABLE IF EXISTS Products_Documents;
CREATE TABLE Products_Documents
(
	products_id BIGINT UNSIGNED NOT NULL COMMENT 'Изделие в котором устанавливается компонент',
	document_id BIGINT UNSIGNED NOT NULL COMMENT 'Компонент',
	
	foreign key (products_id) references Products(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	foreign key (document_id) references Documents(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
) COMMENT = 'Документы для изделия';

INSERT INTO Products_Documents (products_id, document_id)
VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(3, 3),
	(3, 4),
	(4, 5),
	(4, 6)
;

/*
 * **************************************************************************************
 */


DROP TABLE IF EXISTS Products_Counts;
CREATE TABLE Products_Counts
(
	products_id BIGINT UNSIGNED NOT NULL COMMENT 'Изделие',
	department_id BIGINT UNSIGNED NOT NULL COMMENT 'Подразделение, в которм хранится изделие',
	`count` SMALLINT UNSIGNED NOT NULL COMMENT 'Количество',
	
	foreign key (products_id) references Products(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	foreign key (department_id) references Department(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
) COMMENT = 'Нахождение продукции';

INSERT INTO Products_Counts (products_id, department_id, `count`)
VALUES
	(1, 2, 2),
	(1, 6, 16),
	(2, 2, 1),
	(2, 6, 44),
	(3, 2, 1),
	(4, 2, 1),
	(4, 6, 5)
;	

/*
 * **************************************************************************************
 */


DROP TABLE IF EXISTS Component_Counts;
CREATE TABLE Component_Counts
(
	component_id BIGINT UNSIGNED NOT NULL COMMENT 'Изделие',
	department_id BIGINT UNSIGNED NOT NULL COMMENT 'Подразделение, в которм хранится изделие',
	`count` SMALLINT UNSIGNED NOT NULL COMMENT 'Количество',
	price FLOAT NOT NULL COMMENT 'Цена последней покупки',
	
	INDEX Component_Counts_component_id_idx(component_id),
	
	foreign key (component_id) references Components(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	
	foreign key (department_id) references Department(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
) COMMENT = 'Нахождение продукции';


INSERT INTO Component_Counts (component_id, department_id, `count`, price)
VALUES
	(1, 6, 106, 0.5),
	(2, 6, 1004, 11),
	(3, 6, 525, 20.21),
	(4, 6, 698, 24.6),
	(5, 6, 126, 79.85),
	(6, 6, 1569, 0.15),
	(7, 6, 2100, 0.35),
	(8, 6, 706, 0.35),
	(9, 6, 29, 78),
	(10, 6, 9, 152.95),
	(11, 6, 58, 42.85),
	(12, 6, 20, 220.75),
	(13, 6, 1089, 5.25),
	(14, 6, 782, 4.75),
	(15, 6, 5489, 0.15),
	(16, 6, 15436, 0.05),
	(17, 6, 324, 0.35),
	(18, 6, 32, 0.15),
	(19, 6, 1233, 0.25),
	(20, 6, 156, 0.45),
	(3, 2, 15, 20.21)
;	

