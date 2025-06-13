SELECT 
    CONCAT_WS(' ', first_name, last_name) AS full_name, 
    salary, 
    dept_id,

    -- Penjelasan Departemen
    CASE
        WHEN dept_id = 6 THEN 'Finance Department'
        ELSE 'Other'
    END AS department,

    -- Kenaikan Gaji Berdasarkan Salary
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        ELSE salary * 1.07
    END AS new_salary,

    -- Bonus Jika di Finance
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS bonus,

    -- Total Akhir = Gaji Baru + Bonus (bukan double-counting)
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        ELSE salary * 1.07
    END + 
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS final_salary

FROM parks_and_recreation.employee_salary;
