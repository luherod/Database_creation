DROP TABLE subject_bootcamp;
DROP TABLE employment_contract;
DROP table tuition;
DROP TABLE subject;
DROP TABLE bootcamp;
DROP TABLE teacher;
DROP TABLE student;

CREATE TABLE student (
    student_id SERIAL PRIMARY KEY
  , st_name VARCHAR(50) NOT NULL
  , st_surname VARCHAR(50) NOT NULL
  , st_email VARCHAR(100) NOT NULL
  , st_phone VARCHAR(20) NOT NULL
  , registration_date DATE NOT NULL
);


INSERT INTO student (st_name, st_surname, st_email, st_phone, registration_date) VALUES
    ('María', 'González', 'maria.gonzalez@gmail.com', '+34 612345678', '2023-09-15')
  , ('Juan', 'Pérez', 'juan.perez@hotmail.com', '+52 5543218765', '2023-09-16')
  , ('Ana', 'Martínez', 'ana.martinez@yahoo.es', '+57 3106549876', '2023-09-17')
  , ('Carlos', 'Rodríguez', 'carlos.rodriguez@outlook.com', '+54 9114567890', '2023-09-18')
  , ('Sofía', 'López', 'sofia.lopez@correo.com', '+56 987654321', '2023-09-19');


CREATE TABLE teacher(
    teacher_id SERIAL PRIMARY KEY
  , tch_name VARCHAR(50) NOT NULL
  , tch_surname VARCHAR(50) NOT NULL
  , tch_email VARCHAR(100) NOT NULL
  , tch_phone VARCHAR(20) NOT NULL
);


INSERT INTO teacher (tch_name, tch_surname, tch_email, tch_phone) VALUES
    ('Lucas', 'García', 'carlos.garcia@keepcoding.io', '+34 612345678')
  , ('María', 'López', 'maria.lopez@keepcoding.io', '+34 622345678')
  , ('José', 'Martínez', 'jose.martinez@keepcoding.io', '+34 632345678')
  , ('Sara', 'Fernández', 'lucia.fernandez@keepcoding.io', '+34 642345678');


CREATE TABLE bootcamp (
    bootcamp_id SERIAL PRIMARY KEY
  , btc_name VARCHAR(150) NOT NULL,
  UNIQUE(btc_name)
);


INSERT INTO bootcamp (btc_name) VALUES
    ('Big Data, IA & ML')
  , ('Ciberseguridad')
  , ('Desarrollo Web')
  , ('Inteligencia Artificial')
  , ('Desarrollo de Apps Móviles iOS & Android');


CREATE TABLE subject (
    subject_id SERIAL PRIMARY KEY
  , sbj_name VARCHAR(150) NOT NULL,
  UNIQUE(sbj_name)
);


INSERT INTO subject (sbj_name) VALUES 
    ('P101')
  , ('Big Data Tour')
  , ('Criptografía')
  , ('Desarrollo Frontend con JavaScript')
  , ('Matemáticas 101');


CREATE TABLE tuition (
    tuition_id SERIAL PRIMARY KEY
  , student_id SERIAL NOT NULL
  , bootcamp_id SERIAL NOT NULL
  , enrollment_date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id)
);


INSERT INTO tuition (student_id, bootcamp_id, enrollment_date) VALUES
    (1, 1, '2023-09-15')
  , (1, 4, '2024-04-16')
  , (3, 2, '2023-09-18')
  , (4, 5, '2023-09-18')
  , (5, 2, '2023-09-19')
  , (5, 3, '2023-09-19');


CREATE TABLE employment_contract (
    contract_id SERIAL PRIMARY KEY
  , subject_id SERIAL NOT NULL
  , teacher_id SERIAL NOT NULL
  , sign_date DATE NOT NULL
  , end_date DATE
  , salary NUMERIC NOT NULL,
  FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
  FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);


INSERT INTO employment_contract (subject_id, teacher_id, sign_date, end_date, salary) VALUES 
    (1, 1, '2022-01-15', '2027-01-14', 45000)
  , (3, 1, '2022-03-20', '2025-03-19', 50000)
  , (2, 2, '2022-06-10', NULL, 48000)
  , (5, 3, '2022-08-05', '2027-08-04', 47000)
  , (4, 4, '2022-11-25', NULL, 49000);


CREATE TABLE subject_bootcamp (
    sbj_btc_id SERIAL PRIMARY KEY
  , bootcamp_id SERIAL NOT NULL
  , subject_id SERIAL NOT NULL,
  FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id),
  FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);


INSERT INTO subject_bootcamp(bootcamp_id, subject_id) VALUES
    (1, 1)
  , (1, 2)
  , (1, 5)
  , (2, 3)
  , (3, 4)
  , (3, 1)
  , (4, 1)
  , (4, 5)
  , (5, 1)
  , (5, 4);



  SELECT
    student.*
  , bootcamp.btc_name
  , tuition.enrollment_date
  , sbj_name
  , teacher.tch_name
  , teacher.tch_surname
  , teacher.tch_email
  , teacher.tch_phone
  , employment_contract.sign_date AS tch_sign_date
  , employment_contract.end_date AS tch_end_date
  , employment_contract.salary AS tch_salary
FROM student
LEFT JOIN tuition
ON student.student_id=tuition.student_id
INNER JOIN bootcamp
ON tuition.bootcamp_id=bootcamp.bootcamp_id
INNER JOIN subject_bootcamp
ON bootcamp.bootcamp_id=subject_bootcamp.bootcamp_id
INNER JOIN subject
ON subject_bootcamp.subject_id=subject.subject_id
INNER JOIN employment_contract
ON subject.subject_id=employment_contract.subject_id
INNER JOIN teacher
ON employment_contract.teacher_id=teacher.teacher_id
ORDER BY student.student_id, bootcamp.btc_name;