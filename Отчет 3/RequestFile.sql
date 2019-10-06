


create table users(
	-- первичный ключ
	id SERIAL primary key, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE 
	
	firstname VARCHAR(100) comment 'Имя',
	lastname VARCHAR(100) comment 'Фамилия',
	email VARCHAR(100) unique,
	password_hash VARCHAR(100),
	-- phone VARCHAR,
	phone bigint,
	
	-- индексы	
	index users_phone_idx(phone), 
	index (firstname, lastname) -- для быстрого поиска людей по ФИО	
	
	-- внешние ключи
);


create table `profiles`(
	user_id SERIAL primary key,
	gender CHAR(1),
	birthday DATE,
	photo_id BIGINT unsigned null,
	hometown varchar(100),
	created_at DATETIME default NOW()
);

alter table `profiles`
	add constraint fk_user_id
	foreign key (user_id) references users(id)
	on update cascade
	on delete restrict
;


create table `massages`(
	id SERIAL primary key,
	from_user_id BIGINT unsigned not null,
	to_user_id BIGINT unsigned not null,
	body text,
	created_at DATETIME default NOW(),
	
	index (from_user_id),
	index (to_user_id),
	foreign key (from_user_id) references users(id),
	foreign key (to_user_id) references users(id)
);



create table `friend_requests`(
	initiator_user_id BIGINT unsigned not null,
	target_user_id BIGINT unsigned not null,
	status ENUM('requested', 'approved', 'declined', 'unfriends'),
	requested_at DATETIME default NOW(),
	updated_at DATETIME,
	
	primary key (initiator_user_id, target_user_id), -- составной первичный ключ
	index (initiator_user_id),
	index (target_user_id),
	foreign key (initiator_user_id) references users(id),
	foreign key (target_user_id) references users(id)
);


create table communities(
	id SERIAL primary key,
	name VARCHAR(150),
	
	index (name)
);


create table `users_communities`(
	user_id BIGINT unsigned not null,
	community_id BIGINT unsigned not null,
	
	primary key (user_id, community_id),
	foreign key (user_id) references users(id),
	foreign key (community_id) references communities(id)
);


create table `media_types`(
	id SERIAL primary key,
	name VARCHAR(150),
	created_at DATETIME default NOW()
);

create table `media`(
	id SERIAL,
	media_type_id BIGINT unsigned not null,
	user_id BIGINT unsigned not null,
	body TEXT,
	filename VARCHAR(255),
	`size` int,
	metadata JSON,
	created_at DATETIME default NOW(),
	updated_at DATETIME default current_timestamp on update current_timestamp,
	
	primary key (id),
	index(user_id),
	foreign key (user_id) references users(id),
	foreign key (media_type_id) references media_types(id)
	
);


create table likes_media(
	id SERIAL,
	user_id BIGINT unsigned not null,
	media_id BIGINT unsigned not null,
	created_at DATETIME default NOW(),
	
	primary key (id),
	foreign key (user_id) references users(id),
	foreign key (media_id) references media(id)
);




create table photo_albums(
	id SERIAL,
	name VARCHAR(150),
	user_id BIGINT unsigned not null,
	
	primary key (id),
	foreign key (user_id) references users(id)
);


create table photos(
	id SERIAL,
	album_id BIGINT unsigned not null,
	media_id BIGINT unsigned not null,
	
	primary key (id),
	foreign key (album_id) references photo_albums(id),
	foreign key (media_id) references media(id)
);


create table likes_massages(
	id SERIAL,
	user_id BIGINT unsigned not null,
	massages_id BIGINT unsigned not null,
	created_at DATETIME default NOW(),
	
	primary key (id),
	foreign key (user_id) references users(id),
	foreign key (massages_id) references massages(id)
);


create table likes_users(
	id SERIAL,
	user_id BIGINT unsigned not null,
	from_user_id BIGINT unsigned not null,
	created_at DATETIME default NOW(),
	
	primary key (id),
	foreign key (user_id) references users(id),
	foreign key (from_user_id) references users(id)
);








