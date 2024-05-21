-- 1. Розробити та перевірити скалярну (scalar) функцію, що повертає загальну вартість книг виданих в певному році.
DELIMITER //
CREATE FUNCTION totalCostByYear(input_year YEAR)
RETURNS DECIMAL (10, 2)
BEGIN
	DECLARE total_cost DECIMAL(10, 2);
    SELECT SUM(price) INTO total_cost
    FROM book_info
    WHERE input_year = YEAR(date);
    RETURN IFNULL(total_cost, 0.00);
END //
DELIMITER ;
SELECT totalCostByYear(1996) AS totalBookCost(YEAR)

-- 2. Розробити і перевірити табличну (inline) функцію, яка повертає список книг виданих в певному році.
-- Табличні функції існують лише в SQL Server, PostgreSQL
-- Але можна створити збережену процедуру, що буде працювати аналогічно
DELIMITER //
CREATE PROCEDURE getBooksByYear(input_year YEAR)
BEGIN
	SELECT *
	FROM book_info
    WHERE YEAR(date) = input_year;
END //
DELIMITER ;
CALL getBooksByYear(1996);

-- 3. Розробити і перевірити функцію типу multi-statement, яка буде:
  -- a. приймати в якості вхідного параметра рядок, що містить список назв видавництв, розділених символом ‘;’;
  -- b. виділяти з цього рядка назву видавництва;
DELIMITER //
CREATE PROCEDURE function3_a (IN input_str VARCHAR(1000))
BEGIN
  DECLARE semicol_id INT DEFAULT 0;
  DECLARE pub_name VARCHAR(255);
  
  IF TRIM(input_str)!= '' THEN
    SET input_str = CONCAT(TRIM(input_str), ';');
    
    WHILE LOCATE(';', input_str) > 0 DO
      SET semicol_id = LOCATE(';', input_str);
      SET pub_name = TRIM(SUBSTRING(input_str, 1, semicol_id - 1));
      SET input_str = SUBSTRING(input_str, semicol_id + 1);
      
      IF LENGTH(pub_name) > 0 THEN
        INSERT IGNORE INTO book_publisher (publisher) VALUES (pub_name);
      END IF;
    END WHILE;
  END IF;
END //
DELIMITER ;

CALL function3_a ('ДМК; МикроАрт');
CALL function3_a ('паблішер1; паблішер2');

  -- c. формувати нумерований список назв видавництв.
DELIMITER //
CREATE PROCEDURE function3_c (IN input_str VARCHAR(1000))
BEGIN
  DECLARE semicol_id INT DEFAULT 0;
  DECLARE pub_name VARCHAR(255);
  DECLARE count INT DEFAULT 1;
  DECLARE formatted_list TEXT DEFAULT '';
  
  IF TRIM(input_str)!= '' THEN
    SET input_str = CONCAT(TRIM(input_str), ';');
    
    WHILE LOCATE(';', input_str) > 0 DO
      SET semicol_id = LOCATE(';', input_str);
      SET pub_name = TRIM(SUBSTRING(input_str, 1, semicol_id - 1));
      SET input_str = SUBSTRING(input_str, semicol_id + 1);
      
      IF LENGTH(pub_name) > 0 THEN
        SET formatted_list = CONCAT(formatted_list, CONCAT(count, '. ', pub_name, '\n'));
        SET count = count + 1;
      END IF;
    END WHILE;
  SELECT formatted_list as formattedList;
  END IF;
END //
DELIMITER ;

CALL function3_c ('ДМК; МикроАрт');

-- 4. Виконати набір операцій по роботі з SQL курсором: 
DELIMITER //
CREATE PROCEDURE function4()
BEGIN
  -- a. використовувати змінну для оголошення курсору;
  DECLARE fetched_data DECIMAL(5, 2);
  DECLARE is_finished INT DEFAULT FALSE;
  
  DECLARE price_cursor CURSOR FOR 
  SELECT price
  FROM book_info 
  WHERE YEAR(date) = 2020;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_finished = TRUE;
  
  -- b. відкрити курсор;
  OPEN price_cursor;

  -- d. виконати вибірку даних з курсору;
  read_loop: LOOP
    FETCH price_cursor INTO fetched_data;
    IF is_finished THEN
      LEAVE read_loop;
    END IF;
  END LOOP read_loop;

  -- e. закрити курсор;
  CLOSE price_cursor;
END //
DELIMITER ;

CALL function4();

-- 5. Розробити курсор для виводу списка книг виданих у визначеному році.
DELIMITER //
CREATE PROCEDURE function5(IN input_int INT)
BEGIN
  DECLARE book_id INT;
  DECLARE book_name VARCHAR(255);
  DECLARE book_date DATE;
  
  DECLARE is_finished INT DEFAULT FALSE;
  DECLARE book_cursor CURSOR FOR
  SELECT id, title, date
  FROM book_info
  WHERE YEAR(date) = input_int;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_finished = TRUE;
  
  OPEN book_cursor;
  read_loop: LOOP
    FETCH book_cursor into book_id, book_name, book_date;
    IF is_finished THEN
      LEAVE read_loop;
    END IF;
    SELECT CONCAT('Book ID: ', book_id, ', Name: ', book_name, ', Date: ', book_date) AS bookInfo;
  END LOOP;
  CLOSE book_cursor;
END //
DELIMITER ;

CALL function5(2020);
DROP PROCEDURE function5;
