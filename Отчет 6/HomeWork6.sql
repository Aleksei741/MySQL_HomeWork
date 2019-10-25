-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT FLOOR(1 + (RAND() * 100));

update `messages`
set 
	from_user_id = FLOOR(1 + (RAND() * 100)),
	to_user_id = FLOOR(1 + (RAND() * 100))
where
	from_user_id = to_user_id
;

update friend_requests
set 
	initiator_user_id = FLOOR(1 + (RAND() * 50)),
	target_user_id = FLOOR(1 + (RAND() * 50))
where
	initiator_user_id = target_user_id
;

INSERT INTO `messages` (from_user_id, to_user_id, body) VALUES 
('1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.'),
('2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.'),
('3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.'),
('1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.'),
('1','2','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.'),
('1','4','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.'),
('2','10','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.'),
('3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.'),
('1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.'),
('1','4','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.'),
('1','3','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.'),
('10','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.'),
('10','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.'),
('1','10','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.'),
('1','3','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.');

-- id друзей
select initiator_user_id from friend_requests where target_user_id = 1 and `status` = 'approved'
union
select target_user_id from friend_requests where initiator_user_id = 1 and `status` = 'approved';



(select to_user_id as uid from `messages` where from_user_id = 1 and to_user_id in (	select initiator_user_id from friend_requests where target_user_id = 1 and `status` = 'approved'
																	union
																	select target_user_id from friend_requests where initiator_user_id = 1 and `status` = 'approved')
																union all
select from_user_id as uid from `messages` where to_user_id = 1 and from_user_id in (	select initiator_user_id from friend_requests where target_user_id = 1 and `status` = 'approved'
																	union
																	select target_user_id from friend_requests where initiator_user_id = 1 and `status` = 'approved'))
order by uid
																;																							
																								
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..																							

/*drop table if exists likes_users;
create table likes_users(
	id SERIAL,
	user_id BIGINT unsigned not null,
	from_user_id BIGINT unsigned not null,
	created_at DATETIME default NOW(),
	
	primary key (id),
	foreign key (user_id) references users(id),
	foreign key (from_user_id) references users(id)
);*/
															
select count(*)
from likes_users
where from from_user_id in (select user_id from `profiles` where (YEAR(now()) - YEAR(birthday)) < 10)

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?


	SELECT 	
	count(case 
				when gender <=> 'm' then 1
				else null
		  end) as male,
	count(case 
				when gender <=> 'f' then 1
				else null
		  end) as female		  
    FROM profiles
  	WHERE user_id in (SELECT user_id FROM `likes`)




