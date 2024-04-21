-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT
  b.title,
  b.price,
  p.publisher
FROM book_info AS b
INNER JOIN book_publisher AS p ON b.publisher = p.id
WHERE p.id > 5

-- 2. Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT
  b.title,
  c.category
FROM book_info AS b
INNER JOIN book_category AS c ON b.publisher = c.id;

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

-- 6. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.

-- 7. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.

-- 8. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.

-- 9. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.

-- 10. Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.

-- 11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).

-- 12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).

-- 13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).

-- 14. Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (subquery).

-- 15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).

-- 16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).

-- 17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.

-- 18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.

-- 19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.

-- 20. Вивести відсортований в зворотному порядку загальний список перших слів, назв книг і категорій що не повторюються. Використовувати union
