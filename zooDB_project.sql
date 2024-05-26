CREATE TABLE health_report (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL UNIQUE,
  veterinarian_id INT NOT NULL,
  completion_date DATE NOT NULL,
  diagnosis TEXT NOT NULL,
  treatment TEXT NULL,
  FOREIGN KEY (animal_id) REFERENCES animal(id),
  FOREIGN KEY (veterinarian_id) REFERENCES veterinarian(id)
);

CREATE TABLE specie (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(64) UNIQUE NOT NULL
);

CREATE TABLE breed (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(64) UNIQUE NOT NULL
);

CREATE TABLE animal (
  id INT PRIMARY KEY,
  specie INT NOT NULL,
  breed INT NOT NULL,
  birth_date DATE DEFAULT NULL,
  gender VARCHAR(1) DEFAULT NULL,
  weight DECIMAL(5,2) DEFAULT NULL,
  health_status INT NOT NULL UNIQUE,
  FOREIGN KEY (specie) REFERENCES specie(id),
  FOREIGN KEY (breed) REFERENCES breed(id),
  FOREIGN KEY (health_status) REFERENCES health_report(animal_id)
);

CREATE TABLE keeper (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(128) NOT NULL,
  gender VARCHAR(1) NOT NULL,
  shift VARCHAR(5) DEFAULT NULL
);

CREATE TABLE food_storage (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(32) NOT NULL UNIQUE,
  available DECIMAL(5,2) DEFAULT NULL,
  units VARCHAR(8) NOT NULL
);

CREATE TABLE feeding_schedule (
  id INT PRIMARY KEY,
  animal_id INT NOT NULL UNIQUE,
  date DATE NOT NULL,
  time TIME NOT NULL,
  food_id INT NOT NULL,
  quantity DECIMAL(5,2) NOT NULL,
  keeper_id INT NOT NULL,
  FOREIGN KEY (animal_id) REFERENCES animal(id),
  FOREIGN KEY (food_id) REFERENCES food_storage(id),
  FOREIGN KEY (keeper_id) REFERENCES keeper(id)
);

CREATE TABLE visitor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(128) NOT NULL UNIQUE,
  gender VARCHAR(1) NOT NULL,
  visit_count INT NOT NULL DEFAULT 0
);

CREATE TABLE ticket (
  id INT PRIMARY KEY AUTO_INCREMENT,
  visitor_id INT NOT NULL,
  buy_date DATETIME NOT NULL,
  visit_date DATETIME NOT NULL,
  used BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (visitor_id) REFERENCES visitors(id)
);

CREATE TABLE med_storage (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(32) NOT NULL UNIQUE,
  available DECIMAL(5,2) DEFAULT NULL
);
