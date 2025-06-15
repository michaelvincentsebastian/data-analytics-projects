# 🔁 Automated Employee Management with SQL Triggers & Events

This mini project demonstrates how to automate HR data management using MySQL Triggers and Event Scheduler. It simulates real-world scenarios where inserting or deleting employee data should automatically update related tables — without requiring manual effort.

## 📘 Project Overview

This project showcases how SQL can be used to build logic-based automation within a database system for HR workflows. The key operations covered include:

- Auto-inserting employee demographics data upon salary record creation

- Automatically removing employee data when they retire (age ≥ 60)

- Synchronizing deletions between tables (bidirectional deletion)

- Using scheduled events to simulate periodic cleanup

These mechanisms emulate the backend logic of an HR system, ensuring data consistency and minimal human error.

## 🧰 Tech Stack

- SQL (MySQL 8+)

- Triggers: AFTER INSERT, AFTER DELETE

- Event Scheduler: ON SCHEDULE EVERY ...

- SQL Commands: INSERT, DELETE, SELECT

## ⚙️ Features Implemented

1. AFTER INSERT Trigger
Automatically inserts a record into the employee_demographics table when a new employee is added to the employee_salary table.

2. Scheduled Event
Deletes employees aged 60 or above every 30 seconds from employee_demographics.

3. AFTER DELETE Trigger
When an employee is deleted from employee_demographics, their record is also deleted from employee_salary to maintain referential consistency.

## 🏢 Real-World Applications

- Automating HR processes like onboarding and retirement

- Data syncing between different employee tables

- Scheduled cleanup jobs (e.g., archiving, removing inactive employees)

- Creating clean, event-driven database architectures