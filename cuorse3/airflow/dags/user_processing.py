from airflow import DAG
from datetime import datetime
from airflow.operators.bash import BashOperator
from airflow.operators.subdag import SubDagOperator
from sub_dags.sub_dags import load_subdag
from airflow.operators.python import BranchPythonOperator


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'start_date': datetime(2024, 1, 1),
}

def _branch():
    return 'task5'

with DAG('test_subdag',start_date = datetime(2025,2,9), schedule_interval = '@daily', catchup = False):
    start = BashOperator(
        task_id = "start",
        bash_command='sleep 3'
    )

    load_sub_dag = SubDagOperator(
        task_id = "load_dags",
        subdag=load_subdag(
            parent_dag_id = 'test_subdag',
            child_dag_id = 'load_dags',
            args=default_args
        )
    )

    branch = BranchPythonOperator(
        task_id = 'Branch',
        python_callable= _branch
    )


    task5 = BashOperator(
        task_id = 'task5',
        bash_command='sleep 3'
    )

    task6 = BashOperator(
        task_id = 'task6',
        bash_command='sleep 3'
    )



    end = BashOperator(
        task_id = "end",
        bash_command='sleep 3',
        do_xcom_push = False
    )


    start >> load_sub_dag >>branch >> [task5,task6] >> end


