from airflow import DAG
from datetime import datetime
from airflow.operators.python import BranchPythonOperator
from airflow.operators.bash import BashOperator

tabDays = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

def _branching():
    return f"{tabDays[datetime.now().weekday()]}_task"


with DAG('lab13',start_date=datetime(2025,2,9),schedule= '@daily',catchup=False) as dag:
    branch = BranchPythonOperator(
        task_id = 'Branching',
        python_callable=_branching
    )

    monday_task = BashOperator(
        task_id = 'monday_task',
        bash_command='sleep 1'
    )

    tuesday_task = BashOperator(
        task_id = 'tuesday_task',
        bash_command='sleep 1'
    )

    wednesday_task = BashOperator(
        task_id = 'wednesday_task',
        bash_command='sleep 1'
    )

    thursday_task = BashOperator(
        task_id = 'thursday_task',
        bash_command='sleep 1'
    )

    friday_task = BashOperator(
        task_id = 'friday_task',
        bash_command='sleep 1'
    )

    saturday_task = BashOperator(
        task_id = 'saturday_task',
        bash_command='sleep 1'
    )

    sunday_task = BashOperator(
        task_id = 'sunday_task',
        bash_command='sleep 1'
    )


    branch >> [monday_task,tuesday_task,thursday_task,wednesday_task,friday_task,saturday_task,sunday_task]


