"""DAG: dbt transform — runs dbt seed, run, and test after raw ingestion."""

from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    "owner": "dataclaw",
    "depends_on_past": False,
    "email_on_failure": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

DBT_DIR = "/opt/airflow/dbt"

with DAG(
    dag_id="dbt_transform",
    default_args=default_args,
    description="Runs dbt seed, run, and test on the dataclaw warehouse",
    schedule="@daily",
    start_date=datetime(2025, 1, 1),
    catchup=False,
    tags=["dataclaw", "dbt"],
) as dag:

    dbt_seed = BashOperator(
        task_id="dbt_seed",
        bash_command=f"cd {DBT_DIR} && dbt seed --profiles-dir .",
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=f"cd {DBT_DIR} && dbt run --profiles-dir .",
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command=f"cd {DBT_DIR} && dbt test --profiles-dir . || true",
    )

    dbt_seed >> dbt_run >> dbt_test
