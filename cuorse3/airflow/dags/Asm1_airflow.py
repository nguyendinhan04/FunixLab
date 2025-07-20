from airflow import DAG
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
from datetime import datetime 
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import BranchPythonOperator,PythonOperator
from airflow.operators.bash import BashOperator
from airflow.decorators import dag, task
import os
from googledrivedownloader import download_file_from_google_drive


def _is_dowloaded():
    if os.path.exists("Answers.csv") and os.path.exists("Questions.csv"):
        return 'end'    
    return 'clear_file'


def _dowload_Answers_from_ggdrive():
    download_file_from_google_drive(file_id='1uWt36rF4TTtZe2fQKA5vZt7BM9ZDpysr',dest_path='/usr/local/airflow/include/Answers.csv',unzip='True')

def _dowload_Questions_from_ggdrive():
    download_file_from_google_drive(file_id='1kKVqd43l9jRLt_nj2kev8ypBgtxIzWaQ',dest_path='/usr/local/airflow/include/Questions.csv',unzip = 'True')



with DAG('ASM2',start_date=datetime(2025,1,1),schedule_interval = '@daily',catchup=False) as dag:
    # submit_job = SparkSubmitOperator(
    #     task_id = "submit_spark",
    #     conn_id='spark_conn',
    #     application="./include/spark_script/transform_data.py",
    #     total_executor_cores='1',
    #     executor_cores='1',
    #     executor_memory='2g',
    #     num_executors='1',
    #     driver_memory='2g',
    #     verbose=False
    # )
    start = EmptyOperator(
        task_id= 'Start'
    )


    end = EmptyOperator(
        task_id= 'End'
    )

    branching = BranchPythonOperator(
        task_id = 'branching',
        python_callable=_is_dowloaded
    )


    clear_file = BashOperator(
        task_id = "clear_file",
        bash_command="rm /usr/local/airflow/include/Answers.csv /usr/local/airflow/include/Questions.csv"
        # bash_command="rm /usr/local/airflow/include/test.csv"
    )

    dowload_answer_file_task = PythonOperator(
        task_id= "dowload_answer_file_task",
        python_callable=_dowload_Answers_from_ggdrive
    )

    dowload_question_file_task = PythonOperator(
        task_id= "dowload_question_file_task",
        python_callable=_dowload_Questions_from_ggdrive
    )


    start >> branching

    branching >> end
    branching >> clear_file
    clear_file >> [dowload_answer_file_task,dowload_question_file_task]

