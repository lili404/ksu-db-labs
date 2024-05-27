CREATE TABLE specie (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(64) UNIQUE NOT NULL
);

CREATE TABLE breed (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(64) UNIQUE NOT NULL
);

CREATE TABLE animal (
  id INT PRIMARY KEY AUTO_INCREMENT,
  specie INT NOT NULL,
  breed INT NOT NULL,
  birth_date DATE DEFAULT NULL,
  gender VARCHAR(1) DEFAULT NULL,
  weight DECIMAL(5,2) DEFAULT NULL,
  FOREIGN KEY (specie) REFERENCES specie(id),
  FOREIGN KEY (breed) REFERENCES breed(id)
);

CREATE TABLE salary (
  id INT PRIMARY KEY AUTO_INCREMENT,
  salary INT NOT NULL UNIQUE 
);

CREATE TABLE job_position (
  id INT PRIMARY KEY AUTO_INCREMENT,
  position VARCHAR(32) UNIQUE NOT NULL,
  salary INT NOT NULL,
  FOREIGN KEY (salary) REFERENCES salary(id)
);

CREATE TABLE staff (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(128) NOT NULL,
  gender VARCHAR(1) NOT NULL,
  age INT NOT NULL,
  position_id INT NOT NULL,
  shift VARCHAR(5) DEFAULT NULL,
  FOREIGN KEY (position_id) REFERENCES job_position(id)
);

CREATE TABLE medicine (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(32) NOT NULL UNIQUE,
  available DECIMAL(5,2) DEFAULT NULL
);

CREATE TABLE health_care (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL,
  date DATE NOT NULL,
  diagnosis TEXT NULL,
  medicine_id INT NULL,
  quantity DECIMAL(5,2) NULL,
  staff_id INT NOT NULL,  
  FOREIGN KEY (animal_id) REFERENCES animal(id),
  FOREIGN KEY (medicine_id) REFERENCES medicine(id),
  FOREIGN KEY (staff_id) REFERENCES staff(id)
);

CREATE TABLE food (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(32) NOT NULL UNIQUE,
  available DECIMAL(5,2) DEFAULT NULL,
  units VARCHAR(8) NOT NULL
);

CREATE TABLE feeding_schedule (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL UNIQUE,
  time TIME NOT NULL,
  food_id INT NOT NULL,
  quantity DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (animal_id) REFERENCES animal(id),
  FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE visitor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(128) NOT NULL UNIQUE,
  gender VARCHAR(1) NOT NULL,
  age INT NOT NULL,
  visit_count INT NOT NULL DEFAULT 0
);

CREATE TABLE ticket (
  id INT PRIMARY KEY AUTO_INCREMENT,
  visitor_id INT NOT NULL,
  buy_date DATETIME NOT NULL,
  visit_date DATETIME NOT NULL,
  used BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (visitor_id) REFERENCES visitor(id)
);

-- INSERT VALUES
-- Insert salaries
INSERT INTO salary(salary) VALUES
  (50000),
  (35000),
  (20000),
  (15000);

-- Insert job positions
INSERT INTO job_position(position, salary) VALUES
  ('Zoo Manager', (SELECT id FROM salary WHERE salary = 50000)),
  ('Veterinarian', (SELECT id FROM salary WHERE salary = 35000)),
  ('Keeper', (SELECT id FROM salary WHERE salary = 20000)),
  ('Cashier', (SELECT id FROM salary WHERE salary = 15000));

-- Insert staff members
INSERT INTO staff(full_name, gender, age, position_id, shift) VALUES
  -- Zoo Manager
  ('John Doe', 'M', 30, (SELECT id FROM job_position WHERE position = 'Zoo Manager'), 'Day'),
  -- Veterinarians
  ('Jane Smith', 'F', 28, (SELECT id FROM job_position WHERE position = 'Veterinarian'), 'Day'),
  ('Michael Johnson', 'M', 36, (SELECT id FROM job_position WHERE position = 'Veterinarian'), 'Night'),
  -- Keepers
  ('Emily Brown', 'F', 22, (SELECT id FROM job_position WHERE position = 'Keeper'), 'Day'),
  ('David Lee', 'M', 24, (SELECT id FROM job_position WHERE position = 'Keeper'), 'Day'),
  ('Jessica Taylor', 'F', 20, (SELECT id FROM job_position WHERE position = 'Keeper'), 'Night'),
  -- Cashier
  ('Chris Evans', 'M', 26, (SELECT id FROM job_position WHERE position = 'Cashier'), 'Day');

-- Insert specie types
INSERT INTO specie (type) VALUES 
  ('Lion'),
  ('Tiger'),
  ('Gorilla'),
  ('Chimpanzee'),
  ('Orangutan'),
  ('Bear'),
  ('Giraffe'),
  ('Lemur'),
  ('Zebra'),
  ('Parrot');

-- Insert breed types
INSERT INTO breed (type) VALUES 
  ('African Lion'),
  ('Bengal Tiger'),
  ('Western Lowland Gorilla'),
  ('Ruslan Chimpanzee'),
  ('Bornean Orangutan'),
  ('Grizzly Bear'),
  ('Masai Giraffe'),
  ('King Julien Lemur'),
  ('Plains Zebra'),
  ('African Grey Parrot');

-- Insert each animal properties
INSERT INTO animal(specie, breed, birth_date, gender, weight) VALUES
  ((SELECT id FROM specie WHERE type = 'Lion'), (SELECT id FROM breed WHERE type = 'African Lion'), '2000-01-25', 'M', 230.00),
  ((SELECT id FROM specie WHERE type = 'Tiger'), (SELECT id FROM breed WHERE type = 'Bengal Tiger'), '2002-03-15', 'F', 180.00),
  ((SELECT id FROM specie WHERE type = 'Gorilla'), (SELECT id FROM breed WHERE type = 'Western Lowland Gorilla'), '1998-07-10', 'M', 300.00),
  ((SELECT id FROM specie WHERE type = 'Chimpanzee'), (SELECT id FROM breed WHERE type = 'Ruslan Chimpanzee'), '2005-05-03', 'F', 70.00),
  ((SELECT id FROM specie WHERE type = 'Orangutan'), (SELECT id FROM breed WHERE type = 'Bornean Orangutan'), '2003-11-20', 'M', 150.00),
  ((SELECT id FROM specie WHERE type = 'Bear'), (SELECT id FROM breed WHERE type = 'Grizzly Bear'), '2007-09-28', 'F', 350.00),
  ((SELECT id FROM specie WHERE type = 'Giraffe'), (SELECT id FROM breed WHERE type = 'Masai Giraffe'), '2010-12-12', 'M', 900.00),
  ((SELECT id FROM specie WHERE type = 'Lemur'), (SELECT id FROM breed WHERE type = 'King Julien Lemur'), '2012-06-08', 'F', 5.00),
  ((SELECT id FROM specie WHERE type = 'Zebra'), (SELECT id FROM breed WHERE type = 'Plains Zebra'), '2015-04-19', 'M', 350.00),
  ((SELECT id FROM specie WHERE type = 'Parrot'), (SELECT id FROM breed WHERE type = 'African Grey Parrot'), '2018-08-02', 'M', 0.50);

-- Insert available medicine
INSERT INTO medicine (type, available)
VALUES ('Doxycycline', 10.00),
       ('Prednisone', 15.00),
       ('Metronidazole', 10.00),
       ('Cephalexin', 15.00),
       ('Enrofloxacin', 10.00),
       ('Tramadol', 10.00),
       ('Dexamethasone', 20.00),
       ('Amoxicillin', 15.00),
       ('Carprofen', 15.00),
       ('Meloxicam', 5.00);

-- Insert health care info per animal
INSERT INTO health_care (animal_id, date, diagnosis, medicine_id, quantity, staff_id) VALUES
  -- Lion
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lion')), CURDATE(), 'Healthy', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Tiger
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Tiger')), CURDATE(), 'Vaccination', (SELECT id FROM medicine WHERE type = 'Doxycycline'), 1.00, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Gorilla
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Gorilla')), CURDATE(), 'Injury treatment', (SELECT id FROM medicine WHERE type = 'Metronidazole'), 0.50, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Chimpanzee
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Chimpanzee')), CURDATE(), 'Healthy', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Orangutan
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Orangutan')), CURDATE(), 'Behavioral consultation', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Bear
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Bear')), CURDATE(), 'Healthy', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Giraffe
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Giraffe')), CURDATE(), 'Hoof trimming', (SELECT id FROM medicine WHERE type = 'Carprofen'), 2.00, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Lemur
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lemur')), CURDATE(), 'Eye infection treatment', (SELECT id FROM medicine WHERE type = 'Amoxicillin'), 0.50, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Zebra
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Zebra')), CURDATE(), 'Wound dressing', (SELECT id FROM medicine WHERE type = 'Enrofloxacin'), 1.00, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Parrot
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Parrot')), CURDATE(), 'Healthy', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Michael Johnson'));

-- Insert food types and available quantity
INSERT INTO food (type, available, units) VALUES
  ('Meat', 400.00, 'kg'),
  ('Fruits', 160.00, 'kg'),
  ('Fish', 70.00, 'kg'),
  ('Leaves', 200.00, 'kg'),
  ('Grass', 150.00, 'kg'),
  ('Seeds', 10.00, 'kg');

-- Insert feeding schedule per animal
INSERT INTO feeding_schedule (animal_id, time, food_id, quantity) VALUES
  -- Lion
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lion')), '08:00:00', (SELECT id FROM food WHERE type = 'Meat'), 5.00),
  -- Tiger
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Tiger')), '08:30:00', (SELECT id FROM food WHERE type = 'Meat'), 4.00),
  -- Gorilla
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Gorilla')), '09:00:00', (SELECT id FROM food WHERE type = 'Fruits'), 6.00),
  -- Chimpanzee
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Chimpanzee')), '09:30:00', (SELECT id FROM food WHERE type = 'Fruits'), 7.00),
  -- Orangutan
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Orangutan')), '10:00:00', (SELECT id FROM food WHERE type = 'Fruits'), 3.00),
  -- Bear
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Bear')), '10:30:00', (SELECT id FROM food WHERE type = 'Fish'), 8.00),
  -- Giraffe
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Giraffe')), '11:00:00', (SELECT id FROM food WHERE type = 'Leaves'), 10.00),
  -- Lemur
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lemur')), '11:30:00', (SELECT id FROM food WHERE type = 'Fruits'), 1.00),
  -- Zebra
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Zebra')), '12:00:00', (SELECT id FROM food WHERE type = 'Grass'), 12.00),
  -- Parrot
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Parrot')), '12:30:00', (SELECT id FROM food WHERE type = 'Seeds'), 0.50);

-- Insert visitor info
INSERT INTO visitor (full_name, gender, age) VALUES
  ('John Doe', 'M', 20),
  ('Jane Smith', 'F', 16),
  ('Alex Johnson', 'M', 24),
  ('Emily Davis', 'F', 18),
  ('Michael Brown', 'M', 15),
  ('Pat Taylor', 'M', 21),
  ('Chris Wilson', 'M', 32),
  ('Jessica Garcia', 'F', 28);

-- Insert ticket info
INSERT INTO ticket (visitor_id, buy_date, visit_date) VALUES
  ((SELECT id FROM visitor WHERE full_name = 'John Doe'), '2024-06-01 08:25:21', '2024-06-02 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Jane Smith'), '2024-06-02 13:10:34', '2024-06-03 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Alex Johnson'), '2024-06-03 18:27:13', '2024-06-04 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Emily Davis'), '2024-06-04 07:27:27', '2024-06-05 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Michael Brown'), '2024-05-06 04:11:04', '2024-06-06 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Pat Taylor'), '2024-06-06 14:11:29', '2024-06-07 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Chris Wilson'), '2024-06-07 13:54:43', '2024-06-08 08:00:00'),
  ((SELECT id FROM visitor WHERE full_name = 'Jessica Garcia'), '2024-06-08 12:39:21', '2024-06-09 08:00:00');

-- QUERIES
-- 1. List all animal species
SELECT * FROM specie ORDER BY id;
-- 1.1. Find total number of animal species
SELECT COUNT(*) AS totalSpecieCount FROM specie;

-- 2. List all animal breeds
SELECT * FROM breed ORDER BY id;
-- 2.1. Find total number of animal breeds
SELECT COUNT(*) AS totalBreedCount FROM breed ;

-- 3. List all animals
SELECT * FROM animal ORDER BY id;
-- 3.1. Find total number of animals
SELECT COUNT(*) AS totalAnimalCount FROM animal;

-- 4. List all food types
SELECT * FROM food ORDER BY id;
-- 4.1. Find total number of food types
SELECT COUNT(*) AS totalFoodTypeCount FROM food;

-- 5. List feeding schedules
SELECT * FROM feeding_schedule ORDER BY id;
-- 5.1. Find total number of feeding schedules
SELECT COUNT(*) AS totalFeedingScheduleCount FROM feeding_schedule;

-- 6. List all medicine types
SELECT * FROM medicine ORDER BY id;
-- 6.1. Find total number of medicine types
SELECT COUNT(*) AS totalMedicineTypeCount FROM medicine;

-- 7. List health care reports
SELECT * FROM health_care ORDER BY id;
-- 7.1. Find total number of health care reports
SELECT COUNT(*) AS totalHealthCareReportCount FROM health_care;

-- 8. List all staff members
SELECT * FROM staff ORDER BY id;
-- 8.1. Find total number of staff members
SELECT COUNT(*) AS totalStaffMemberCount FROM staff;

-- 9. List all job positions
SELECT * FROM job_position ORDER BY id;
-- 9.1. Find total number of job positions
SELECT COUNT(*) AS totalJobPositionCount FROM job_position;

-- 10. List all salaries
SELECT * FROM salary ORDER BY id;
-- 10.1. Find total number of possible salaries(at this zoo)
SELECT COUNT(*) AS totalSalaryTypeCount FROM salary;

-- 11. List all visitors
SELECT * FROM visitor ORDER BY id;
-- 11.1. Find total number of visitors
SELECT COUNT(*) AS totalVisitorCount FROM visitor;

-- 12. List all bought tickets
SELECT * FROM ticket ORDER BY id;
-- 12.1. Find total number of bought tickets
SELECT COUNT(*) AS totalSoldTicketCount FROM ticket;

-- 13. List all animals that weight >= 200 kg
SELECT * FROM animal
WHERE weight >= 200;

-- 14. List all animals whose age > 20 years
SELECT * FROM animal
WHERE DATEDIFF(CURDATE(), birth_date) / 365.25 >= 20;

-- 15. List all animals that are male
SELECT * FROM animal
WHERE gender = 'M';
-- 15.1. List all animals that are female
SELECT * FROM animal
WHERE gender = 'F';

-- 16. List all animals that are healthy
SELECT
  a.id,
  s.type
  AS specie,
  b.type
  AS breed,
  a.birth_date,
  a.gender
  FROM animal a
JOIN specie s ON a.specie = s.id
JOIN breed b ON a.breed = b.id
JOIN health_care hc ON a.id = hc.animal_id
WHERE hc.diagnosis = 'Healthy';

-- 16.1 List all animals that are not healthy
SELECT
  a.id,
  s.type
  AS specie,
  b.type
  AS breed,
  a.birth_date,
  a.gender
  FROM animal a
JOIN specie s ON a.specie = s.id
JOIN breed b ON a.breed = b.id
JOIN health_care hc ON a.id = hc.animal_id
WHERE hc.diagnosis != 'Healthy';

-- 17. List a health care report about gorilla
SELECT 
    a.id AS animal_id, 
    s.type AS specie, 
    b.type AS breed, 
    a.birth_date, 
    a.gender, 
    a.weight, 
    hc.date AS health_care_date, 
    hc.diagnosis, 
    m.type AS medicine, 
    hc.quantity AS medicine_quantity, 
    st.full_name AS veterinarian
FROM 
    animal a
JOIN specie s ON a.specie = s.id
JOIN breed b ON a.breed = b.id
JOIN health_care hc ON a.id = hc.animal_id
JOIN medicine m ON hc.medicine_id = m.id
JOIN staff st ON hc.staff_id = st.id
WHERE s.type = 'Gorilla';

-- 18. Find the type and quantity of food that tiger eats per day
SELECT 
	s.type AS specie_type,
    f.type AS food_type, 
    fs.quantity AS food_quantity
FROM 
    animal a
JOIN specie s ON a.specie = s.id
JOIN feeding_schedule fs ON a.id = fs.animal_id
JOIN food f ON fs.food_id = f.id
WHERE s.type = 'Tiger';

-- 19. List staff whose age is >= 24
SELECT * FROM staff
WHERE age >= 24;

-- 20. List all zoo managers
SELECT * FROM staff
WHERE position_id = (SELECT id FROM job_position WHERE position = 'Zoo Manager');
-- 20.1. List all veterinarians
SELECT * FROM staff
WHERE position_id = (SELECT id FROM job_position WHERE position = 'Veterinarian');
-- 20.2. List all keepers
SELECT * FROM staff
WHERE position_id = (SELECT id FROM job_position WHERE position = 'Keeper');
-- 20.3. List all cashiers
SELECT * FROM staff
WHERE position_id = (SELECT id FROM job_position WHERE position = 'Cashier');

-- 21. List staff that works in the day shifts
SELECT * FROM staff
WHERE shift = 'Day';
-- 21.1. List staff that works in the night shifts
SELECT * FROM staff
WHERE shift = 'Night';

-- 22. List staff whose salary > 20000
SELECT 
  s.*,
  sal.salary
FROM staff s
JOIN job_position jp ON s.position_id = jp.id
JOIN salary sal ON jp.salary = sal.id
WHERE sal.salary >= 20000;
-- 22.1. List staff whose salary <= 20000
SELECT 
  s.*,
  sal.salary
FROM staff s
JOIN job_position jp ON s.position_id = jp.id
JOIN salary sal ON jp.salary = sal.id
WHERE sal.salary <= 20000;

-- 23. Find the average age of staff
SELECT ROUND(AVG(age)) AS average_age
FROM staff;

-- 24. Find out which gender visits the zoo the most
SELECT gender, COUNT(*) AS visit_count
FROM visitor
GROUP BY gender
ORDER BY visit_count DESC
LIMIT 1;

-- 25. Find the average age of visitor
SELECT ROUND(AVG(age)) AS average_age
FROM visitor;

-- 26. Update the ticket 'used' state
UPDATE ticket
SET used = TRUE
WHERE id = 1;

SELECT used FROM ticket WHERE id = 1;

UPDATE ticket
SET used = FALSE
WHERE id = 1;

SELECT used FROM ticket WHERE id = 1;
