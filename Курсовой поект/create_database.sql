drop database if exists products;
create database products;
use products;

drop table if exists manufacturer;
create table manufacturer(
	id SERIAL primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE 
	
	name VARCHAR(100) unique comment '�������� �����',
	country VARCHAR(100) comment '������',
	citie VARCHAR(100) comment '�����',
	website VARCHAR(100)
);

drop table if exists category;
create table category(
	id SERIAL primary key,
	name VARCHAR(100) comment '��������� ���������'
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
	
	designation VARCHAR(100) comment '�������� ���������� 2N1980',
	description VARCHAR(100) comment '��������',
	name_id BIGINT unsigned not null comment '�����',
	manufacturer_id BIGINT unsigned not null,
	
	website VARCHAR(100)
);
