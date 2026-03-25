"""DAG: Raw data ingestion — simulates inserting random orders daily."""

from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python import PythonOperator

default_args = {
    "owner": "dataclaw",
    "depends_on_past": False,
    "email_on_failure": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}


def insert_random_orders(**context):
    """Insert a few random orders into raw.orders."""
    import os
    import random

    import psycopg2

    conn = psycopg2.connect(
        host=os.environ.get("POSTGRES_HOST", "postgres"),
        port=int(os.environ.get("POSTGRES_PORT", 5432)),
        database=os.environ.get("POSTGRES_DB", "dataclaw_test"),
        user=os.environ.get("POSTGRES_USER", "dataclaw"),
        password=os.environ.get("POSTGRES_PASSWORD", "dataclaw123"),
    )
    try:
        with conn.cursor() as cur:
            statuses = ["pending", "shipped", "delivered", "cancelled"]
            weights = [0.10, 0.20, 0.60, 0.10]
            num_orders = random.randint(3, 8)

            for _ in range(num_orders):
                customer_id = random.randint(1, 50)
                product_id = random.randint(1, 20)
                quantity = random.randint(1, 5)
                total_amount = round(random.uniform(5, 2500), 2)
                status = random.choices(statuses, weights=weights, k=1)[0]

                cur.execute(
                    """
                    INSERT INTO raw.orders
                        (customer_id, product_id, quantity, total_amount, status, ordered_at)
                    VALUES (%s, %s, %s, %s, %s, NOW())
                    """,
                    (customer_id, product_id, quantity, total_amount, status),
                )

            conn.commit()
            print(f"Inserted {num_orders} random orders")
    finally:
        conn.close()


with DAG(
    dag_id="raw_data_ingestion",
    default_args=default_args,
    description="Simulates daily raw data ingestion by inserting random orders",
    schedule="@daily",
    start_date=datetime(2025, 1, 1),
    catchup=False,
    tags=["dataclaw", "raw"],
) as dag:

    ingest_task = PythonOperator(
        task_id="insert_random_orders",
        python_callable=insert_random_orders,
    )
