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
from airflow.providers.apache.spark.hooks.spark_connect import SparkConnectHook
from airflow.providers.apache.spark.hooks.spark_sql import SparkSqlHook
import csv
import json

def _is_dowloaded():
    if os.path.exists("Answers.csv") and os.path.exists("Questions.csv"):
        return 'end'    
    return 'clear_file'


def _dowload_Answers_from_ggdrive():
    download_file_from_google_drive(file_id='1uWt36rF4TTtZe2fQKA5vZt7BM9ZDpysr',dest_path='/usr/local/airflow/include/Answers.csv',unzip='True')

def _dowload_Questions_from_ggdrive():
    download_file_from_google_drive(file_id='1kKVqd43l9jRLt_nj2kev8ypBgtxIzWaQ',dest_path='/usr/local/airflow/include/Questions.csv',unzip = 'True')


def spark_process_import_Answers():
    mongo_hook = MongoHook(conn_id = "mongo_default")
    Answers_collection = mongo_hook.get_collection("ASM2_Answers","admin")
    data = list(Answers_collection.find({}, {"_id": 0}))


    file_path = "/usr/local/airflow/include/Answers.json"
    with open(file_path, "w") as f:
        json.dump(data, f)

def spark_process_import_Questions():
    mongo_hook = MongoHook(conn_id = "mongo_default")
    Answers_collection = mongo_hook.get_collection("ASM2_Questions","admin")
    data = list(Answers_collection.find({}, {"_id": 0}))


    file_path = "/usr/local/airflow/include/Questions.json"
    with open(file_path, "w") as f:
        json.dump(data, f)


def _import_mongo():
    mongo_hook = MongoHook(conn_id  = "mongo_default")
    batch_size = 100
    collection = mongo_hook.get_collection("ASM22","admin")
    print(collection)
    mongo_hook.insert_many(mongo_collection="ASM22", docs=[{"a" : 1}], mongo_db="admin")

    # with open("/usr/local/airflow/include/Questions.csv","r") as Questions_file:
    #     csv_reader = csv.reader(Questions_file)
    #     str_header = next(Questions_file)
    #     header = str_header.split(',')
    #     print(header)
        

    #     batch = []
    #     for i,row in enumerate(csv_reader,start=1):
    #         json_row = {}
    #         for i in range(0,len(row)):
    #             json_row.setdefault(header[i],row[i])
    #         batch.append(json_row)

    #         print(json_row)
    #         if i % batch_size == 0:  # Khi đạt batch_size, xử lý batch
    #             mongo_hook.insert_many(mongo_collection="ASM2", docs=batch, mongo_db="admin") 
    #             batch.clear()  # Xóa batch sau khi xử lý

    # if batch:  # Xử lý các dòng còn lại nếu có
    #     mongo_hook.insert_many(mongo_collection="test_import", docs=batch, mongo_db="admin")


def _spark_process():
    sprk_sql = SparkSqlHook()


with DAG('Test',start_date=datetime(2025,1,1),schedule_interval = '@daily',catchup=False) as dag:

    start = EmptyOperator(
        task_id= 'Start'
    )


    end = EmptyOperator(
        task_id= 'End'
    )
    # spark_process = PythonOperator(
    #     task_id = "import_mongo",
    #     python_callable=_spark_process
    # )

    # importttt = PythonOperator(
    #     task_id = "immrmrm",
    #     python_callable=spark_process_import_Answers
    # )
    # importttt
    spark_process = SparkSubmitOperator(
        task_id = "spark_process",
        conn_id='spark_conn',
        application="./include/spark_script/transform_data.py",
        total_executor_cores='1',
        executor_cores='1',
        executor_memory='1g',
        num_executors='1',
        driver_memory='1g',
        verbose=False
    )

    start >> spark_process >> end
