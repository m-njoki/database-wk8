-- Create the database
CREATE DATABASE college_db;
USE college_db;

-- Table: Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Professors
CREATE TABLE Professors (
    professor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table: Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table: Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    professor_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

-- Table: Enrollments (Many-to-Many between Students and Courses)
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    UNIQUE(student_id, course_id) -- Ensure each student can enroll in a course only once
);

-- Table: Grades (One-to-Many relationship with Enrollments)
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    grade ENUM('A', 'B', 'C', 'D', 'F') NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);

-- Sample Insert for Departments
INSERT INTO Departments (department_name) VALUES
('Computer Science'),
('Electrical Engineering'),
('Mechanical Engineering'),
('Biology'),
('Physics');

-- Sample Insert for Professors
INSERT INTO Professors (first_name, last_name, email, department_id) VALUES
('Alice', 'Johnson', 'alice.johnson@college.com', 1),
('Bob', 'Smith', 'bob.smith@college.com', 2),
('Charlie', 'Williams', 'charlie.williams@college.com', 3);

-- Sample Insert for Students
INSERT INTO Students (first_name, last_name, email, birth_date, gender, department_id) VALUES
('John', 'Doe', 'john.doe@student.com', '2000-01-01', 'Male', 1),
('Jane', 'Doe', 'jane.doe@student.com', '2001-02-02', 'Female', 2),
('Mike', 'Smith', 'mike.smith@student.com', '2002-03-03', 'Male', 3);

-- Sample Insert for Courses
INSERT INTO Courses (course_name, department_id, professor_id) VALUES
('Intro to Programming', 1, 1),
('Circuits 101', 2, 2),
('Mechanics of Materials', 3, 3);

-- Sample Insert for Enrollments (Many-to-Many relationship)
INSERT INTO Enrollments (student_id, course_id) VALUES
(1, 1),  -- John Doe enrolled in Intro to Programming
(2, 2),  -- Jane Doe enrolled in Circuits 101
(3, 3);  -- Mike Smith enrolled in Mechanics of Materials

-- Sample Insert for Grades
INSERT INTO Grades (enrollment_id, grade) VALUES
(1, 'A'),  -- John Doe in Intro to Programming
(2, 'B'),  -- Jane Doe in Circuits 101
(3, 'C');  -- Mike Smith in Mechanics of Materials
