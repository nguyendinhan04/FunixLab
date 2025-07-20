from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime
from airflow.operators.python import BranchPythonOperator 

with DAG('user_processing2', start_date = datetime(2025,2,9), schedule_interval = '@daily', catchup = False) as dag:
    mysql_task = SQLExecuteQueryOperator(task_id = "create new table")