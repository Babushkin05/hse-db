-- =============================================================================
-- ПЕРВЫЙ ЗАПРОС: Анализ периодов активности сотрудников
-- =============================================================================

DROP TABLE IF EXISTS EmployeeAttendance;

CREATE TABLE EmployeeAttendance (
    emp_id INT,
    attendance_date DATE,
    attendance_status VARCHAR(10),
    PRIMARY KEY (emp_id, attendance_date)
);

INSERT INTO EmployeeAttendance VALUES
(1, '2023-10-01', 'active'),
(1, '2023-10-02', 'active'),
(1, '2023-10-03', 'active'),
(1, '2023-10-06', 'active'),
(1, '2023-10-07', 'active'),
(2, '2023-10-01', 'active');

-- Поиск непрерывных периодов активности сотрудников
WITH ActivePeriods AS (
  SELECT 
    emp_id, 
    attendance_date,
    LAG(attendance_date) OVER (PARTITION BY emp_id ORDER BY attendance_date) AS prev_attendance_date
  FROM EmployeeAttendance
  WHERE attendance_status = 'active'
),
PeriodMarkers AS (
  SELECT
    emp_id,
    attendance_date,
    CASE
      WHEN prev_attendance_date IS NULL 
        OR attendance_date <> prev_attendance_date + INTERVAL '1 day' THEN 1
      ELSE 0
    END AS period_start_flag
  FROM ActivePeriods
),
PeriodGroups AS (
  SELECT
    emp_id,
    attendance_date,
    SUM(period_start_flag) OVER (PARTITION BY emp_id ORDER BY attendance_date) AS period_group
  FROM PeriodMarkers
)
SELECT
  emp_id,
  MIN(attendance_date) AS period_start_date,
  MAX(attendance_date) AS period_end_date,
  (MAX(attendance_date) - MIN(attendance_date)) + 1 AS consecutive_days
FROM PeriodGroups
GROUP BY emp_id, period_group
ORDER BY emp_id, period_start_date;

-- =============================================================================
-- ВТОРОЙ ЗАПРОС: Анализ подписок клиентов
-- =============================================================================

DROP TABLE IF EXISTS CustomerSubscriptions;

CREATE TABLE CustomerSubscriptions (
    sub_id SERIAL PRIMARY KEY,
    cust_id INT,
    sub_start_date DATE,
    sub_end_date DATE,
    price_per_month NUMERIC
);

INSERT INTO CustomerSubscriptions (cust_id, sub_start_date, sub_end_date) VALUES
(1, '2023-08-15', '2023-09-14'),
(2, '2023-08-20', '2023-09-19'),
(2, '2023-09-20', '2023-10-19'),
(3, '2023-09-01', '2023-09-30'),
(4, '2023-09-05', '2023-10-04');

-- Поиск клиентов с активными подписками в сентябре 2023
WITH SubscriptionSequence AS (
  SELECT
    cust_id,
    sub_start_date,
    sub_end_date,
    LEAD(sub_start_date) OVER (PARTITION BY cust_id ORDER BY sub_start_date) AS next_sub_start
  FROM CustomerSubscriptions
),
SeptemberSubscriptions AS (
  SELECT 
    cust_id, 
    sub_start_date, 
    sub_end_date, 
    next_sub_start
  FROM SubscriptionSequence
  WHERE sub_end_date BETWEEN DATE '2023-09-01' AND DATE '2023-09-30'
)
SELECT DISTINCT cust_id
FROM SeptemberSubscriptions
WHERE next_sub_start IS NULL
   OR next_sub_start > sub_end_date + INTERVAL '1 day'
ORDER BY cust_id;