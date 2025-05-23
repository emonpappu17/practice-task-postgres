CREATE Table students (
    id SERIAL PRIMARY KEY,
    roll INT UNIQUE,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    score INT,
    status TEXT check (
        status in ('passed', 'failed')
    ),
    last_login DATE
);

DROP Table students;

SELECT * FROM students;

INSERT INTO
    students (
        roll,
        name,
        age,
        department,
        score,
        status,
        last_login
    )
VALUES (
        101,
        'Alice Johnson',
        20,
        'CSE',
        85,
        'passed',
        '2022-05-15'
    ),
    (
        102,
        'Bob Smith',
        22,
        'EEE',
        NULL,
        'passed',
        '2025-05-10'
    ),
    (
        103,
        'Carol Williams',
        21,
        'CSE',
        76,
        'passed',
        '2025-05-18'
    ),
    (
        104,
        'David Brown',
        23,
        'ME',
        59,
        'failed',
        '2025-05-08'
    ),
    (
        105,
        'Emma Davis',
        20,
        'CSE',
        91,
        'passed',
        '2025-05-20'
    ),
    (
        106,
        'Frank Miller',
        22,
        'EEE',
        49,
        'passed',
        '2025-05-13'
    ),
    (
        107,
        'Grace Lee',
        21,
        'BBA',
        73,
        'passed',
        '2025-05-12'
    ),
    (
        108,
        'Henry Wilson',
        24,
        'EEE',
        64,
        'passed',
        '2025-05-11'
    ),
    (
        109,
        'Isabella Moore',
        22,
        'CSE',
        34,
        'passed',
        '2025-05-09'
    ),
    (
        110,
        'Jack Taylor',
        20,
        'ME',
        88,
        'passed',
        '2025-05-19'
    );
-- 1. Add a column email (VARCHAR) to the existing students table.
ALTER Table students ADD email VARCHAR(50);
-- 2. Rename the column email to student_email.
ALTER Table students RENAME COLUMN email to student_email;
-- 3. Add a UNIQUE constraint to student_email.
ALTER Table students
ADD constraint unique_student_email UNIQUE (student_email);

ALTER TABLE students ADD UNIQUE (student_email);
-- 4. Add a PRIMARY KEY to a new table named courses.
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    credit_hours INT
);

SELECT * FROM courses;
-- 5. Drop a column from any existing table.
ALTER Table students DROP COLUMN last_login;
-- 6. Write a query to find all students who have a score greater than 80 and not null.
SELECT * FROM students WHERE score > 80 AND score is NOT NULL;
-- 7. Use the NOT operator to exclude students from a specific department.
SELECT * FROM students WHERE department <> 'CSE';
-- 8. Fetch students whose names start with ‘A’ using LIKE and ILIKE.
SELECT * FROM students WHERE name LIKE 'A%';

SELECT * FROM students WHERE name ILIKE 'a%';
-- 9. Select all students whose age is between 18 and 25.
SELECT * FROM students WHERE age BETWEEN 22 and 24;
-- 10. Retrieve rows using IN for a specific set of roll numbers.
SELECT * FROM students WHERE roll in (102, 106, 108);
-- 11. Count how many students exist in the students table.
SELECT count(id) as total_students FROM students;
-- 12. Find the average score of students in a specific department.
SELECT avg(score) as department_avg_score
FROM students
WHERE
    department = 'EEE';
-- 13. Get the maximum and minimum age of all students.
SELECT max(age), min(age) FROM students;
-- 14. Update the status of students who scored less than 50 to 'failed'.
UPDATE students SET status = 'failed' WHERE score < 50;
-- 15. Delete students who have not logged in since last year.
DELETE FROM students
WHERE
    last_login < CURRENT_DATE - INTERVAL '1 year';
-- 16. Use LIMIT and OFFSET to fetch the second page of results (5 per page).
SELECT * FROM students LIMIT 3 OFFSET 3 * 2;