from airflow import DAG
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
from datetime import datetime 
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import BranchPythonOperator,PythonOperator
from airflow.operators.bash import BashOperator
from airflow.decorators import dag, task
import os
from googledrivedownloader import download_file_from_google_drive
from airflow.providers.mongo.hooks.mongo import MongoHook
from airflow.utils.task_group import TaskGroup
import csv
import json




def _is_Answers_exists():
    if os.path.exists('usr/local/airflow/include/Answers.csv'):
        return 'clear_Answers'
    else:
        return 'clear_file_group.Answersskipclear'


        



with DAG('Test2',start_date=datetime(2025,1,1),schedule_interval = '@daily',catchup=False) as dag:

    with TaskGroup("clear_file_group") as clear_group:

        check_exist_answers = BranchPythonOperator(
            task_id = "check_exist_answers",
            python_callable=_is_Answers_exists
        )

        clear_Answers = EmptyOperator(
            task_id = 'clear_Answers'
        )

 

        skip_clear_answers = EmptyOperator(
            task_id = r'Answersskipclear'
        )

        check_exist_answers >> [skip_clear_answers,clear_Answers]

    clear_group
