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

DROP Table students