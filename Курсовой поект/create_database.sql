drop database if exists products;
create database products;
use products;

drop table if exists manufacturer;
create table manufacturer(
	id SERIAL primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE 
	
	name VARCHAR(100) unique comment 'Название фирмы',
	country VARCHAR(100) comment 'Страна',
	citie VARCHAR(100) comment 'Город',
	website VARCHAR(100)
);

drop table if exists category;
create table category(
	id SERIAL primary key,
	name VARCHAR(100) comment 'Назавание категории'
);

drop table if exists datasheet_data;
create table datasheet_data(
	id SERIAL primary key,
	`path` VARCHAR(100),
	`data` BLOB 
);

drop table if exists component;
create table component(
	id SERIAL primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE 
	
	designation VARCHAR(100) comment 'название компонента 2N1980',
	description VARCHAR(100) comment 'описание',
	name_id BIGINT unsigned not null comment 'Город',
	manufacturer_id BIGINT unsigned not null,
	
	website VARCHAR(100)
);
