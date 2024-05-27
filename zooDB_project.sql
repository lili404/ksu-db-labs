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
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lion')), CURDATE(), 'Routine checkup', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Tiger
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Tiger')), CURDATE(), 'Vaccination', (SELECT id FROM medicine WHERE type = 'Doxycycline'), 1.00, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Gorilla
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Gorilla')), CURDATE(), 'Injury treatment', (SELECT id FROM medicine WHERE type = 'Metronidazole'), 0.50, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Chimpanzee
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Chimpanzee')), CURDATE(), 'Dental examination', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Orangutan
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Orangutan')), CURDATE(), 'Behavioral consultation', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Bear
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Bear')), CURDATE(), 'Weight check', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Giraffe
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Giraffe')), CURDATE(), 'Hoof trimming', (SELECT id FROM medicine WHERE type = 'Carprofen'), 2.00, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Lemur
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Lemur')), CURDATE(), 'Eye infection treatment', (SELECT id FROM medicine WHERE type = 'Amoxicillin'), 0.50, (SELECT id FROM staff WHERE full_name = 'Michael Johnson')),
  -- Zebra
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Zebra')), CURDATE(), 'Wound dressing', (SELECT id FROM medicine WHERE type = 'Enrofloxacin'), 1.00, (SELECT id FROM staff WHERE full_name = 'Jane Smith')),
  -- Parrot
  ((SELECT id FROM animal WHERE specie = (SELECT id FROM specie WHERE type = 'Parrot')), CURDATE(), 'Feather examination', NULL, NULL, (SELECT id FROM staff WHERE full_name = 'Michael Johnson'));

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


