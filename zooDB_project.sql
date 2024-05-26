CREATE TABLE medical_record (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL,
  veterinarian_id INT NOT NULL,
  date DATE NOT NULL,
  diagnosis TEXT NOT NULL,
  treatment TEXT NULL,
  FOREIGN KEY (animalID) REFERENCES animal(id),
  FOREIGN KEY (veterinarianID) REFERENCES veterinarian(id)
);

CREATE TABLE animal (
  id INT PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  birth_date DATE DEFAULT NULL,
  gender VARCHAR(16) DEFAULT NULL,
  weight DECIMAL(5,2) DEFAULT NULL,
  health_status INT NOT NULL,
  FOREIGN KEY (health_status) REFERENCES medical_record(animal_id)
);

CREATE TABLE keeper (
  id INT PRIMARY KEY,
  full_name VARCHAR(128) NOT NULL,
  shift VARCHAR(5) DEFAULT NULL
);

CREATE TABLE feeding_schedule (
  id INT PRIMARY KEY,
  animal_id INT NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  food_type VARCHAR(128) NOT NULL,
  quantity DECIMAL(5,2) NOT NULL,
  keeper_id  INT NOT NULL,
  FOREIGN KEY (animal_id) REFERENCES animal(id),
  FOREIGN KEY (keeper_id) REFERENCES keeper(id)
);

CREATE TABLE visitors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(128) NOT NULL,
  visit_count INT NOT NULL DEFAULT 0
);

CREATE TABLE tickets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  visitor_id INT NOT NULL,
  buy_date DATE NOT NULL,
  visit_date DATE NOT NULL,
  visit_time TIME NOT NULL,
  used BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (visitor_id) REFERENCES visitors(id)
);




 
