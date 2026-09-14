--==============================================
-- VISIT_SITE (DONE)
--==============================================
WITH vm_grp as (
    SELECT va.VISIT_site_UID, coalesce(vs.site_uid, ast.site_uid) site_uid, coalesce(vs.visit_date, va.visit_asset_date) visit_asset_date
    --, VM.ENTRY_TYPE AS VISIT_TYPE, VM.LAST_SYNC_DATETIME AS SYNC_DATE,  VM.SOURCE_SYSTEM
    FROM {{ ref('fdc_stg_visit_metric_merge') }}  vm
    LEFT JOIN {{ ref('fdc_stg_visit_asset_merge') }}  va ON vm.visit_asset_uid = va.visit_asset_uid
    LEFT JOIN {{source('fdc_app_raw_merge', 'asset')}} ast on va.asset_uid = ast.asset_uid
    LEFT JOIN {{source('fdc_app_raw_merge', 'visit_site')}} VS ON VA.VISIT_SITE_UID = VS.VISIT_SITE_UID
    GROUP BY va.VISIT_site_UID, coalesce(vs.site_uid, ast.site_uid) , coalesce(vs.visit_date, va.visit_asset_date) --, VM.ENTRY_TYPE, VM.LAST_SYNC_DATETIME,  VM.SOURCE_SYSTEM
  )
  SELECT 
       VM.VISIT_SITE_UID
    ,vm.SITE_UID
    ,coalesce(vs.OPERATOR_UID,RT.OPERATOR_UID) OPERATOR_UID
    ,coalesce(vs.VISIT_DATE,vm.VISIT_ASSET_DATE) VISIT_DATE
   FROM  vm_grp vm
  LEFT JOIN {{source('fdc_app_raw_merge', 'visit_site')}} vs ON vM.visit_site_uid = vs.visit_site_uid
  INNER JOIN {{source('fdc_app_raw_merge', 'site')}} st on VM.site_uid = st.site_uid
  INNER JOIN {{source('fdc_app_raw_merge', 'route')}} rt on st.route_uid = rt.route_uid