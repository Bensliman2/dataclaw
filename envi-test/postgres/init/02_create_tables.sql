-- Raw schema tables — source data lands here

CREATE TABLE raw.products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE raw.customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    country VARCHAR(50) NOT NULL
);

CREATE TABLE raw.orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES raw.customers(id),
    product_id INT NOT NULL REFERENCES raw.products(id),
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    ordered_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE raw.pipeline_logs (
    id SERIAL PRIMARY KEY,
    dag_id VARCHAR(100) NOT NULL,
    run_id VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'running',
    started_at TIMESTAMP NOT NULL,
    finished_at TIMESTAMP,
    rows_processed INT DEFAULT 0
);
