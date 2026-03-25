-- Analytics database: contains aggregated metrics
-- NOTE: has an "orders" table with DIFFERENT schema than raw.orders in main DB.
-- This tests the agent's disambiguation when 2 DBs have same-name tables.

CREATE SCHEMA IF NOT EXISTS analytics;

-- Same name "orders" but different structure (aggregated, not transactional)
CREATE TABLE analytics.orders (
    order_date DATE NOT NULL,
    region VARCHAR(50) NOT NULL,
    total_orders INT NOT NULL,
    total_revenue DECIMAL(12, 2) NOT NULL,
    avg_order_value DECIMAL(10, 2) NOT NULL
);

CREATE TABLE analytics.customers (
    segment VARCHAR(50) NOT NULL,
    customer_count INT NOT NULL,
    avg_lifetime_value DECIMAL(10, 2) NOT NULL,
    churn_rate DECIMAL(5, 2) NOT NULL
);

CREATE TABLE analytics.daily_metrics (
    metric_date DATE NOT NULL,
    active_users INT NOT NULL,
    new_signups INT NOT NULL,
    page_views BIGINT NOT NULL,
    conversion_rate DECIMAL(5, 4) NOT NULL
);

-- Seed data
INSERT INTO analytics.orders (order_date, region, total_orders, total_revenue, avg_order_value) VALUES
    ('2025-01-15', 'North America', 1250, 87500.00, 70.00),
    ('2025-01-15', 'Europe', 830, 58100.00, 70.00),
    ('2025-01-15', 'Asia Pacific', 420, 25200.00, 60.00),
    ('2025-01-16', 'North America', 1180, 82600.00, 70.00),
    ('2025-01-16', 'Europe', 910, 63700.00, 70.00),
    ('2025-01-16', 'Asia Pacific', 390, 23400.00, 60.00);

INSERT INTO analytics.customers (segment, customer_count, avg_lifetime_value, churn_rate) VALUES
    ('Enterprise', 150, 12500.00, 2.50),
    ('SMB', 2300, 3200.00, 8.00),
    ('Consumer', 45000, 150.00, 15.00);

INSERT INTO analytics.daily_metrics (metric_date, active_users, new_signups, page_views, conversion_rate) VALUES
    ('2025-01-15', 8500, 320, 125000, 0.0380),
    ('2025-01-16', 9200, 410, 138000, 0.0420),
    ('2025-01-17', 8800, 280, 119000, 0.0350);
