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

def _is_dowloaded():
    if os.path.exists("/usr/local/airflow/include/Answers.csv") and os.path.exists("/usr/local/airflow/include/Questions.csv"):
        # return 'end'   
        return "end"
        # return "spark_process"
    else: 
        return 'clear_file_group'
        # return "spark_process"

def _is_Answers_exists():
    if os.path.exists('/usr/local/airflow/include/Answers.csv'):
        return 'clear_file_group.clear_Answers'
    else:
        return 'clear_file_group.skip_clear_Answers'


def _is_Questions_exists():
    if os.path.exists('/usr/local/airflow/include/Questions.csv'):
        return 'clear_file_group.clear_Questions'
    else:
        return 'clear_file_group.skip_clear_Questions'


def _dowload_Answers_from_ggdrive():
    download_file_from_google_drive(file_id='1uWt36rF4TTtZe2fQKA5vZt7BM9ZDpysr',dest_path='/usr/local/airflow/include/Answers.csv',unzip='True')

def _dowload_Questions_from_ggdrive():
    download_file_from_google_drive(file_id='1kKVqd43l9jRLt_nj2kev8ypBgtxIzWaQ',dest_path='/usr/local/airflow/include/Questions.csv',unzip = 'True')

def _import_mongo(src_path, collection_name,db_name):

    mongo_hook = MongoHook(conn_id  = "mongo_default")

    batch_size = 10

    with open(src_path,"r",encoding="utf-8", errors="replace") as Data_file:
        csv_reader = csv.reader(Data_file)
        str_header = next(Data_file)
        header = str_header.split(',')
        print(header)
        

        batch = []
        for i,row in enumerate(csv_reader,start=1):
            json_row = {}
            for j in range(0,len(row)):
                json_row.setdefault(header[j],row[j])
            batch.append(json_row)

            if i % batch_size == 0:  # Khi đạt batch_size, xử lý batch
                mongo_hook.insert_many(mongo_collection=collection_name, docs=batch, mongo_db=db_name) 
                batch.clear()  # Xóa batch sau khi xử lý

    if batch:  # Xử lý các dòng còn lại nếu có
        mongo_hook.insert_many(mongo_collection=collection_name, docs=batch, mongo_db=db_name)

def import_Answers_to_mongo():
    _import_mongo('/usr/local/airflow/include/Answers.csv', 'ASM2_Answers','admin')

def import_Questions_to_mongo():
    _import_mongo('/usr/local/airflow/include/Questions.csv', 'ASM2_Questions','admin')

# def _import_output_mongo():
#     _import_mongo('/usr/local/airflow/include/ouput.csv','ASM2_ouput','admin')

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

with DAG('ASM2',start_date=datetime(2025,1,1),schedule_interval = '@daily',catchup=False) as dag:


    start = EmptyOperator(
        task_id= 'Start'
    )


    end = EmptyOperator(
        task_id= 'end'
    )

    branching = BranchPythonOperator(
        task_id = 'branching',
        python_callable=_is_dowloaded
    )

    with TaskGroup("clear_file_group") as clear_group:

        check_exist_answers = BranchPythonOperator(
            task_id = "check_exist_answers",
            python_callable=_is_Answers_exists
        )


        check_exist_questions = BranchPythonOperator(
            task_id = "check_exist_questions",
            python_callable=_is_Questions_exists
        )


        clear_Answers = BashOperator(
            task_id = 'clear_Answers',
            bash_command='rm /usr/local/airflow/include/Answers.csv'
        )

        clear_Questions = BashOperator(
            task_id = 'clear_Questions',
            bash_command='rm /usr/local/airflow/include/Questions.csv'
        )

        end_clear_file = EmptyOperator(
            task_id = "end_clear_file",
            trigger_rule = 'one_success'
        )

        skip_clear_Questions = EmptyOperator(
            task_id = "skip_clear_Questions",
        )

        skip_clear_Answers = EmptyOperator(
            task_id = "skip_clear_Answers",
        )


        end_clear_Question = EmptyOperator(
            task_id = "end_clear_Question",
            trigger_rule='one_success'
        )

        end_clear_Answers = EmptyOperator(
            task_id = "end_clear_Answers",
            trigger_rule='one_success'
        )
        



        [check_exist_answers,check_exist_questions]
        check_exist_questions >> [skip_clear_Questions,clear_Questions] >> end_clear_Question
        check_exist_answers >> [skip_clear_Answers,clear_Answers] >> end_clear_Answers


        [end_clear_Question,end_clear_Answers] >> end_clear_file



    dowload_answer_file_task = PythonOperator(
        task_id= "dowload_answer_file_task",
        python_callable=_dowload_Answers_from_ggdrive
    )

    dowload_question_file_task = PythonOperator(
        task_id= "dowload_question_file_task",
        python_callable=_dowload_Questions_from_ggdrive
    )

    import_answers_mongo = PythonOperator(
        task_id = "import_answers_mongo",
        python_callable=import_Answers_to_mongo
    )


    import_questions_mongo = PythonOperator(
        task_id = "import_questions_mongo",
        python_callable=import_Questions_to_mongo
    )



    


    spark_process = SparkSubmitOperator(
        task_id = "spark_process",
        conn_id='spark_conn',
        application="./include/spark_script/transform_data.py",
        packages=r"org.mongodb.spark:mongo-spark-connector_2.12:10.4.1",
        total_executor_cores='1',
        executor_cores='1',
        executor_memory='1g',
        num_executors='2',
        driver_memory='1g',
        verbose=False,
        trigger_rule='one_success'
    )

    import_output_mongo = EmptyOperator(
        task_id = "import_output_mongo",
    )


    start >>  branching
    branching >> end
    branching >> clear_group
    clear_group >> [dowload_answer_file_task, dowload_question_file_task]
    dowload_answer_file_task >> import_answers_mongo >> spark_process
    dowload_question_file_task >> import_questions_mongo >> spark_process
    spark_process >> import_output_mongo  >> end