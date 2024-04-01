# 1. Вивести значення наступних колонок: номер, код, новинка, назва, ціна, сторінки
SELECT n, id, novelty, title, price, pages from library_storage;
# 2. Вивести значення всіх колонок:
SELECT * FROM library_storage;
# 3. Вивести значення колонок в наступному порядку: код, назва, новинка, сторінки, ціна, номер
SELECT id, title, novelty, pages, price, n FROM library_storage;
# 4. Вивести значення всіх колонок 10 перших рядків:
SELECT * FROM library_storage LIMIT 10;
# 5. Вивести значення всіх колонок 10% перших рядків
SET @count = (SELECT COUNT(*) * 0.1 FROM library_storage); 

PREPARE result FROM 'SELECT * FROM library_storage LIMIT ?';
EXECUTE result USING @count;
DEALLOCATE PREPARE result;
# 6. Вивести значення колонки код без повторення однакових кодів:
SELECT * FROM library_storage GROUP BY id HAVING COUNT(*) = 1;
# 7. Вивести всі книги новинки:
SELECT * FROM library_storage WHERE novelty = 'Yes'
# 8. Вивести всі книги новинки з ціною від 20 до 30:
SELECT * FROM library_storage WHERE novelty = 'Yes' AND price BETWEEN 20 AND 30;
# 9. Вивести всі книги новинки з ціною менше 20 і більше 30:
SELECT * FROM library_storage WHERE novelty = 'Yes' AND price < 20 AND price > 30;
# 10. Вивести всі книги з кількістю сторінок від 300 до 400 і з ціною більше 20 і менше 30:
SELECT * FROM library_storage WHERE pages = 300 BETWEEN 400 AND price > 20 AND price < 30;
# 11. Вивести всі книги видані взимку 2000 року:
SELECT * FROM library_storage WHERE date BETWEEN '2000-12-01' AND '2000-12-31';
# 12. Вивести книги зі значеннями кодів 5110, 5141, 4985, 4241:
SELECT * FROM library_storage WHERE id IN (5110, 5141, 4985, 4241);
# 13. Вивести книги видані в 1999, 2001, 2003, 2005 р:
SELECT * FROM library_storage WHERE year(date) IN ('1999', '2001', '2003', '2005');
# 14. Вивести книги назви яких починаються на літери А-К:
SELECT * FROM library_storage WHERE title BETWEEN 'А' AND 'К';
# 15. Вивести книги назви яких починаються на літери "АПП", видані в 2000 році з ціною до 20:
SELECT * FROM library_storage WHERE title LIKE 'АПП%' AND year(date) = '2000' AND price < 20;
# 16. Вивести книги назви яких починаються на літери "АПП", закінчуються на "е", видані в першій половині 2000 року:
SELECT * FROM library_storage WHERE title LIKE 'АПП%' AND title LIKE '%е' AND date BETWEEN '2000-01-01' AND '2000-07-01';
# 17. Вивести книги, в назвах яких є слово Microsoft, але немає слова Windows:
SELECT * FROM library_storage WHERE title LIKE '%Microsoft%' AND title NOT LIKE '%Windows%';
# 18. Вивести книги, в назвах яких присутня як мінімум одна цифра:
SELECT * FROM library_storage WHERE title REGEXP '[0-9]';
# 19. Вивести книги, в назвах яких присутні не менше трьох цифр:
SELECT * FROM library_storage WHERE title REGEXP ' \\b[0-9]{3}';
# 20. Вивести книги, в назвах яких присутній рівно пʼять цифр:
SELECT * FROM library_storage WHERE title REGEXP '\\b[0-9]{5}\\b';
