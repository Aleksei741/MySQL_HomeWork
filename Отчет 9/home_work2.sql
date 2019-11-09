/*
 * В базе данных Redis подберите коллекцию для подсчета посещений с определенных
 * IP-адресов.
 */


/*
127.0.0.1:6379> HSET ipaddr 192.168.1.1 1
(integer) 1
127.0.0.1:6379> HSET ipaddr 192.168.1.1 2
(integer) 0
127.0.0.1:6379> hkeys ipaddr
1) "192.168.1.1"
127.0.0.1:6379> hvals ipaddr
1) "2"
127.0.0.1:6379>
*/

/*
 * При помощи базы данных Redis решите задачу поиска имени пользователя по электронному 
 * адресу и наоборот, поиск электронного адреса пользователя по его имени.
 */

/*
 * 127.0.0.1:6379> set name name@mail.ru
OK
127.0.0.1:6379> set name@male.ru name
OK
127.0.0.1:6379> get name
"name@mail.ru"
127.0.0.1:6379> get name@mail.ru
(nil)
127.0.0.1:6379> get name@male.ru
"name"
127.0.0.1:6379>
 */


/*
 * Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
 */

use products
db.products.insert({"name": "Intel Core i3-8100", "description": "Процессор для настольных ПК", "price": "8000.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}) 
use catalogs
db.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Мат.платы"}, {"name": "Видеокарты"}])









