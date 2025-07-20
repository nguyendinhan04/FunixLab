from airflow import DAG
from datetime import datetime
from airflow.operators.bash import BashOperator

with DAG("Lab12",start_date = datetime(2025,2,9),schedule_interval = '@daily',catchup=False) as dag:
    task1 = BashOperator(
        task_id = 'task1',
        bash_command='sleep 3'
    )


    task2 = BashOperator(
        task_id = 'task2',
        bash_command='sleep 3'
    )

    task3 = BashOperator(
        task_id = 'task3',
        bash_command='sleep 3'
    )

    task4 = BashOperator(
        task_id = 'task4',
        bash_command='sleep 3'
    )

    task5 = BashOperator(
        task_id = 'task5',
        bash_command='sleep 3'
    )

    task6 = BashOperator(
        task_id = 'task6',
        bash_command='sleep 3'
    )


    task1 >> task5
    task1 >> task6
    task2 >> task5
    task2 >> task6
    task3 >> task5
    task3 >> task6
    task4 >> task5
    task4 >> task6
