from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator 
# from airflow.operators.postgres_operator import PostgresOperator
from airflow.providers.http.sensors.http import HttpSensor
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.operators.python import PythonOperator
from airflow.providers.sqlite.operators.sqlite import SqliteOperator
from datetime import datetime
from airflow.providers.postgres.hooks.postgres import PostgresHook 
import json
from pandas import json_normalize

def _process_user(ti):
    user = ti.xcom_pull(task_ids = "extract_user")
    user = user['result'][0]
    processed_user = json_normalize({
        "first_name" : user['name']['first'],
        "lastname" : user['name']['last'],
        'country': user['location']['country'],
        'username': user['login']['username'],
        'password' : user['login']['password'],
        'email':user['email']
    })
    print(processed_user)

def _store_user():
    hook = PostgresHook(postgres_conn_id = 'postgres')
    hook.copy_expert(
        sql = "COPY users FROM stdin WITH DELIMITER as ','",
        filename='/tmp/processed_user.csv'
    )

with DAG('Lab11_2', start_date = datetime(2025,2,9), schedule_interval = '@daily', catchup = False) as dag:
    create_table = SqliteOperator(task_id = 'create_table',sqlite_conn_id = 'sqlite',
                                  sql = r'''CREATE TABLE IF NOT EXISTS users(
                                  firstname TEXT NOT NULL,
                                    lastname TEXT NOT NULL,
                                    country TEXT NOT NULL,
                                    username TEXT NOT NULL,
                                    password TEXT NOT NULL,
                                    email TEXT NOT NULL PRIMARY KEY );
                                    ''')
    is_api_available = SimpleHttpOperator(
        task_id='is_api_available',
        http_conn_id='user_api',
        endpoint='api/',
        method='GET'
    )
    create_table >> is_api_available