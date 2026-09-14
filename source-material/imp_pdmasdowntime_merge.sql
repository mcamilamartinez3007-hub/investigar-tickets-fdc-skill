{{
    config(
        alias='IMP_PDMASDOWNTIME',
        materialized='incremental',
        transient=false,
        unique_key='surrogate_key',
        incremental_strategy='merge',
        on_schema_change='append_new_columns'
    )
}}

{{ 
    ti_dbt_utils.fdc_incremental_load_by_surrogate_key(
        project='fdc',
        source=ref('stg_pre_upsert_imp_pdmasdowntime_merge'), 
        key=['HDRTYPECODE','HDRCODE','DTBEGINDATETIME']) 
}}