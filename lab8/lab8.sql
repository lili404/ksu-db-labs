-- 1. Кількість тем може бути в діапазоні від 5 до 10.
DELIMITER //
CREATE TRIGGER trigger1 BEFORE INSERT ON book_topic
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM book_topic) >= 10
  THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість тем не може бути більшою за 10';
  ELSEIF (SELECT COUNT(*) FROM book_topic) <= 5
  THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість тем не може бути меншою за 5';
  END IF;
END; 
//
DELIMITER ;

INSERT INTO book_topic(topic) VALUES
  ('топік4'),
  ('топік5'),
  ('топік6'),
  ('топік7'),
  ('топік8'),
  ('топік9'),
  ('топік10');

INSERT INTO book_topic(topic) VALUES
  ('топік11');

-- 2. Новинкою може бути тільки книга видана в поточному році.
DELIMITER //
CREATE TRIGGER trigger2 BEFORE INSERT ON book_info
FOR EACH ROW
BEGIN
  IF NEW.novelty = 'Yes' THEN
    IF YEAR(NEW.date) != YEAR(CURRENT_DATE) THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Новинкою може бути тільки книга видана в поточному році.';
    END IF;
  END IF;
END; 
//
DELIMITER ;

INSERT INTO book_info VALUES
(300,10000,'Yes','Назва',0.00,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,'2024-01-01',NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 3. Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $.
DELIMITER //
CREATE TRIGGER trigger3
BEFORE INSERT ON book_info
FOR EACH ROW 
BEGIN
  IF NEW.pages < 100 AND NEW.price > 10 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ціна книги з кількістю сторінок до 100 не може перевищувати 10';
  ELSEIF NEW.pages < 200 AND NEW.price > 20 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ціна книги з кількістю сторінок до 200 не може перевищувати 20';
  ELSEIF NEW.pages < 300 AND NEW.price > 30 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ціна книги з кількістю сторінок до 300 не може перевищувати 30';
  END IF;
END;
// DELIMITER ;

INSERT INTO book_info VALUES
(301,10001,'No','Назва',10.01,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  99,NULL,NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));
  
INSERT INTO book_info VALUES
(302,10002,'No','Назва',20.01,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  199,NULL,NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

INSERT INTO book_info VALUES
(303,10003,'No','Назва',30.01,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  299,NULL,NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 4. Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.
DELIMITER //
CREATE TRIGGER trigger4 BEFORE INSERT ON book_info
FOR EACH ROW
BEGIN
  IF NEW.publisher = (SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV') 
  AND NEW.circulation < 5000 THEN 
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво "BHV" не випускає книги накладом меншим 5000';
  ELSEIF NEW.publisher = (SELECT id FROM book_publisher WHERE publisher = 'Diasoft')
  AND NEW.circulation < 10000 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво Diasoft не випускає книги накладом меншим 10000';
  END IF;
END; 
//
DELIMITER ;

INSERT INTO book_info VALUES
(304,10004,'No','Назва',9.99,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  150,NULL,NULL,4999,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

INSERT INTO book_info VALUES
(305,10005,'No','Назва',9.99,(SELECT id FROM book_publisher WHERE publisher = 'Diasoft'),
  150,NULL,NULL,9999,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 5. Книги з однаковим кодом повинні мати однакові дані.
DELIMITER //
CREATE TRIGGER trigger5
BEFORE INSERT ON book_info
FOR EACH ROW 
BEGIN
  DECLARE id_count INT;
  SELECT COUNT(*) INTO id_count FROM book_info WHERE id = NEW.id;
  IF id_count > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книга з таким кодом вже існує';
  END IF;
END
// DELIMITER ;

INSERT INTO book_info VALUES
(306,5110,'No','Назва',9.99,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  150,NULL,NULL,5000,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 6. При спробі видалення книги видається інформація про кількість видалених рядків. Якщо користувач не "dbo", то видалення забороняється.
DELIMITER //
CREATE TRIGGER trigger6
BEFORE DELETE ON book_info
FOR EACH ROW 
BEGIN
  IF SUBSTRING_INDEX(USER(), '@', 1) != 'dbo' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Лише "dbo" може видаляти записи';
  END IF;
END
// DELIMITER ;

DELETE FROM book_info WHERE book_info.n = 2;

-- 7. Користувач "dbo" не має права змінювати ціну книги.
DELIMITER //
CREATE TRIGGER trigger7
BEFORE UPDATE ON book_info
FOR EACH ROW 
BEGIN
  IF SUBSTRING_INDEX(USER(), '@', 1) = 'dbo' AND OLD.price != NEW.price THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувачу dbo заборонено змінювати ціну книги';
  END IF;
END
// DELIMITER ;

UPDATE book_info
SET price = 10
WHERE n = 2;

-- 8. Видавництва ДМК і Еком підручники не видають.
DELIMITER //
CREATE TRIGGER trigger8 BEFORE INSERT ON book_info
FOR EACH ROW
BEGIN
  IF NEW.publisher = (SELECT id FROM book_publisher WHERE publisher = 'ДМК') 
  AND NEW.category = (SELECT id FROM book_category WHERE category = 'Підручники') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво "ДМК" не видає підручники';
  ELSEIF NEW.publisher = (SELECT id FROM book_publisher WHERE publisher = 'Эком') 
  AND NEW.category = (SELECT id FROM book_category WHERE category = 'Підручники') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво "Еком" не видає підручники';
  END IF;
END; 
//
DELIMITER ;

INSERT INTO book_info VALUES
(307,10007,'No','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'ДМК'),
  NULL,NULL,NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

INSERT INTO book_info VALUES
(308,10008,'No','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Эком'),
  NULL,NULL,NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 9. Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року. 
DELIMITER //
CREATE TRIGGER trigger9
BEFORE INSERT ON book_info
FOR EACH ROW
BEGIN
  IF NEW.novelty = 'Yes' THEN
    IF (SELECT COUNT(*)
        FROM book_info
        WHERE publisher = NEW.publisher
          AND YEAR(date) = YEAR(CURRENT_DATE())
          AND MONTH(date) = MONTH(CURRENT_DATE())
          AND novelty = 'Yes') >= 10 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.';
    END IF;
  END IF;
END //
DELIMITER ;

INSERT INTO book_info VALUES
(309,10009,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),
  
(310,10010,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),
  
(311,10011,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),

(312,10012,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),
  
(313,10013,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),

(314,10014,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),
  
(315,10015,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),

(316,10016,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),

(317,10017,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники')),

(318,10018,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 11th element
INSERT INTO book_info VALUES
(319,10019,'Yes','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,NULL,CURRENT_DATE,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));

-- 10. Видавництво BHV не випускає книги формату 60х88 / 16.
DELIMITER //
CREATE TRIGGER trigger10
BEFORE INSERT ON book_info
FOR EACH ROW
BEGIN
  IF NEW.publisher = (
  SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV') 
  AND NEW.format = '60x88/16' THEN 
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавнича група BHV не випускає книги формату 60х88/16';
  END IF;
END
// DELIMITER ;

INSERT INTO book_info VALUES
(320,10020,'No','Назва',NULL,(SELECT id FROM book_publisher WHERE publisher = 'Видавнича група BHV'),
  NULL,'60x88/16',NULL,NULL,(SELECT id FROM book_topic WHERE topic = 'Використання ПК в цілому'),
  (SELECT id FROM book_category WHERE category = 'Підручники'));
