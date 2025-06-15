-- ======================================
-- 🔁 TRIGGER: Automatic Data Synchronization
-- ======================================

-- Logic:
-- 1. Use $$ as a temporary delimiter
-- 2. Create a trigger named 'employee_insert' that activates AFTER inserting into employee_salary
-- 3. For each new row, automatically insert into employee_demographics
DELIMITER $$
CREATE TRIGGER employee_insert
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

-- Example insert to trigger the action
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Michael', 'Vincent', 'Entrepreneur', 1000000, 6);

-- Check trigger results
SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

-- ==========================
-- ⏰ EVENT: Remove Senior Employees by Age
-- ==========================

-- Logic:
-- 1. Create an event named 'delete_old' that runs every 30 seconds
-- 2. Automatically deletes records from employee_demographics where age ≥ 60
DELIMITER $$
CREATE EVENT delete_old
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

-- Check result after event executes
SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;

-- =================================================
-- 🔄 TRIGGER: Reverse Deletion Synchronization
-- =================================================

-- Logic:
-- When a record in employee_demographics is deleted,
-- the corresponding record in employee_salary is also deleted
DELIMITER $$
CREATE TRIGGER delete_salary_when_demo_deleted
AFTER DELETE ON employee_demographics
FOR EACH ROW
BEGIN
    DELETE FROM employee_salary
    WHERE employee_id = OLD.employee_id;
END $$
DELIMITER ;

-- Check result of automatic deletion
SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;
