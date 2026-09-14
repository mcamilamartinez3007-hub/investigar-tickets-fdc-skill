from airflow import DAG
import os
from pathlib import Path
import smtplib
import pendulum
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from airflow.models import Variable
from airflow.operators.python import PythonOperator
from airflow.operators.email import send_email as se
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.operators.bash import BashOperator


# DAG ID
dag_id = 'FDC_DOWNTIME_ORCHESTRATOR_MERGE'

# EMAIL VARIABLES
NotificationAccount = Variable.get("NotificationAccount")
NotificationPassword = Variable.get("NotificationPassword")
FDC_APP_emailOnFailure_to = Variable.get("FDC_DWNTM_emailOnFailure_to")
downtime_schedule = Variable.get("downtime_schedule")

# DBT VARIABLES
DBT_PROJECT_DIR = '/usr/local/airflow/dbt'
DBT_PROFILE_DIR = '/usr/local/airflow/dbt'


def faliure_on_DAG(context):
    # set up the SMTP server
    s = smtplib.SMTP(host='smtp-mail.outlook.com', port=587)
    s.starttls()
    s.login(NotificationAccount, NotificationPassword)

    msg = MIMEMultipart()  # create a message

    # add in the actual person name to the message template
    message = 'Hi, please check DAG: ' + dag_id + ' recently failed \n\n' + 'The log error: ' + str(
        context.get('exception'))

    # setup the parameters of the message
    msg['From'] = NotificationAccount
    msg['To'] = FDC_APP_emailOnFailure_to
    msg['Subject'] = "Faliure DAG"

    # add in the message body
    msg.attach(MIMEText(message, 'plain'))

    # send the message via the server set up earlier.
    s.send_message(msg)

    del msg


with DAG(dag_id=dag_id,
         schedule=downtime_schedule,
         on_failure_callback=faliure_on_DAG,
         start_date=pendulum.datetime(2023, 2, 2, tz="CST6CDT"),
         catchup=False,
         tags=["DEC_FDC", "DOWNTIME","ORCHESTRATOR","MERGE"]
         ) as dag:

        fdc_downtime_exceptions_dag = TriggerDagRunOperator(
            task_id='FDC_DOWNTIME_EXCEPTIONS',
            trigger_dag_id='FDC_DOWNTIME_EXCEPTIONS_MERGE',
            wait_for_completion=True
        )
        fdc_downtime_master_dag = TriggerDagRunOperator(
            task_id='FDC_DOWNTIME_MASTER',
            trigger_dag_id='FDC_DOWNTIME_MASTER_MERGE',
            wait_for_completion=True
        )
        fdc_dim_imp_pdmasdowntime_dag = TriggerDagRunOperator(
            task_id='FDC_DIM_IMP_PDMASDOWNTIME',
            trigger_dag_id='MERGE_FDC_DIM_IMP_PDMASDOWNTIME',
            wait_for_completion=True
        )
        fdc_downtime_merge_dag = TriggerDagRunOperator(
            task_id='FDC_DOWNTIME_MERGE',
            trigger_dag_id='FDC_DOWNTIME_MERGE',
            wait_for_completion=True
        )
        check_mirrors = BashOperator(
            task_id='CHECK_DOWNTIME_MIRROR_SOURCES',
            bash_command= f"dbt test -s tag:downtime_merge -t dwntm_merge --profiles-dir {DBT_PROFILE_DIR} --project-dir {DBT_PROJECT_DIR}",
            on_failure_callback=faliure_on_DAG
        )

        check_mirrors >> fdc_downtime_exceptions_dag >> fdc_downtime_master_dag >>  [fdc_dim_imp_pdmasdowntime_dag,  fdc_downtime_merge_dag]
        #>> fdc_route_dag >> fdc_well_master_dag >> fdc_site_dag

        