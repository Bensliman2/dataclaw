# Test Environment for DataClaw

A ready-to-use Docker environment with real databases, APIs, and services to test DataClaw against.

## What's Included

| Service              | Port  | Credentials                    | Purpose                        |
|----------------------|-------|--------------------------------|--------------------------------|
| PostgreSQL (main)    | 5432  | dataclaw / dataclaw123         | Main database with sample data |
| PostgreSQL (analytics)| 5433 | analytics / analytics123       | Second DB for multi-DB testing |
| pgAdmin              | 5050  | admin@dataclaw.dev / admin     | Database web UI                |
| Airflow Webserver    | 8080  | airflow / airflow              | Pipeline orchestration         |
| Kafka (KRaft)        | 9092  | —                              | Message streaming              |
| SSH Server           | 2222  | dataclaw / dataclaw123         | Remote server access           |

## Quick Start

### 1. Start all services

```bash
cd envi-test

# Create .env file with database credentials
cat > .env << 'EOF'
POSTGRES_USER=dataclaw
POSTGRES_PASSWORD=dataclaw123
POSTGRES_DB=dataclaw_test
EOF

# Start everything
docker compose up -d
```

Wait ~30 seconds, then verify:

```bash
docker compose ps          # all services should be healthy
docker compose logs dbt    # should show seed + run completed
```

### 2. Configure DataClaw connections

After running `dataclaw init`, edit `~/.dataclaw/connections.yaml`:

```yaml
technologies:

  # Main PostgreSQL
  main_db:
    type: database
    driver: psycopg2
    access_level: read
    connection:
      host: localhost
      port: 5432
      database: dataclaw_test
      user: ${POSTGRES_USER}
      password: ${POSTGRES_PASSWORD}

  # Analytics PostgreSQL
  analytics_db:
    type: database
    driver: psycopg2
    access_level: write
    connection:
      host: localhost
      port: 5433
      database: analytics_db
      user: ${ANALYTICS_USER}
      password: ${ANALYTICS_PASSWORD}

  # Airflow REST API
  airflow:
    type: api
    driver: requests
    access_level: read
    connection:
      base_url: http://localhost:8080/api/v1
      auth_type: basic
      username: airflow
      password: airflow

  # Kafka
  my_kafka:
    type: messaging
    driver: kafka-python
    access_level: read
    connection:
      bootstrap_servers: localhost:9092

  # SSH Server
  my_server:
    type: server
    driver: paramiko
    access_level: read
    connection:
      host: localhost
      port: 2222
      user: dataclaw
      password: dataclaw123
```

Add secrets to `~/.dataclaw/.env`:

```
POSTGRES_USER=dataclaw
POSTGRES_PASSWORD=dataclaw123
ANALYTICS_USER=analytics
ANALYTICS_PASSWORD=analytics123
```

### 3. Test with DataClaw

```bash
dataclaw
```

Try these prompts:

```
> list all schemas in main_db
> show me the top 10 customers by total spending
> how many orders were placed last month?
> list kafka topics
> show files on the SSH server
> list airflow DAGs
```

## Database Schema

### Main DB (port 5432) — `dataclaw_test`

**Raw tables** (source data):

| Table               | Rows | Description                          |
|---------------------|------|--------------------------------------|
| `raw.customers`     | 50   | Customer profiles (10 countries)     |
| `raw.products`      | 20   | Products (electronics/clothing/food) |
| `raw.orders`        | 200  | Orders (Sep 2024 – Feb 2025)         |
| `raw.pipeline_logs` | 10   | Pipeline execution history           |

**Staging views** (dbt-transformed):

| View                    | Description                              |
|-------------------------|------------------------------------------|
| `staging.stg_customers` | Cleaned names, lowercase emails          |
| `staging.stg_products`  | Active products only, price ranges       |
| `staging.stg_orders`    | Orders joined with product info          |

**Mart tables** (business-ready):

| Table                  | Description                               |
|------------------------|-------------------------------------------|
| `mart.dim_customers`   | Customer dimension with spend totals      |
| `mart.dim_products`    | Product dimension with sales stats        |
| `mart.fct_orders`      | Fact table with denormalized order data   |

### Analytics DB (port 5433) — `analytics_db`

A second PostgreSQL instance for testing multi-database scenarios (e.g., "list tables" triggers DataClaw to ask which database you mean).

## Airflow DAGs

| DAG                  | Schedule | Description                          |
|----------------------|----------|--------------------------------------|
| `raw_data_ingestion` | @daily   | Inserts random orders into raw       |
| `dbt_transform`      | @daily   | Runs dbt seed, run, test             |

## Reset Everything

```bash
docker compose down -v    # stop and delete all data
docker compose up -d      # rebuild from scratch
```

## Check Data Manually

```bash
# Connect via psql
docker exec -it envi-test-postgres-1 psql -U dataclaw -d dataclaw_test

# Or use pgAdmin at http://localhost:5050
# Add server: host=postgres, port=5432
```
