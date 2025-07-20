from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.task_group import TaskGroup




def load_subdag(parent_dag_id, child_dag_id,args):
    subdag  = DAG(dag_id= f"{parent_dag_id}.{child_dag_id}",
                  default_args=args,
                  schedule="@daily")
    
    with subdag:
        start = BashOperator(
        task_id = 'start_sub_task',
        bash_command='sleep 3')

        task1 = BashOperator(
        task_id = 'task1_substask',
        bash_command='sleep 3')


        with TaskGroup(group_id="group") as group1:
            group_task1 = BashOperator(
            task_id = 'group_task1',
            bash_command='sleep 3')

            group_task2 = BashOperator(
            task_id = 'group_task2',
            bash_command='sleep 3')
            
            group_task1 >> group_task2


        end = BashOperator(
        task_id = "end_subtask",
        bash_command='sleep 3')

        start >> task1 >> group1 >>end

    return subdag