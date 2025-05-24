CREATE Table students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    department_id INT REFERENCES departments (id) on delete CASCADE,
    -- department_id INT REFERENCES departments (id) on delete set null,
    last_login date
)

CREATE Table departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
)

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50)
)

drop Table departments;

DROP Table students;

DROP TABLE courses;

INSERT INTO
    departments (name)
VALUES ('Computer Science'),
    ('Electrical Engineering'),
    ('Mechanical Engineering'),
    ('Civil Engineering'),
    ('Business Administration');

INSERT INTO
    students (
        name,
        department_id,
        last_login
    )
VALUES (
        'Alice Johnson',
        1,
        '2024-12-10'
    ),
    ('Bob Smith', 2, '2025-01-15'),
    (
        'Charlie Brown',
        1,
        '2025-03-01'
    ),
    (
        'Diana Prince',
        3,
        '2024-05-25'
    ),
    ('Ethan Hunt', 5, '2025-02-20'),
    (
        'Fiona Gallagher',
        4,
        '2025-02-20'
    ), -- student without department and login
    (
        'George Miller',
        4,
        '2025-05-01'
    );

INSERT INTO
    courses (title)
VALUES ('Database Systems'),
    ('Digital Logic Design'),
    ('Engineering Mechanics'),
    ('Project Management'),
    ('Marketing 101');

SELECT * FROM students;

SELECT * FROM departments;

SELECT * FROM courses;

-- 1. Retrieve students who have logged in within the last 30 days.
SELECT *
FROM students
WHERE
    last_login >= CURRENT_DATE - INTERVAL '30 days';

-- 2. Extract the login month from the last_login and group students by month.
SELECT to_char(last_login, 'Month') as login_month, count(*) as student_count
FROM students
WHERE
    last_login is NOT NULL
GROUP BY
    login_month;

-- 3. Count how many students logged in per month and show only those months where login count is more than 3.
SELECT to_char(last_login, 'Month') as login_month, count(*) as student_count
FROM students
WHERE
    last_login is not NULL
GROUP BY
    login_month
HAVING
    count(*) >= 2;

-- 4. Create a foreign key constraint on department_id in the students table referencing departments(id).
ALTER Table students
ADD constraint fk_department FOREIGN KEY (department_id) REFERENCES departments (id);

-- 5. Try inserting a student with a department_id that doesn’t exist and observe the behavior.
INSERT INTO
    students (
        name,
        department_id,
        last_login
    )
VALUES ('Ronaldo', 7, CURRENT_DATE);

-- 6. Delete a department and see how students are affected using ON DELETE CASCADE and ON DELETE SET NULL.
SELECT * FROM students;

SELECT * FROM departments;

DELETE FROM departments WHERE id = 1;

-- 7. Join students and departments using INNER JOIN to display each student's department name.
SELECT
    students.name as student_name,
    departments.name as department_name
FROM students
    JOIN departments on departments.id = students.department_id;

-- SELECT
--     students.name as student_name,
--     departments.name as department_name
-- FROM students
--     JOIN departments on USING (department_id);
-- job jay gay same name a hoite hoibo department_id taile aita kaj korbe

-- 8. Use a LEFT JOIN to show all students including those without a department.

INSERT INTO
    students (
        name,
        last_login,
        department_id
    )
VALUES ('Messi', CURRENT_DATE, NULL);

SELECT *
FROM students
    LEFT JOIN departments on departments.id = students.department_id;

SELECT
    students.id,
    students.name AS student_name,
    departments.name AS department_name
FROM students
    LEFT JOIN departments ON students.department_id = departments.id;

-- 9. Use a RIGHT JOIN to show all departments including those without students.
INSERT INTO
    departments (name)
VALUES ('Political Science'),
    ('Economics');

SELECT * FROM departments;

SELECT *
FROM students
    RIGHT JOIN departments on students.department_id = departments.id;

-- 10. Perform a FULL JOIN to get all records from both students and departments.
SELECT *
FROM students
    FULL JOIN departments on students.department_id = departments.id;

-- 11. Create a cross-product of all students and courses using CROSS JOIN.
SELECT * FROM courses;

SELECT * FROM students;

SELECT * FROM students CROSS JOIN courses;

-- 12. Use NATURAL JOIN between tables that have a shared column like department_id.
SELECT * FROM 