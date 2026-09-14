{{
    config(
        materialized='incremental',
        unique_key='surrogate_key',
        incremental_strategy='merge',
        transient=false,
        on_schema_change='append_new_columns'
    )
}}

{{ 
    ti_dbt_utils.fdc_incremental_load_by_surrogate_key(
        project='fdc',
        source=ref('stg_pre_upsert_fdc_downtime_merge'), 
        key=['ASSET_UID','BEGIN_DATETIME','IS_ACTIVE']) 
}}