-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT
  book_info.title,
  book_info.price,
  book_publisher.publisher
FROM book_info, book_publisher
WHERE book_info.publisher = book_publisher.id

-- 2. Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT
  b.title,
  c.category
FROM book_info AS b
INNER JOIN book_category AS c ON b.category = c.id;

-- 3. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
SELECT
  b.title,
  b.price,
  p.publisher,
  b.format
FROM book_info as b
INNER JOIN book_publisher AS p ON b.publisher = p.id;

-- 4. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
SELECT
  t.topic,
  c.category,
  b.title,
  p.publisher
FROM book_info as b
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id
INNER JOIN book_publisher AS p ON b.publisher = p.id
ORDER BY b.topic DESC, b.category DESC
    
-- 5. Вивести книги видавництва 'BHV', видані після 2000 р
SELECT
  b.title,
  p.publisher
FROM book_info as b
INNER JOIN book_publisher AS p ON b.publisher = p.id
WHERE
  YEAR(b.date) > 2000
  AND
  p.publisher LIKE "%BHV%"

-- 6. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.
SELECT
  c.category,
  b.pages
FROM book_info as b
INNER JOIN book_category AS c ON b.category = c.id
ORDER BY b.pages DESC

-- 7. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
SELECT
  AVG(b.price)
FROM book_info as b
INNER JOIN book_topic AS t ON b.topic = t.id
INNER JOIN book_category AS c ON b.category = c.id
WHERE
	t.topic = "Використання ПК"
  AND
  c.category = "Linux"

-- 8. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.
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
FROM book_info AS b, book_publisher AS p, book_topic AS t, book_category AS c
WHERE 
  b.publisher = p.id
  AND
  b.topic = t.id
  AND
  b.category = c.id

-- 9. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.
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

-- 10. Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.
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
LEFT JOIN book_publisher AS p ON b.publisher = p.id
LEFT JOIN book_topic AS t ON b.topic = t.id
LEFT JOIN book_category AS c ON b.category = c.id;

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
RIGHT JOIN book_publisher AS p ON b.publisher = p.id
RIGHT JOIN book_topic AS t ON b.topic = t.id
RIGHT JOIN book_category AS c ON b.category = c.id;

-- 11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).
SELECT 
  book_1.title AS "Book 1",
  book_2.title AS "Book 2",
  book_1.pages AS "Page Count"
FROM book_info AS book_1
INNER JOIN book_info AS book_2 ON book_1.pages = book_2.pages
WHERE book_1.n != book_2.n

-- 12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).
SELECT 
  book_1.title AS "Book 1",
  book_2.title AS "Book 2",
  book_3.title AS "Book 3",
  book_1.price AS "Price"
FROM book_info AS book_1
INNER JOIN book_info AS book_2 ON book_1.price = book_2.price
INNER JOIN book_info AS book_3 ON book_1.price = book_3.price
WHERE book_1.n != book_2.n AND book_2.n != book_3.n AND book_1.n != book_3.n

-- 13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).
SELECT *
FROM book_info
WHERE category = (SELECT id FROM book_category WHERE book_category.category = 'C&C++')

-- 14. Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (subquery).
SELECT *
FROM book_info
WHERE publisher = (SELECT id FROM book_publisher WHERE book_publisher.publisher LIKE '%BHV%')
AND YEAR(date) > 2000

-- 15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).
SELECT *
FROM book_publisher
WHERE (SELECT MAX(pages) FROM book_info WHERE book_info.publisher = book_publisher.id) >= 400

-- 16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).
SELECT *
FROM book_category
WHERE (SELECT COUNT(*) FROM book_info WHERE book_info.category = book_category.id) > 3

-- 17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.
SELECT *
FROM book_info
WHERE EXISTS (
  SELECT * 
  FROM book_publisher 
  WHERE book_publisher.publisher 
  LIKE "%BHV%" 
  AND book_info.publisher = book_publisher.id)

-- 18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.
SELECT *
FROM book_info
WHERE NOT EXISTS (
  SELECT * 
  FROM book_publisher 
  WHERE book_publisher.publisher 
  LIKE "%BHV%" 
  AND book_info.publisher = book_publisher.id)

-- 19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.
SELECT *
FROM book_topic
UNION
SELECT *
FROM book_category
ORDER BY id

-- 20. Вивести відсортований в зворотному порядку загальний список перших слів, назв книг і категорій що не повторюються. Використовувати union
SELECT SUBSTRING_INDEX(title, ' ', 1) AS first_word
FROM book_info
UNION
SELECT SUBSTRING_INDEX(category, ' ', 1) AS first_word
FROM book_category 
ORDER BY first_word DESC
