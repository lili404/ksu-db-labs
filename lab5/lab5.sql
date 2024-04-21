# 1. Проаналізувати приклад універсального відношення. З`ясувати які його колонки містять надлишкові дані. Виконати нормалізацію універсального відношення, розбивши його на кілька таблиць.
  # Задля нормалізації універсального відношення, треба розбити його, 
  # створивши окремі таблиці для колонок "Видавнитво", "Тема", "Категорія".
  
# 2. Скласти SQL-script, що виконує:
# a. Створення таблиць бази даних. 
  # Команди для створення таблиці повинні містити головний ключ, 
  # обмеження типу null / not null, default, check, створення зв`язків з умовами посилальної цілісності
  
DROP TABLE IF EXISTS book_publisher;
CREATE TABLE book_publisher(
  id INT AUTO_INCREMENT PRIMARY KEY,
  publisher VARCHAR(64) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS book_topic;
CREATE TABLE book_topic(
  id INT AUTO_INCREMENT PRIMARY KEY,
  topic VARCHAR(64) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS book_category;
CREATE TABLE book_category(
  id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(64) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS book_info;
CREATE TABLE book_info(
n INT NOT NULL PRIMARY KEY,
id INT NOT NULL,
novelty VARCHAR(3) NOT NULL,
title VARCHAR(128) NOT NULL,
price DECIMAL(5,2) DEFAULT 0 CHECK(price >= 0),
publisher INT NOT NULL,
pages INT DEFAULT NULL CHECK(pages > 0),
format VARCHAR(32) DEFAULT NULL,
date DATE DEFAULT NULL,
circulation INT DEFAULT NULL CHECK(circulation >= 1),
topic INT NOT NULL,
category INT NOT NULL,
FOREIGN KEY (publisher) REFERENCES book_publisher(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
FOREIGN KEY (topic) REFERENCES book_topic(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
FOREIGN KEY (category) REFERENCES book_category(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

# b. Завантаження даних в таблиці
INSERT INTO book_publisher(publisher) VALUES
  ('Видавнича група BHV'),
  ('Вільямс'),
  ('МикроАрт'),
  ('DiaSoft'),
  ('ДМК'),
  ('Триумф'),
  ('Эком'),
  ('Києво-Могилянська академія'),
  ('Університет "Україна"'),
  ('Вінниця: ВДТУ');

INSERT INTO book_topic(topic) VALUES
  ('Використання ПК в цілому'),
  ('Операційні системи'),
  ('Програмування');

INSERT INTO book_category(category) VALUES
  ('Підручники'),
  ('Апаратні засоби ПК'),
  ('Захист і безпека ПК'),
  ('Інші книги'),
  ('Windows 2000'),
  ('Linux'),
  ('Unix'),
  ('Інші операційні системи'),
  ('C&C++'),
  ('SQL');

INSERT INTO book_info(
  n,
  id,
  novelty,
  title,
  price,
  publisher,
  pages,
  format,
  date,
  circulation,
  topic,
  category
)
VALUES
(2,5110,'No','Апаратні засоби мультимедіа. Відеосистема РС',15.51,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  400,'70х100/16','2000-07-24',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Підручники')),
  
(8,4985,'No','Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид.',18.90,(SELECT id FROM book_publisher WHERE publisher = 'Вільямс'),
  288,'70х100/16','2000-07-07',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Підручники')),
  
(9,5141,'No','Структури даних та алгоритми',37.80,(SELECT id FROM book_publisher WHERE publisher = 'Вільямс'),
  384,'70х100/16','2000-09-29',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Підручники')),
  
(20,5127,'No','Автоматизація інженерно-графічних робіт',11.58,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  256,'70х100/16','2000-06-15',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Підручники')),
  
(31,5110,'No','Апаратні засоби мультимедіа. Відеосистема РС',15.51,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  400,'70х100/16','2000-07-24',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Апаратні засоби ПК')),
  
(46,5199,'No','Залізо IBM 2001',30.07,(SELECT id FROM book_publisher WHERE publisher = 'МикроАрт'),
  368,'70х100/16','2000-02-12',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Апаратні засоби ПК')),
  
(50,3851,'No','Захист інформації та безпека комп''ютерних систем',26.00,(SELECT id FROM book_publisher WHERE publisher = 'DiaSoft'),
  480,'84х108/16',NULL,5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Захист і безпека ПК')),
  
(58,3932,'No','Як перетворити персональний комп''ютер на вимірювальний комплекс',7.65,(SELECT id FROM book_publisher WHERE publisher = 'ДМК'),
  144,'60х88/16','1999-06-09',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Інші книги')),
  
(59,4713,'No','Plug-ins. Додаткові програми для музичних програм',11.41,(SELECT id FROM book_publisher WHERE publisher = 'ДМК'),
  144,'70х100/16','2000-02-22',5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Інші книги')),
  
(175,5217,'No','Windows МЕ. Найновіші версії програм',16.57,(SELECT id FROM book_publisher WHERE publisher = 'Триумф'),
  320,'70х100/16','2000-08-25',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Windows 2000')),
  
(176,4829,'No','Windows 2000 Professional крок за кроком з CD',27.25,(SELECT id FROM book_publisher WHERE publisher = 'Эком'),
  320,'70х100/16','2000-04-28',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Windows 2000')),
  
(188,5170,'No','Linux версії',24.43,(SELECT id FROM book_publisher WHERE publisher = 'ДМК'),
  346,'70х100/16','2000-09-29',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Linux')),

(191,860,'No','Операційна система UNIX',3.50,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  395,'84х100/16','1997-05-05',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Unix')),
  
(203,44,'No','Відповіді на актуальні запитання щодо OS/2 Warp',5.00,(SELECT id FROM book_publisher WHERE publisher = 'DiaSoft'),
  352,'60х84/16','1996-03-20',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Інші операційні системи')),
  
(206,5176,'No','Windows Ме. Супутник користувача',12.79,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  306,'','2000-10-10',5000,(SELECT id FROM book_topic WHERE topic = 'Операційні системи'),(SELECT id FROM book_category WHERE category = 'Інші операційні системи')),
  
(209,5462,'No','Мова програмування С++. Лекції та вправи',29.00,(SELECT id FROM book_publisher WHERE publisher = 'DiaSoft'),
  656,'84х108/16','2000-12-12',5000,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'C&C++')),
  
(210,4982,'No','Мова програмування С. Лекції та вправи',29.00,(SELECT id FROM book_publisher WHERE publisher = 'DiaSoft'),
  432,'84х108/16','2000-07-12',5000,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'C&C++')),
  
(220,4687,'No','Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів',17.60,(SELECT id FROM book_publisher WHERE publisher = 'ДМК'),
  240,'70х100/16','2000-02-03',5000,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'C&C++')),
  
(222,235,'No','Інформаційні системи і структури даних',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Києво-Могилянська академія'),
  288,'60х90/16',NULL,400,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),(SELECT id FROM book_category WHERE category = 'Інші книги')),
  
(225,8746,'Yes','Бази даних в інформаційних системах',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Університет "Україна"'),
  418,'60х84/16','2018-07-25',100,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'SQL')),
  
(226,2154,'Yes','Сервер на основі операційної системи FreeBSD 6.1',0,(SELECT id FROM book_publisher WHERE publisher = 'Університет "Україна"'),
  216,'60х84/16','2015-11-03',500,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'Інші операційні системи')),
  
(245,2662,'No','Організація баз даних та знань',0,(SELECT id FROM book_publisher WHERE publisher = 'Вінниця: ВДТУ'),
  208,'60х90/16','2001-10-10',1000,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'SQL')),
  
(247,5641,'Yes','Організація баз даних та знань',0,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  384,'70х100/16','2021-12-15',5000,(SELECT id FROM book_topic WHERE topic = 'Програмування'),(SELECT id FROM book_category WHERE category = 'SQL'));

# 3. Побудувати діаграму зв`язків таблиць бази даних використовуючи інструмент Designer.
  
# 4. Створити зв’язки в базі даних між таблицями.
# a. Вивчити роботу створення зв’язків між таблицями в полі Designer
# b. Створити майстром e Designer кілька варіантів зв’язків у базі даних 
# c. Проаналізувати і пояснити особливості зв’язків, створених Designer
# d. Порівняти з тими, що написані самостійно.
# e. Зробити висновки
  
# 5. Створити і перевірити представлення для отримання універсального відношення з набору нормалізованих таблиць бази даних.
  SELECT
	b.n,
	b.id,
	b.novelty,
	b.title,
	b.price,
	p.publisher,
	b.pages,
	b.format,
	b.date,
	b.circulation,
	t.topic,
	c.category
FROM
	book_info AS b
INNER JOIN book_publisher AS p ON b.publisher = p.id
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id;
