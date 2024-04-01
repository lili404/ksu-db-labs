# 1. Вивести статистику: загальна кількість всіх книг, їх вартість, їх середню вартість, мінімальну і максимальну ціну
SELECT 
    COUNT(*) AS total_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage;

# 2. Вивести загальну кількість всіх книг без урахування книг з непроставленою ціною
SELECT 
  COUNT(*) AS total_books
FROM 
  library_storage
WHERE 
  price IS NOT NULL;

# 3. Вивести статистику (див. 1) для книг новинка / не новинка
SELECT 
    novelty,
    COUNT(*) AS total_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
WHERE 
    novelty IN ('Yes', 'No')
GROUP BY 
    novelty;
  
# 4. Вивести статистику (див. 1) для книг за кожним роком видання
SELECT 
    YEAR(date) AS "year",
    COUNT(*) AS total_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY 
    YEAR(date);
  
# 5. Змінити п.4, виключивши з статистики книги з ціною від 10 до 20
SELECT 
    YEAR(date) AS "year",
    COUNT(*) AS total_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
WHERE
    price < 10 OR price > 20
GROUP BY 
    YEAR(date);

# 6. Змінити п.4. Відсортувати статистику по спадаючій кількості.
SELECT 
    YEAR(date) AS "year",
    COUNT(*) AS total_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY 
    YEAR(date) DESC;

# 7. Вивести загальну кількість кодів книг і кодів книг що не повторюються
SELECT 
    COUNT(*) AS id_count,
    COUNT(DISTINCT id) AS uniq_id_count
FROM 
    library_storage;

# 8. Вивести статистику: загальна кількість і вартість книг по першій букві її назви
SELECT 
    SUBSTRING(title, 1, 1) AS first_symbol,
    COUNT(*) AS total_count,
    SUM(price) AS total_price
FROM 
    library_storage
GROUP BY 
    SUBSTRING(title, 1, 1);

# 9. Змінити п. 8, виключивши з статистики назви що починаються з англ. букви або з цифри.
SELECT 
    SUBSTRING(title, 1, 1) AS first_symbol,
    COUNT(*) AS total_count,
    SUM(price) AS total_price
FROM 
    library_storage
WHERE
    SUBSTRING(title, 1, 1) NOT REGEXP '^[a-zA-Z0-9]'
GROUP BY 
    SUBSTRING(title, 1, 1);
  
# 10. Змінити п. 9 так щоб до складу статистики потрапили дані з роками більшими за 2000.
SELECT 
    SUBSTRING(title, 1, 1) AS first_letter,
    COUNT(*) AS total_count,
    SUM(price) AS total_price
FROM 
    library_storage
WHERE
    SUBSTRING(title, 1, 1) NOT REGEXP '^[a-zA-Z0-9]' 
    AND
    YEAR(date) > 2000
GROUP BY 
    SUBSTRING(title, 1, 1);

# 11. Змінити п. 10. Відсортувати статистику по спадаючій перших букв назви.
SELECT 
    SUBSTRING(title, 1, 1) AS first_letter,
    COUNT(*) AS total_count,
    SUM(price) AS total_price
FROM 
    library_storage
WHERE
    SUBSTRING(title, 1, 1) NOT REGEXP '^[a-zA-Z0-9]' 
    AND
    YEAR(date) > 2000
GROUP BY 
    SUBSTRING(title, 1, 1) DESC;

# 12. Вивести статистику (див. 1) по кожному місяцю кожного року.
SELECT 
    MONTH(date) AS "month",
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY
	MONTH(date);
  
# 13. Змінити п. 12 так щоб до складу статистики не увійшли дані з незаповненими датами.
SELECT 
    MONTH(date) AS "month",
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
WHERE
	MONTH(date) IS NOT NULL
GROUP BY
	MONTH(date);
  
# 14. Змінити п. 12. Фільтр по спадаючій року і зростанню місяця.
SELECT 
    MONTH(date) AS "month",
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY
	YEAR(date) DESC,
    MONTH(date) ASC;
  
# 15. Вивести статистику для книг новинка / не новинка: загальна ціна, загальна ціна в грн. / Євро / руб. Колонкам запиту дати назви за змістом.
SELECT 
    novelty,
    COUNT(*) AS total_count,
    SUM(price) AS sum_price_USD,
    SUM(price) * 39 AS sum_price_UAH,
    SUM(price) * 0.9 AS sum_price_EUR,
    SUM(price) * 92 AS sum_price_RUB
FROM 
    library_storage
WHERE 
    novelty IN ('Yes', 'No')
GROUP BY 
    novelty;
  
# 16. Змінити п. 15 так щоб виводилася округлена до цілого числа (дол. / Грн. / Євро / руб.) Ціна.
SELECT 
    novelty,
    COUNT(*) AS total_count,
    ROUND(SUM(price)) AS sum_price_USD,
    ROUND(SUM(price) * 39) AS sum_price_UAH,
    ROUND(SUM(price) * 0.9) AS sum_price_EUR,
    ROUND(SUM(price) * 92) AS sum_price_RUB
FROM 
    library_storage
WHERE 
    novelty IN ('Yes', 'No')
GROUP BY 
    novelty;

# 17. Вивести статистику (див. 1) по видавництвах.
SELECT 
    publisher,
    COUNT(*) AS publisher_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY
    publisher;

  
# 18. Вивести статистику (див. 1) за темами і видавництвами. Фільтр по видавництвам.
SELECT 
    publisher, topic,
    COUNT(*) AS publisher_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY
    publisher;

# 19. Вивести статистику (див. 1) за категоріями, темами і видавництвами. Фільтр по видавництвам, темах, категоріям.
SELECT 
    category, topic, publisher,
    COUNT(*) AS publisher_count,
    SUM(price) AS sum_price,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM 
    library_storage
GROUP BY
    publisher, topic, category;

# 20. Вивести список видавництв, у яких округлена до цілого ціна однієї сторінки більше 10 копійок.
SELECT 
    publisher
FROM 
    library_storage
WHERE
    ROUND(price / pages) > 0.1
GROUP BY 
    publisher;
