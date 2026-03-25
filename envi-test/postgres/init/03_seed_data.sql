-- Seed realistic test data

-- ── Products (20) ──────────────────────────────────
INSERT INTO raw.products (name, category, price, stock_quantity, is_active) VALUES
('MacBook Pro 14"',       'electronics', 1999.99, 45,  TRUE),
('iPhone 15 Pro',         'electronics', 1199.00, 120, TRUE),
('Sony WH-1000XM5',      'electronics', 349.99,  80,  TRUE),
('Samsung Galaxy Tab S9', 'electronics', 849.00,  60,  TRUE),
('Logitech MX Master 3S', 'electronics', 99.99,  200, TRUE),
('Dell UltraSharp 27"',  'electronics', 619.99,  35,  TRUE),
('Vintage Denim Jacket',  'clothing',   89.50,   150, TRUE),
('Nike Air Max 90',       'clothing',   129.99,  300, TRUE),
('Levi''s 501 Jeans',     'clothing',   69.99,   250, TRUE),
('Patagonia Down Sweater','clothing',   229.00,  75,  TRUE),
('Uniqlo Merino Sweater', 'clothing',   49.90,   400, TRUE),
('Ray-Ban Aviator',       'clothing',   154.00,  180, FALSE),
('Organic Coffee Beans',  'food',       18.99,   500, TRUE),
('Matcha Powder 100g',    'food',       24.50,   350, TRUE),
('Extra Virgin Olive Oil','food',       12.99,   600, TRUE),
('Dark Chocolate 85%',    'food',       5.49,    800, TRUE),
('Manuka Honey 250g',     'food',       42.00,   120, TRUE),
('Protein Bar Box (12)',  'food',       29.99,   450, TRUE),
('Sparkling Water 24-pk', 'food',       9.99,    700, TRUE),
('Dried Mango Slices',    'food',       7.99,    550, TRUE);

-- ── Customers (50) ─────────────────────────────────
INSERT INTO raw.customers (first_name, last_name, email, created_at, country) VALUES
('Jean',      'Dupont',      'jean.dupont@email.fr',        '2024-01-15 10:30:00', 'France'),
('Marie',     'Laurent',     'marie.laurent@gmail.com',     '2024-01-20 14:00:00', 'France'),
('Pierre',    'Martin',      'p.martin@outlook.fr',         '2024-02-03 09:15:00', 'France'),
('Sophie',    'Bernard',     'sophie.bernard@yahoo.fr',     '2024-02-10 11:45:00', 'France'),
('Lucas',     'Moreau',      'lucas.moreau@email.fr',       '2024-02-18 16:20:00', 'France'),
('Camille',   'Petit',       'camille.petit@gmail.com',     '2024-03-01 08:00:00', 'France'),
('Antoine',   'Roux',        'a.roux@protonmail.com',       '2024-03-05 13:30:00', 'France'),
('Lea',       'Fournier',    'lea.fournier@email.fr',       '2024-03-12 10:00:00', 'France'),
('Hugo',      'Girard',      'hugo.girard@gmail.com',       '2024-03-20 15:45:00', 'France'),
('Chloe',     'Bonnet',      'chloe.bonnet@outlook.fr',     '2024-04-01 09:30:00', 'France'),
('James',     'Smith',       'james.smith@gmail.com',       '2024-01-22 12:00:00', 'United Kingdom'),
('Emma',      'Johnson',     'emma.johnson@outlook.com',    '2024-02-05 14:30:00', 'United Kingdom'),
('Oliver',    'Williams',    'o.williams@yahoo.co.uk',      '2024-02-15 10:15:00', 'United Kingdom'),
('Charlotte', 'Brown',       'charlotte.brown@gmail.com',   '2024-03-08 16:00:00', 'United Kingdom'),
('William',   'Jones',       'w.jones@email.co.uk',         '2024-03-25 11:30:00', 'United Kingdom'),
('Sarah',     'Miller',      'sarah.miller@gmail.com',      '2024-01-10 08:45:00', 'United States'),
('Michael',   'Davis',       'michael.davis@outlook.com',   '2024-01-28 13:15:00', 'United States'),
('Emily',     'Garcia',      'emily.garcia@yahoo.com',      '2024-02-12 09:00:00', 'United States'),
('Daniel',    'Rodriguez',   'daniel.rodriguez@gmail.com',  '2024-02-28 15:30:00', 'United States'),
('Olivia',    'Martinez',    'olivia.martinez@email.com',   '2024-03-15 10:45:00', 'United States'),
('Thomas',    'Anderson',    'thomas.anderson@gmail.com',   '2024-03-22 14:00:00', 'United States'),
('Jessica',   'Taylor',      'jessica.taylor@outlook.com',  '2024-04-02 08:30:00', 'United States'),
('David',     'Thomas',      'david.thomas@gmail.com',      '2024-04-10 12:15:00', 'United States'),
('Laura',     'Hernandez',   'laura.hernandez@yahoo.com',   '2024-04-18 16:45:00', 'United States'),
('Robert',    'Moore',       'robert.moore@email.com',      '2024-04-25 09:00:00', 'United States'),
('Hans',      'Mueller',     'hans.mueller@web.de',         '2024-01-30 10:00:00', 'Germany'),
('Anna',      'Schmidt',     'anna.schmidt@gmx.de',         '2024-02-20 14:30:00', 'Germany'),
('Felix',     'Schneider',   'felix.schneider@gmail.com',   '2024-03-10 11:00:00', 'Germany'),
('Lena',      'Fischer',     'lena.fischer@outlook.de',     '2024-03-28 15:15:00', 'Germany'),
('Max',       'Weber',       'max.weber@web.de',            '2024-04-15 08:45:00', 'Germany'),
('Yuki',      'Tanaka',      'yuki.tanaka@gmail.com',       '2024-02-01 07:00:00', 'Japan'),
('Haruto',    'Suzuki',      'haruto.suzuki@yahoo.co.jp',   '2024-02-25 13:30:00', 'Japan'),
('Sakura',    'Watanabe',    'sakura.watanabe@gmail.com',   '2024-03-18 09:45:00', 'Japan'),
('Carlos',    'Gonzalez',    'carlos.gonzalez@gmail.com',   '2024-01-25 11:00:00', 'Spain'),
('Maria',     'Fernandez',   'maria.fernandez@outlook.es',  '2024-03-05 14:15:00', 'Spain'),
('Alessandro','Rossi',       'alessandro.rossi@gmail.com',  '2024-02-08 10:30:00', 'Italy'),
('Giulia',    'Bianchi',     'giulia.bianchi@libero.it',    '2024-03-14 16:00:00', 'Italy'),
('Marco',     'Colombo',     'marco.colombo@gmail.com',     '2024-04-05 08:15:00', 'Italy'),
('Lars',      'Johansson',   'lars.johansson@gmail.com',    '2024-02-14 12:00:00', 'Sweden'),
('Astrid',    'Lindgren',    'astrid.lindgren@outlook.se',  '2024-03-30 09:30:00', 'Sweden'),
('Mohammed',  'Al-Rashid',   'mohammed.alrashid@gmail.com', '2024-01-18 15:00:00', 'UAE'),
('Fatima',    'Hassan',      'fatima.hassan@outlook.com',   '2024-03-02 10:45:00', 'UAE'),
('Raj',       'Patel',       'raj.patel@gmail.com',         '2024-02-22 13:00:00', 'India'),
('Priya',     'Sharma',      'priya.sharma@yahoo.in',       '2024-03-16 08:30:00', 'India'),
('Wei',       'Chen',        'wei.chen@qq.com',             '2024-01-12 11:15:00', 'China'),
('Min',       'Li',          'min.li@gmail.com',            '2024-02-28 14:45:00', 'China'),
('Ji-hoon',   'Kim',         'jihoon.kim@naver.com',        '2024-03-08 07:30:00', 'South Korea'),
('Soo-yeon',  'Park',        'sooyeon.park@gmail.com',      '2024-04-01 10:00:00', 'South Korea'),
('Ana',       'Silva',       'ana.silva@gmail.com',         '2024-02-16 15:30:00', 'Brazil'),
('Pedro',     'Santos',      'pedro.santos@outlook.com',    '2024-03-24 09:00:00', 'Brazil');

-- ── Orders (200) ───────────────────────────────────
-- Status distribution: ~60% delivered, ~20% shipped, ~10% pending, ~10% cancelled
-- Spread across Sep 2024 – Feb 2025

INSERT INTO raw.orders (customer_id, product_id, quantity, total_amount, status, ordered_at)
SELECT
    -- Random customer (1-50)
    1 + (random() * 49)::int AS customer_id,
    -- Random product (1-20)
    1 + (random() * 19)::int AS product_id,
    -- Quantity 1-5
    1 + (random() * 4)::int AS quantity,
    -- Total amount: random between 5 and 2500
    round((5 + random() * 2495)::numeric, 2) AS total_amount,
    -- Status distribution
    CASE
        WHEN random() < 0.60 THEN 'delivered'
        WHEN random() < 0.75 THEN 'shipped'
        WHEN random() < 0.85 THEN 'pending'
        ELSE 'cancelled'
    END AS status,
    -- Spread across 6 months (Sep 2024 - Feb 2025)
    '2024-09-01'::timestamp + (random() * 180)::int * interval '1 day'
        + (random() * 86400)::int * interval '1 second' AS ordered_at
FROM generate_series(1, 200);

-- ── Pipeline Logs (10) ─────────────────────────────
INSERT INTO raw.pipeline_logs (dag_id, run_id, status, started_at, finished_at, rows_processed) VALUES
('raw_data_ingestion', 'run_20250101_001', 'success', '2025-01-01 02:00:00', '2025-01-01 02:05:30', 150),
('dbt_transform',      'run_20250101_002', 'success', '2025-01-01 02:10:00', '2025-01-01 02:12:45', 150),
('raw_data_ingestion', 'run_20250102_001', 'success', '2025-01-02 02:00:00', '2025-01-02 02:04:15', 142),
('dbt_transform',      'run_20250102_002', 'failed',  '2025-01-02 02:10:00', '2025-01-02 02:10:30', 0),
('raw_data_ingestion', 'run_20250103_001', 'success', '2025-01-03 02:00:00', '2025-01-03 02:06:00', 165),
('dbt_transform',      'run_20250103_002', 'success', '2025-01-03 02:10:00', '2025-01-03 02:13:10', 165),
('raw_data_ingestion', 'run_20250104_001', 'success', '2025-01-04 02:00:00', '2025-01-04 02:05:45', 138),
('dbt_transform',      'run_20250104_002', 'success', '2025-01-04 02:10:00', '2025-01-04 02:12:30', 138),
('raw_data_ingestion', 'run_20250105_001', 'running', '2025-01-05 02:00:00', NULL,                   0),
('dbt_transform',      'run_20250105_002', 'failed',  '2025-01-05 02:10:00', '2025-01-05 02:10:05', 0);
