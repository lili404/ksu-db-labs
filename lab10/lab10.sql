-- 1. Створити користувальницький тип даних для зберігання оцінки учня на основі стандартного типу tinyint з можливістю використання порожніх
-- значень.
CREATE TABLE student_grade (
  grade TINYINT DEFAULT NULL,
  PRIMARY KEY (grade)
);

-- 2. Створити об'єкт-замовчування (default) зі значенням 3.
ALTER TABLE student_grade MODIFY grade TINYINT DEFAULT 3;

-- 4. Отримати інформацію про призначений для користувача тип даних.
DESCRIBE student_grade;

-- 5. Створити об'єкт-правило (rule): a> = 1 і a <= 5 і зв'язати його з призначеним для користувача типом даних для оцінки.
ALTER TABLE student_grade ADD CHECK (grade >= 1 AND grade <= 5);

-- 6. Створити таблицю "Успішність студента", використовуючи новий тип даних. У таблиці повинні бути оцінки студента з кількох предметів.
CREATE TABLE student_performance (
  studentID INT PRIMARY KEY,
  mathGrade TINYINT,
  historyGrade TINYINT,
  biologyGrade TINYINT,
  FOREIGN KEY (mathGrade) REFERENCES student_grade(grade),
  FOREIGN KEY (historyGrade) REFERENCES student_grade(grade),
  FOREIGN KEY (biologyGrade) REFERENCES student_grade(grade)
);

DESCRIBE student_performance

-- 7. Скасувати всі прив'язки і видалити з бази даних тип даних користувача, замовчування і правило.
DROP TABLE student_performance;
DROP TABLE student_grade;
