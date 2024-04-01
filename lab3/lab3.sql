# 1. Вивести книги у яких не введена ціна або ціна дорівнює 0:
SELECT * FROM library_storage WHERE price IS NULL OR price = 0;

# 2. Вивести книги у яких введена ціна, але не введений тираж:
SELECT * FROM library_storage WHERE price IS NOT NULL AND circulation IS NULL;

# 3. Вивести книги, про дату видання яких нічого не відомо:
SELECT * FROM library_storage WHERE date IS NULL;

# 4. Вивести книги, з дня видання яких пройшло не більше року:
SELECT * FROM library_storage WHERE DATE_ADD(date, INTERVAL 1 year) >= CURRENT_DATE;

# 5. Вивести список книг-новинок, відсортованих за зростанням ціни:
SELECT * FROM library_storage WHERE novelty = 'Yes' ORDER BY price ASC;

# 6. Вивести список книг з числом сторінок від 300 до 400, відсортованих в зворотному алфавітному порядку назв:
SELECT * FROM library_storage WHERE pages BETWEEN 300 AND 400 ORDER BY title DESC;

# 7. Вивести список книг з ціною від 20 до 40, відсортованих за спаданням дати:
SELECT * FROM library_storage WHERE price BETWEEN 20 AND 40 ORDER BY date DESC;

# 8. Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій:
SELECT * FROM library_storage ORDER BY title DESC, price DESC;

# 9. Вивести книги, у яких ціна однієї сторінки < 10 копійок:
SELECT * FROM library_storage WHERE price / pages < 0.1;

# 10. Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами:
SELECT CHAR_LENGTH(title), UPPER(SUBSTRING(title, 1, 20)) AS title FROM library_storage;

# 11. Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...':
SELECT CONCAT(UPPER(SUBSTRING(title, 1, 10)), '...', UPPER(SUBSTRING(title, CHAR_LENGTH(title) - 9))) 
  AS '10...10' FROM library_storage;

# 12. Вивести значення наступних колонок: назва, дата, день, місяць, рік:
SELECT title, date, DAY(date), MONTH(date), YEAR(date) FROM library_storage;

# 13. Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy':
SELECT title, date, DATE_FORMAT(date, '%d/%m/%y') FROM library_storage;

# 14. Вивести значення наступних колонок: код, ціна, ціна в грн., ціна в євро, ціна в руб:
SELECT id, price, price * (39), price * (0.9), price * (91) FROM library_storage;

# 15. Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок округлена:
SELECT id, price, price * 39 AS UAH, ROUND(price * 39) AS roundedUAH FROM library_storage;

# 16. Додати інформацію про нову книгу (всі колонки):
INSERT INTO library_storage (n, id, novelty, title, price, publisher, pages, format, date, circulation, topic, category) 
  VALUES(1, 1212, 'Yes', 'Book 1', 9.99, 'Company 1', 99, '70х100/16', '2017-01-01', 1000, 'Topic Placeholder', 'Category Placeholder');

# 17. Додати інформацію про нову книгу (колонки обовʼязкові для введення)
INSERT INTO library_storage (n, id, novelty, title, price, publisher, pages, format, date, circulation, topic, category) 
  VALUES (3, 1213, '' ,'Book 2', 9.99, '', NULL, '', NULL, NULL, '', '' );

# 18. Видалити книги, видані до 1990 року:
DELETE FROM library_storage where YEAR(date) < 1990;

# 19. Проставити поточну дату для тих книг, у яких дата видання відсутня:
UPDATE library_storage SET date = CURRENT_DATE WHERE date IS NULL;

# 20. Установити ознаку новинка для книг виданих після 2005 року:
UPDATE library_storage SET novelty = 'Yes' WHERE YEAR(date) > 2005;
