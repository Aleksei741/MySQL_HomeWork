use CourseProject;

SELECT * FROM Components;

-- список покупных
SELECT 
	c.partname AS 'Название компонента',
	c.description 'Описание',
	ct.name AS 'тип',
	m.name AS 'Производитель',
	cd.pathfile AS 'datasheet'
FROM Components AS c
JOIN Manufacturer AS m ON c.type_id = m.id
JOIN ComponentsDatasheet AS cd ON c.type_id = cd.id
JOIN ComponentType ct ON c.type_id = ct.id
;

SELECT * FROM Products

SELECT @select_id := 1;

-- перечень элементов
SELECT 
	pc.`position` AS 'Позиционное обозначение',
	c.partname AS 'Наименование',
	m.name AS 'изготовитель',
	pc.count AS 'кол-во',
	pc.note AS 'Примичание'
FROM Products_Component pc
JOIN Components c ON pc.component_id = c.id
JOIN Manufacturer AS m ON c.type_id = m.id
WHERE pc.products_id = @select_id
ORDER BY pc.`position`;

-- Разрабатываемые устройства
SELECT 
	p.name AS 'Децимальный номер',
	p.description AS 'Описание',
	p.model AS 'модель',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE p.creator_id = CE.id) AS 'Ведущий'
FROM Products p;


SELECT * FROM courseproject.documents;

SELECT @select_id := 1;

-- Документ
SELECT 
	d.name AS 'Название документа',
	(SELECT name FROM DocumentType WHERE d.type_id = id) AS 'Тип документа',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.creator_id = CE.id) AS 'Ведущий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.cheking_id = CE.id) AS 'Проверяющий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.mod_id = CE.id) AS 'Изменил',
	d.create_data AS 'Дата создания',
	d.last_mod_data AS 'Дата последнего изменения',
	d.decimal_number AS 'Децимальный номер',
	d.pathfile AS 'Расположение файла'
FROM documents d
WHERE d.id = @select_id;

SELECT price_components_in_products(3);

SELECT 
	d.name AS 'Название документа',
	(SELECT name FROM DocumentType WHERE d.type_id = id) AS 'Тип документа',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.creator_id = CE.id) AS 'Ведущий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.cheking_id = CE.id) AS 'Проверяющий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.mod_id = CE.id) AS 'Изменил',
	d.create_data AS 'Дата создания',
	d.last_mod_data AS 'Дата последнего изменения',
	d.decimal_number AS 'Децимальный номер',
	d.pathfile AS 'Расположение файла'
FROM documents d
WHERE d.id = @select_id;



-- Документы на изделе
SELECT @request_dec := 'ЭЮЯИ.345321.002';

SELECT 
	d.name AS 'Название документа',
	(SELECT name FROM DocumentType WHERE d.type_id = id) AS 'Тип документа',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.creator_id = CE.id) AS 'Ведущий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.cheking_id = CE.id) AS 'Проверяющий',
	(SELECT concat(CE.firstname, ' ', CE.lastname, ' ', CE.middlename) FROM CompanyEmployees CE WHERE d.mod_id = CE.id) AS 'Изменил',
	d.create_data AS 'Дата создания',
	d.last_mod_data AS 'Дата последнего изменения',
	d.decimal_number AS 'Децимальный номер',
	d.pathfile AS 'Расположение файла'
FROM products p
JOIN products_documents pd ON p.id = pd.products_id
JOIN documents d ON d.id = pd.document_id 
WHERE 
p.decimal_number = @request_dec
;