from airflow.providers.mongo.hooks.mongo import MongoHook
from airflow import DAG
from airflow.operators.python import BranchPythonOperator,PythonOperator
from datetime import datetime
from airflow.operators.empty import EmptyOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
import csv


def _is_dowloaded():
    src_path = "/usr/local/airflow/include/test.csv"
    print("HEHEHEHEEEEEEEEEEEEEEEEEEEEEEHEHEHEHEHEHEHEHE")
    with open(src_path,"r",encoding="utf-8", errors="replace") as Data_file:
        csv_reader = csv.reader(Data_file)
        str_header = next(Data_file)
        header = str_header.split(',')
        print("header: ")
        print(header)
        print("preheader: ")
        batch_size = 4

        batch = []
        for i,row in enumerate(csv_reader,start=1):
            print(i)
            json_row = {}
            for j in range(0,len(row)):
                json_row.setdefault(header[j],row[j])
            batch.append(json_row)
            print(json_row)
            if (i % batch_size) == 0:  # Khi đạt batch_size, xử lý batch
                print("xu ly batch")
                batch.clear()  # Xóa batch sau khi xử lý
        if batch:  # Xử lý các dòng còn lại nếu có
            print("xu ly batch cuoi")
            print("Batch cuoi: ", batch)
            batch.clear()


with DAG('test_mongo',start_date=datetime(2025,1,1),schedule_interval = '@daily',catchup=False) as dag: 
    start = EmptyOperator(
        task_id= 'Start'
    )

    mid  = SparkSubmitOperator(
        task_id = "spark_process",
        conn_id='spark_conn',
        application="./include/spark_script.py",
        packages=r"org.mongodb.spark:mongo-spark-connector_2.12:10.4.1",
        total_executor_cores='1',
        executor_cores='1',
        executor_memory='1g',
        num_executors='1',
        driver_memory='1g',
        verbose=False
    )
    end = EmptyOperator(
        task_id= 'end'
    )

    start >> mid >> end