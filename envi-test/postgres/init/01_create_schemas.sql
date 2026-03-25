-- Create the three-layer data warehouse schemas
-- raw: source of truth, append-only
-- staging: cleaned data (dbt views)
-- mart: business-ready aggregates (dbt tables)

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS mart;

-- Create a separate database for Airflow metadata
-- (keeps Airflow tables out of the data warehouse)
CREATE DATABASE airflow_meta;
