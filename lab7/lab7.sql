-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
DELIMITER //
CREATE PROCEDURE proc1()
BEGIN
SELECT
  b.title,
  b.price,
  p.publisher,
  b.format
FROM book_info as b
INNER JOIN book_publisher AS p ON b.publisher = p.id;
END //
DELIMITER ;

CALL proc1();

-- 2. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
DELIMITER //
CREATE PROCEDURE proc2()
BEGIN
SELECT
  t.topic,
  c.category,
  b.title,
  p.publisher
FROM book_info as b
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id
INNER JOIN book_publisher AS p ON b.publisher = p.id
ORDER BY b.topic DESC, b.category DESC;
END //
DELIMITER ;

CALL proc2();

-- 3. Вивести книги видавництва 'BHV', видані після 2000 р
DELIMITER //
CREATE PROCEDURE proc3()
BEGIN
SELECT
  b.title,
  p.publisher
FROM book_info as b
INNER JOIN book_publisher AS p ON b.publisher = p.id
WHERE
  YEAR(b.date) > 2000
  AND
  p.publisher LIKE "%BHV%";
END //
DELIMITER ;

CALL proc3();

-- 4. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій / зростанню кількості сторінок.
DELIMITER //
CREATE PROCEDURE proc4(IN sort_order INT)
BEGIN
  IF sort_order = 1 THEN
    SELECT
      c.category,
      b.pages
    FROM book_info AS b
    INNER JOIN book_category AS c ON b.category = c.id
    ORDER BY b.pages DESC;
  ELSE
    SELECT
      c.category,
      b.pages
    FROM book_info AS b
    INNER JOIN book_category AS c ON b.category = c.id
    ORDER BY b.pages ASC;
  END IF;
END //
DELIMITER ;

CALL proc4(1);
CALL proc4(10);

-- 5. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
DELIMITER //
CREATE PROCEDURE proc5()
BEGIN
SELECT
  AVG(b.price)
FROM book_info as b
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id
WHERE
	t.topic = "Використання ПК"
  AND
  c.category = "Linux";
END //
DELIMITER ;

CALL proc5();

-- 6. Вивести всі дані універсального відношення.
DELIMITER //
CREATE PROCEDURE proc6()
BEGIN
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
FROM book_info AS b
INNER JOIN book_publisher AS p ON b.publisher = p.id
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id;
END //
DELIMITER ;

CALL proc6();

-- 7. Вивести пари книг, що мають однакову кількість сторінок.
DELIMITER //
CREATE PROCEDURE proc7()
BEGIN
SELECT 
  book_1.title AS "Book 1",
  book_2.title AS "Book 2",
  book_1.pages AS "Page Count"
FROM book_info AS book_1
INNER JOIN book_info AS book_2 ON book_1.pages = book_2.pages
WHERE book_1.n != book_2.n;
END //
DELIMITER ;

CALL proc7();

-- 8. Вивести тріади книг, що мають однакову ціну.
DELIMITER //
CREATE PROCEDURE proc8()
BEGIN
SELECT 
  book_1.title AS "Book 1",
  book_2.title AS "Book 2",
  book_3.title AS "Book 3",
  book_1.price AS "Price"
FROM book_info AS book_1
INNER JOIN book_info AS book_2 ON book_1.price = book_2.price
INNER JOIN book_info AS book_3 ON book_1.price = book_3.price
WHERE book_1.n != book_2.n AND book_2.n != book_3.n AND book_1.n != book_3.n;
END //
DELIMITER ;

CALL proc8();

-- 9. Вивести всі книги категорії 'C ++'.
DELIMITER //
CREATE PROCEDURE proc9()
BEGIN
SELECT *
FROM book_info
WHERE category = (SELECT id FROM book_category WHERE book_category.category = 'C&C++');
END //
DELIMITER ;

CALL proc9();

-- 10. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.
DELIMITER //
CREATE PROCEDURE proc10()
BEGIN
SELECT *
FROM book_publisher
WHERE (SELECT MAX(pages) FROM book_info WHERE book_info.publisher = book_publisher.id) >= 400;
END //
DELIMITER ;

CALL proc10();

-- 11. Вивести список категорій за якими більше 3-х книг.
DELIMITER //
CREATE PROCEDURE proc11()
BEGIN
SELECT *
FROM book_category
WHERE (SELECT COUNT(*) FROM book_info WHERE book_info.category = book_category.id) > 3;
END //
DELIMITER ;

CALL proc11();

-- 12. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.
DELIMITER //
CREATE PROCEDURE proc12()
BEGIN
SELECT *
FROM book_info
WHERE EXISTS (
  SELECT * 
  FROM book_publisher 
  WHERE book_publisher.publisher 
  LIKE "%BHV%" 
  AND book_info.publisher = book_publisher.id);
END //
DELIMITER ;

CALL proc12();

-- 13. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.
DELIMITER //
CREATE PROCEDURE proc13()
BEGIN
SELECT *
FROM book_info
WHERE NOT EXISTS (
  SELECT * 
  FROM book_publisher 
  WHERE book_publisher.publisher 
  LIKE "%BHV%" 
  AND book_info.publisher = book_publisher.id);
END //
DELIMITER ;

CALL proc13();

-- 14. Вивести відсортоване загальний список назв тем і категорій.
DELIMITER //
CREATE PROCEDURE proc14()
BEGIN
SELECT *
FROM book_topic
UNION
SELECT *
FROM book_category
ORDER BY id;
END //
DELIMITER ;

CALL proc14();

-- 15. Вивести відсортований в зворотному порядку загальний список перших слів назв книг і категорій що не повторюються
DELIMITER //
CREATE PROCEDURE proc15()
BEGIN
SELECT SUBSTRING_INDEX(title, ' ', 1) AS first_word
FROM book_info
UNION
SELECT SUBSTRING_INDEX(category, ' ', 1) AS first_word
FROM book_category 
ORDER BY first_word DESC;
END //
DELIMITER ;

CALL proc15();
