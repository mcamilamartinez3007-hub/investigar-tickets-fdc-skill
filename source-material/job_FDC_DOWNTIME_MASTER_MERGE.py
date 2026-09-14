import sys
sys.path.append("/usr/local/airflow/include/config_dags/job_config")

from airflow import DAG
import pendulum
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from include.config_dags.job_config.job_config import JobConfig

# DEFINE VARIABLES
dag_id = 'FDC_DOWNTIME_MASTER_MERGE'
filename = '/usr/local/airflow/include/config_dags/FDC/DOWNTIME_MERGE/fdc_downtime_master.json'



# CONFIGURE JOB OBJECT
job_config = JobConfig( dag_id = dag_id , 
                        filename = filename )

# CREATE THE DAG
with DAG(dag_id=job_config.DAG_ID,
         schedule=None,
         on_failure_callback=job_config.failure_on_dag,
         tags=["DEC_FDC", "DOWNTIME","CHILD","MERGE"],
         start_date=pendulum.datetime(2024, 1, 1, tz="America/New_York")
         ) as dag:

    # #DBT Downtime Exceptions
    # DBT source freshness  
    bash_operators = []
    for command, _id in zip(job_config.dbt_commands, job_config.task_ids):

        t1 = BashOperator(
            task_id=_id,
            bash_command=command + f" --profiles-dir {job_config.DBT_PROFILE_DIR} --project-dir {job_config.DBT_PROJECT_DIR}",
            on_failure_callback=job_config.failure_on_task
        )

        bash_operators.append(t1)

    # CREATE DEPENDENCIES IN AIRFLOW SO THE TASK EXECUTES IN THIS ORDER    
    #fdc_scada_dgo_fdc_raw >> 
    bash_operators[0]
