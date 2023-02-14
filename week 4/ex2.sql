CREATE TABLE Specialization (
spec_name varchar(50) NOT NULL PRIMARY KEY
); 
CREATE TABLE Student (
student_id INTEGER NOT NULL PRIMARY KEY,
student_name varchar(50) NOT NULL,
native_language varchar(50)
);
CREATE TABLE Course (
course_name varchar(50) NOT NULL PRIMARY KEY,
credits INTEGER
);
CREATE TABLE StudentTakesSpecialization (
student_id INTEGER NOT NULL,
specialization_name varchar(50) NOT NULL,
FOREIGN KEY (student_id) REFERENCES Student(student_id),
FOREIGN KEY (specialization_name) REFERENCES Specialization(spec_name),
PRIMARY KEY (student_id, specialization_name)
); 
CREATE TABLE StudentEnrollsCourse (
student_id INTEGER NOT NULL,
course_name varchar(50) NOT NULL,
FOREIGN KEY (student_id) REFERENCES  Student(student_id),
FOREIGN KEY (course_name) REFERENCES Course(course_name),
PRIMARY KEY (student_id, course_name)
);
INSERT INTO Student(student_id,student_name,native_language) values
(1,"Maxim", "Russian"),
(2,"Vitaliy", "Russian"),
(3,"Abu", "Arabic"),
(4,"Mostafa", "Arabic"),
(5,"Bill", "English"),
(6,"Vlad", "Russian"),
(7,"Pierre", "French"),
(8,"Anna", "Russian"),
(9,"Patrick", "English"),
(10,"Bob", "English"),
(11, "Boris", "Russian");
INSERT INTO Specialization VALUES
('Robotics'),
('SD'),
('DS'),
('CS'),
('AAI');
INSERT INTO Course VALUES
('DB', 2),
('SNA', 5),
('ML', 3),
('NW', 3),
('DNP', 4);
INSERT INTO StudentTakesSpecialization(student_id, specialization_name) VALUES
(1, 'SD'),
(2, 'DS'),
(3, 'AAI'),
(4, 'Robotics'),
(5, 'CS'),
(6, 'CS'),
(7, 'DS'),
(8, 'Robotics'),
(9, 'SD'),
(10, 'SD'),
(11, 'SD');
INSERT INTO StudentEnrollsCourse(student_id, course_name) VALUES
(1, 'NW'),
(2, 'NW'),
(3, 'NW'),
(4, 'NW'),
(5, 'NW'),
(6, 'NW'),
(7, 'NW'),
(1, 'DB'),
(9, 'DB'),
(10, 'DNP'),
(11, 'ML'),
(3, 'DB');
-- a)
  select student_name from Student where native_language="Russian" and id<11;
-- b)
select student_name from Student where native_language!="Russian";
-- с)
select student_name from Student inner join (select student_id from StudentTakesSpecialization where specialization_name="Robotics") as robot on Student.id =robot.student_id;
-- d)
SELECT Student.student_name, course_name FROM Student INNER JOIN (SELECT StudentEnrollsCourse.course_name, student_id FROM StudentEnrollsCourse INNER JOIN (SELECT course_name FROM Course WHERE credits < 3) AS low_cred_names ON low_cred_names.course_name = StudentEnrollsCourse.course_name) AS id_students_of_low_cred ON id_students_of_low_cred.student_id = Student.student_id
-- e)
SELECT course_name FROM StudentEnrollsCourse INNER JOIN (SELECT student_id FROM Student WHERE native_language = 'English') AS english_id ON StudentEnrollsCourse.student_id = english_id.student_id;











