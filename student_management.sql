-- Create Database
CREATE DATABASE StudentManagement;
USE StudentManagement;

-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dob DATE,
    department VARCHAR(50)
);

-- Instructors Table
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Insert Students
INSERT INTO Students (name, email, dob, department) VALUES
('Alice Johnson', 'alice@example.com', '2002-05-10', 'Computer Science'),
('Bob Smith', 'bob@example.com', '2001-11-23', 'Mathematics'),
('Charlie Brown', 'charlie@example.com', '2003-02-17', 'Physics');

-- Insert Instructors
INSERT INTO Instructors (name, email, department) VALUES
('Dr. Miller', 'miller@univ.edu', 'Computer Science'),
('Dr. Davis', 'davis@univ.edu', 'Mathematics');

-- Insert Courses
INSERT INTO Courses (course_name, credits, instructor_id) VALUES
('Database Systems', 4, 1),
('Calculus II', 3, 2),
('Data Structures', 4, 1);

-- Insert Enrollments
INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 2, 'A'),
(3, 3, 'B'),
(2, 1, 'C');
-- 1. List all students
SELECT * FROM Students;

-- 2. Find all courses taught by Dr. Miller
SELECT c.course_name
FROM Courses c
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE i.name = 'Dr. Miller';

-- 3. Get all students enrolled in "Database Systems"
SELECT s.name, s.department
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- 4. Average grade per course
SELECT c.course_name, AVG(
    CASE grade
        WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        ELSE 0
    END
) AS avg_gpa
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

-- 5. Count students per department
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;

