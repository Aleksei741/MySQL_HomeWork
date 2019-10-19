use vk;

/*
 * 1. Повторить все действия по доработке БД vk.
 * 
 * Доработку производить командами:
 * alter table vk.likes add constraint likes_fk foreign key (user_id) references vk.users(id);
 * alter table vk.likes add constraint likes_fk_1 foreign key (media_id) references vk.media(id);
 * alter table vk.users add is_deleted BIT default 0 not null
 * alter table vk.messages add is_deleted BIT default 0 not null
 * 
 * Ниже представлен код с учетом доработки
 */

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Р В¤Р В°Р С?Р С‘Р В»РЎРЉ', -- COMMENT Р Р…Р В° РЎРѓР В»РЎС“РЎвЂЎР В°Р в„–, Р ВµРЎРѓР В»Р С‘ Р С‘Р С?РЎРЏ Р Р…Р ВµР С•РЎвЂЎР ВµР Р†Р С‘Р Т‘Р Р…Р С•Р Вµ
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    is_deleted BIT default 0 not null,
    INDEX users_phone_idx(phone), -- Р С”Р В°Р С” Р Р†РЎвЂ№Р В±Р С‘РЎР‚Р В°РЎвЂљРЎРЉ Р С‘Р Р…Р Т‘Р ВµР С”РЎРѓРЎвЂ№?
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) -- РЎвЂЎРЎвЂљР С• Р В·Р В° Р В·Р Р†Р ВµРЎР‚РЎРЉ Р Р† РЎвЂ Р ВµР В»Р С•Р С??
    	ON UPDATE CASCADE -- Р С”Р В°Р С” РЎРЊРЎвЂљР С• РЎР‚Р В°Р В±Р С•РЎвЂљР В°Р ВµРЎвЂљ? Р С™Р В°Р С”Р С‘Р Вµ Р Р†Р В°РЎР‚Р С‘Р В°Р Р…РЎвЂљРЎвЂ№?
    	ON DELETE restrict -- Р С”Р В°Р С” РЎРЊРЎвЂљР С• РЎР‚Р В°Р В±Р С•РЎвЂљР В°Р ВµРЎвЂљ? Р С™Р В°Р С”Р С‘Р Вµ Р Р†Р В°РЎР‚Р С‘Р В°Р Р…РЎвЂљРЎвЂ№?
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- Р С—Р С•Р С”Р В° РЎР‚Р В°Р Р…Р С•, РЎвЂљ.Р С”. РЎвЂљР В°Р В±Р В»Р С‘РЎвЂ РЎвЂ№ media Р ВµРЎвЂ°Р Вµ Р Р…Р ВµРЎвЂљ
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- Р С?Р С•Р В¶Р Р…Р С• Р В±РЎС“Р Т‘Р ВµРЎвЂљ Р Т‘Р В°Р В¶Р Вµ Р Р…Р Вµ РЎС“Р С—Р С•Р С?Р С‘Р Р…Р В°РЎвЂљРЎРЉ РЎРЊРЎвЂљР С• Р С—Р С•Р В»Р Вµ Р С—РЎР‚Р С‘ Р Р†РЎРѓРЎвЂљР В°Р Р†Р С”Р Вµ
    is_deleted BOOL default 0 not null,
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	-- id SERIAL PRIMARY KEY, -- Р С‘Р В·Р С?Р ВµР Р…Р С‘Р В»Р С‘ Р Р…Р В° Р С”Р С•Р С?Р С—Р С•Р В·Р С‘РЎвЂљР Р…РЎвЂ№Р в„– Р С”Р В»РЎР‹РЎвЂЎ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    -- `status` TINYINT UNSIGNED, -- Р Р† РЎРЊРЎвЂљР С•Р С? РЎРѓР В»РЎС“РЎвЂЎР В°Р Вµ Р Р† Р С”Р С•Р Т‘Р Вµ РЎвЂ¦РЎР‚Р В°Р Р…Р С‘Р В»Р С‘ Р В±РЎвЂ№ РЎвЂ Р С‘РЎвЂћР С‘РЎР‚Р Р…РЎвЂ№Р в„– enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
	INDEX (initiator_user_id), -- Р С—Р С•РЎвЂљР С•Р С?РЎС“ РЎвЂЎРЎвЂљР С• Р С•Р В±РЎвЂ№РЎвЂЎР Р…Р С• Р В±РЎС“Р Т‘Р ВµР С? Р С‘РЎРѓР С”Р В°РЎвЂљРЎРЉ Р Т‘РЎР‚РЎС“Р В·Р ВµР в„– Р С”Р С•Р Р…Р С”РЎР‚Р ВµРЎвЂљР Р…Р С•Р С–Р С• Р С—Р С•Р В»РЎРЉР В·Р С•Р Р†Р В°РЎвЂљР ВµР В»РЎРЏ
    INDEX (target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),

	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), 
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)

);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);


/*
 * 2. Заполнить новые таблицы.
 */


INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('1', 'Elvie', 'Braun', 'bogan.bulah@example.org', '166087', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('2', 'Herman', 'Friesen', 'russell.goodwin@example.com', '0', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('3', 'Eriberto', 'Fisher', 'niko.ruecker@example.org', '0', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('4', 'Drake', 'Haley', 'lorine41@example.org', '29', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('5', 'Lucile', 'Thompson', 'demario48@example.com', '269647', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('6', 'Jairo', 'Lockman', 'rashawn35@example.com', '338', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('7', 'Hilda', 'McDermott', 'westley50@example.org', '1', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('8', 'Jarrod', 'Windler', 'schiller.adela@example.org', '0', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('9', 'Cedrick', 'Collier', 'clement.swift@example.net', '1', 0);
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `is_deleted`) VALUES ('10', 'Eliseo', 'Ritchie', 'baumbach.trevion@example.org', '145088', 0);

INSERT INTO `communities` (`id`, `name`) VALUES ('5', 'aut');
INSERT INTO `communities` (`id`, `name`) VALUES ('3', 'corrupti');
INSERT INTO `communities` (`id`, `name`) VALUES ('4', 'dignissimos');
INSERT INTO `communities` (`id`, `name`) VALUES ('1', 'et');
INSERT INTO `communities` (`id`, `name`) VALUES ('2', 'quia');

INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('1', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('2', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('3', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('4', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('5', '5');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('6', '1');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('7', '2');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('8', '3');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('9', '4');
INSERT INTO `users_communities` (`user_id`, `community_id`) VALUES ('10', '5');

INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'ut', '1991-04-06 03:25:38', '2008-01-12 08:02:04');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'aut', '2018-03-12 19:45:37', '1979-06-19 16:37:46');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'nam', '1994-07-27 00:02:54', '1991-06-06 16:45:28');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'a', '1999-03-15 10:08:36', '2007-09-03 20:09:54');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'corrupti', '2017-11-07 02:01:21', '2000-11-24 15:05:18');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('6', 'occaecati', '1995-06-26 09:08:36', '2003-12-13 20:25:10');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('7', 'ratione', '1970-08-16 08:47:28', '1990-12-19 06:39:56');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('8', 'deserunt', '1995-06-18 16:53:33', '1980-09-27 14:00:52');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('9', 'fugit', '1987-12-04 10:51:33', '2012-05-31 10:22:27');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('10', 'et', '1983-07-28 21:31:16', '1985-04-24 05:08:18');

INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('1', '1', '1', 'Omnis suscipit debitis est hic qui corrupti. Quo at perspiciatis voluptatem eum ipsum. Quo libero et fuga neque. Assumenda ad reprehenderit quibusdam impedit consequatur omnis ab.', 'libero', 67316170, NULL, '1978-01-15 17:17:20', '2017-06-29 16:16:29');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('2', '2', '2', 'Rerum non adipisci voluptate hic aut inventore voluptas. Soluta esse hic reiciendis illo nihil. Cupiditate id reprehenderit fuga aut consectetur officia. Et occaecati ab quos. Sed doloremque nesciunt quos harum eligendi.', 'ipsum', 94, NULL, '2004-06-12 11:58:42', '2007-07-23 21:08:34');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('3', '3', '3', 'Ipsum omnis consectetur et facere quasi magnam. Magni nihil qui dicta possimus reiciendis expedita. Magnam odio odit enim ut. Reiciendis qui dolore qui doloremque sed natus a.', 'facere', 749745314, NULL, '1993-10-13 11:37:05', '2006-10-10 03:31:11');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('4', '4', '4', 'Id aliquid totam in nostrum quidem repellendus. Nihil blanditiis odio nihil. Saepe id quisquam eos quia adipisci temporibus laborum ipsum.', 'deserunt', 854, NULL, '2008-10-30 09:36:43', '2006-07-20 23:08:44');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('5', '5', '5', 'Tempora ex rem deleniti eos aliquid molestias reprehenderit quo. Quibusdam magnam omnis eum et ipsa. Ut dolores necessitatibus quia tempora ut ab ducimus.', 'quasi', 2476299, NULL, '1977-11-02 18:10:43', '1991-01-31 11:37:57');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('6', '6', '6', 'Id aut quidem fuga natus. Ad et quia illo molestiae. Dolores tenetur et alias occaecati. A id dolorem esse mollitia qui vitae natus.', 'aut', 94, NULL, '1992-03-29 00:48:37', '1975-10-24 22:37:52');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('7', '7', '7', 'At odit praesentium doloremque. Quasi cum est itaque est maiores vel accusantium quo. Non autem aspernatur enim et.', 'error', 6748851, NULL, '1979-05-16 12:06:50', '2009-05-16 21:41:27');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('8', '8', '8', 'Non accusantium deserunt ut. Et dolorem qui eum temporibus. Aliquid illo ipsam eum sint non odit.', 'repudiandae', 77466, NULL, '1990-06-02 14:46:48', '2007-04-11 12:23:38');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('9', '9', '9', 'Sed quibusdam impedit accusantium quas eum unde voluptates. Voluptas sed praesentium dolores.', 'repudiandae', 83, NULL, '2013-03-10 20:48:08', '1980-05-29 06:21:44');
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES ('10', '10', '10', 'Voluptatibus asperiores quis sit voluptatem ut necessitatibus mollitia. Ipsum rem vel et impedit repellat rerum accusantium. Quae est maxime animi ipsum quia. Eligendi dignissimos maxime eaque repellat reprehenderit at aut.', 'nobis', 211479, NULL, '1998-07-25 05:04:18', '1973-10-22 01:55:26');

INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('1', 'occaecati', '1');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('2', 'officia', '2');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('3', 'recusandae', '3');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('4', 'possimus', '4');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('5', 'assumenda', '5');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('6', 'quidem', '6');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('7', 'ad', '7');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('8', 'distinctio', '8');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('9', 'sed', '9');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('10', 'omnis', '10');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('11', 'ut', '1');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('12', 'cupiditate', '2');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('13', 'occaecati', '3');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('14', 'dolor', '4');
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('15', 'impedit', '5');

INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('1', '1', '1');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('2', '2', '2');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('3', '3', '3');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('4', '4', '4');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('5', '5', '5');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('6', '6', '6');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('7', '7', '7');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('8', '8', '8');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('9', '9', '9');
INSERT INTO `photos` (`id`, `album_id`, `media_id`) VALUES ('10', '10', '10');

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('1', 'M', '1998-03-07', '1', '1986-10-22 04:40:37', 'Deangelomouth');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('2', 'M', '1995-09-28', '2', '1973-02-19 05:02:26', 'Lake Reannamouth');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('3', 'P', '1995-05-02', '3', '1973-07-08 00:31:13', 'East Kade');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('4', 'M', '1982-12-28', '4', '1972-01-30 12:47:43', 'Murphyport');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('5', 'P', '1997-05-30', '5', '2012-09-10 15:47:25', 'Port Gonzaloport');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('6', 'M', '2018-11-27', '6', '1998-05-15 09:16:03', 'Veronicaton');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('7', 'M', '1994-07-25', '7', '2009-08-21 11:31:13', 'South Ana');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('8', 'M', '1991-08-09', '8', '1997-04-20 23:41:02', 'Port Adahhaven');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('9', 'M', '1977-08-11', '9', '1990-01-21 02:35:17', 'Lake Sunnybury');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('10', 'D', '2003-10-13', '10', '1991-07-31 01:30:18', 'Xanderberg');

INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('1', '2', 'declined', '1971-05-24 07:07:40', '2012-07-20 06:25:50');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('2', '3', 'requested', '2013-02-02 07:45:18', '1995-08-12 12:43:12');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('3', '4', 'declined', '2015-04-25 22:35:34', '1978-11-04 07:10:24');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('4', '5', 'approved', '2014-02-25 13:00:55', '1995-06-13 00:36:15');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('5', '6', 'declined', '2001-03-16 00:06:51', '2000-11-29 14:55:22');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('6', '7', 'requested', '1989-05-25 00:40:27', '2013-04-27 04:03:46');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('7', '8', 'declined', '1983-03-01 15:04:44', '1978-07-23 20:14:31');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('8', '9', 'declined', '1976-02-12 05:17:34', '2016-07-30 02:21:44');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('9', '10', 'approved', '1987-03-23 15:00:44', '2002-02-11 01:33:43');
INSERT INTO `friend_requests` (`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) VALUES ('10', '1', 'requested', '1996-09-11 11:46:18', '1977-06-25 05:39:29');

INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('1', '1', '1', '2012-08-18 23:30:35');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('2', '2', '2', '1996-10-19 20:43:19');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('3', '3', '3', '1974-08-28 01:13:50');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('4', '4', '4', '2000-08-25 15:03:36');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('5', '5', '5', '1973-03-20 01:30:04');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('6', '6', '6', '1989-03-31 08:13:47');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('7', '7', '7', '2014-02-19 11:30:04');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('8', '8', '8', '1985-10-26 02:19:11');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('9', '9', '9', '1995-08-07 22:19:20');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('10', '10', '10', '2019-06-16 22:39:53');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('11', '1', '1', '2006-03-26 14:21:37');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('12', '2', '2', '1993-09-12 00:08:11');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('13', '3', '3', '1987-06-04 15:15:43');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('14', '4', '4', '2018-03-03 17:17:53');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('15', '5', '5', '1982-07-17 23:05:53');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('16', '6', '6', '1970-11-30 03:36:58');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('17', '7', '7', '2004-06-02 20:45:50');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('18', '8', '8', '1983-12-20 07:04:04');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('19', '9', '9', '2006-12-20 05:29:38');
INSERT INTO `likes` (`id`, `user_id`, `media_id`, `created_at`) VALUES ('20', '10', '10', '2018-09-25 06:44:39');

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('1', '1', '1', 'Maiores cum aspernatur sapiente. Aut quo aspernatur rem quisquam. Expedita mollitia pariatur quibusdam error. Unde voluptatem saepe adipisci voluptate quia qui quos et.', '2007-06-15 18:11:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('2', '2', '2', 'Et vel ipsa fuga impedit. Nisi nobis nobis dolorem natus voluptatem aut id. Possimus reiciendis animi voluptatem. Quo aspernatur possimus nam voluptates.', '1981-08-18 01:37:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('3', '3', '3', 'Porro sint est quae eveniet aut et. Omnis quis voluptas nam tenetur.', '2006-12-26 04:17:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('4', '4', '4', 'Dolore dignissimos pariatur iusto dolores. Omnis et aut ullam sunt et et dolor. Doloribus praesentium dolorum animi et.', '1973-11-29 10:01:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('5', '5', '5', 'Dicta aperiam dolores eaque labore dolor. Reiciendis consequatur quis mollitia saepe pariatur. Rerum quis optio quo omnis. Eius sed iste est.', '2010-09-13 10:36:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('6', '6', '6', 'Dolor et ab enim qui deserunt est omnis. Laudantium non facere animi voluptate optio eligendi eum. Aspernatur dolores quae aliquam. Ut omnis sint sapiente et dolore.', '2009-09-18 01:18:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('7', '7', '7', 'Quae architecto recusandae molestiae commodi. Et non facere saepe voluptas. Saepe voluptatem maiores corrupti occaecati quia ullam.', '1980-04-12 08:56:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('8', '8', '8', 'Officia natus optio ex maiores et. Esse molestiae ut ut similique voluptas. Consectetur inventore nostrum quas ducimus neque. Qui aperiam nihil facilis tempora.', '1974-08-11 07:55:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('9', '9', '9', 'Molestiae eos velit omnis. Sunt odio saepe quae ut qui quae. Vitae perspiciatis architecto et. Qui et veritatis velit sit voluptatum qui aliquid sint.', '2008-10-16 14:47:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('10', '10', '10', 'Ut voluptas iste qui voluptates. Reiciendis vitae autem eaque qui. Facilis veniam asperiores veritatis expedita officiis est.', '2018-04-26 22:01:34');


/*
 * 3. Повторить все действия CRUD.
 */

INSERT INTO users VALUES
('5', 'Reuben', 'Nienow', 'arlo515@example.org', NULL, 0),

INSERT INTO users
SET
	firstname = 'Reuben',
	lastname = 'Nienow',
	email = 'ivan@mail.ru',
	phone = '987654321'
;

insert ignore INTO 
	users(`firstname`, `lastname`, `email`, `phone`)
VALUES
	('Reuben', 'Nienow', 'arlo1@example.org', NULL),
	('Reuben', 'Nienow', 'arlo2@example.org', NULL),
	('Reuben', 'Nienow', 'arlo3@example.org', NULL),
	('Reuben', 'Nienow', 'arlo4@example.org', NULL),
	('Reuben', 'Nienow', 'arlo5@example.org', NULL)
	;


select 1,2,3,4;

select
	firstname
from
	users;

select distinct 
	firstname
from
	users;

select *
from 
	users
limit 5;

select *
from 
	users
limit 5 offset 4;

select 
	id, firstname
from 
	users
where id = 1;

update friend_requests
set 
	status = 'approved',
	confirmed_at = now()
where
	initiator_user_id = 1 and target_user_id = 2
;


INSERT INTO
	messages(`from_user_id`, `to_user_id`, `body`, `created_at`)
values
	('1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),
	('2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',now()),
	('3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
	('1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
	('1','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46')
;

delete from
	messages
where 
	from_user_id = 1;

update messages
set is_deleted = 1
where
	from_user_id = 1;

truncate messages;


/*
 * Подобрать сервис-образец для курсовой работы.
 * 
 * БД для курсового проекта осуществляет автоматизацию
 * учета проектирования эл. устройств на производстве
 * 
 * Осуществляет хранение информации
 * о типах элементов
 * поставщиках
 * производителях
 * наличие комплектующих на складах
 * состав эл. устройств из имеющихся комплектующих
 * 
 */









