-- Нормализованная модель по отчёту hw-12-1.xlsx (Нетология, задание 1)
-- СУБД: PostgreSQL

-- 1. Типы подразделений (Отдел / Группа / Департамент)
CREATE TABLE department_types (
    department_type_id  SERIAL PRIMARY KEY,
    type_name           VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Структурные подразделения
CREATE TABLE departments (
    department_id       SERIAL PRIMARY KEY,
    department_name     VARCHAR(200) NOT NULL UNIQUE,
    department_type_id  INTEGER NOT NULL
        REFERENCES department_types (department_type_id)
);

-- 3. Должности
CREATE TABLE positions (
    position_id         SERIAL PRIMARY KEY,
    position_title      VARCHAR(150) NOT NULL UNIQUE
);

-- 4. Филиалы (адреса офисов)
CREATE TABLE branches (
    branch_id           SERIAL PRIMARY KEY,
    region              VARCHAR(100) NOT NULL,
    city                VARCHAR(100) NOT NULL,
    street_address      VARCHAR(200) NOT NULL,
    full_address        VARCHAR(300) NOT NULL UNIQUE
);

-- 5. Сотрудники
CREATE TABLE employees (
    employee_id         SERIAL PRIMARY KEY,
    last_name           VARCHAR(100) NOT NULL,
    first_name          VARCHAR(100) NOT NULL,
    middle_name         VARCHAR(100),
    salary              NUMERIC(12, 2) NOT NULL CHECK (salary >= 0),
    hire_date           DATE NOT NULL,
    position_id         INTEGER NOT NULL
        REFERENCES positions (position_id),
    department_id       INTEGER NOT NULL
        REFERENCES departments (department_id),
    branch_id           INTEGER NOT NULL
        REFERENCES branches (branch_id)
);

-- 6. Проекты
CREATE TABLE projects (
    project_id          SERIAL PRIMARY KEY,
    project_name        VARCHAR(200) NOT NULL UNIQUE
);

-- 7. Назначения сотрудников на проекты (связь многие-ко-многим)
CREATE TABLE employee_projects (
    employee_id         INTEGER NOT NULL
        REFERENCES employees (employee_id),
    project_id          INTEGER NOT NULL
        REFERENCES projects (project_id),
    PRIMARY KEY (employee_id, project_id)
);
