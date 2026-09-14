--==============================================
-- VISIT_ASSET (TESTING)
--==============================================
WITH VM_STG as (
        SELECT 
            VISIT_METRIC_UID
            ,METRIC_UID
            ,VISIT_ASSET_UID
            ,DT.ASSET_UID
            --,TO_DATE(COALESCE(NULLIF(DT.END_DATETIME,'2078-12-31'),DT.BEGIN_DATETIME)) VISIT_METRIC_DATE
            ,stg.VISIT_METRIC_DATE
            ,METRIC_VALUE_UID
        FROM  {{ ref('fdc_stg_visit_metric_merge') }} stg
        inner join {{ ref('fdc_stg_downtime_merge') }} dt on stg.METRIC_VALUE_UID = dt.DOWNTIME_UID
    ) 
, VA_AGR as (
    SELECT 
        vm.VISIT_ASSET_UID
        ,VA.VISIT_SITE_UID
        ,COALESCE(VA.ASSET_UID,VM.ASSET_UID) ASSET_UID
        ,COALESCE(VA.VISIT_ASSET_DATE,VM.VISIT_METRIC_DATE) VISIT_ASSET_DATE
        ,VA.TANK_HEIGHT
    FROM       VM_STG                               vm 
    LEFT JOIN  {{source('fdc_app_raw_merge', 'visit_asset')}}    VA   ON VM.VISIT_ASSET_UID       = VA.VISIT_ASSET_UID 
    LEFT JOIN  {{source('fdc_app_raw_merge', 'visit_site')}}     VS   ON VA.VISIT_SITE_UID        = VS.VISIT_SITE_UID
    left join  {{source('fdc_app_raw_merge', 'asset')}}          ast on vm.asset_uid = ast.asset_uid
    GROUP BY vm.VISIT_ASSET_UID
        ,VA.VISIT_SITE_UID
        ,COALESCE(VA.ASSET_UID,VM.ASSET_UID)
        ,COALESCE(VA.VISIT_ASSET_DATE,VM.VISIT_METRIC_DATE)
        ,VA.TANK_HEIGHT
)
  SELECT 
      VISIT_ASSET_UID
      ,COALESCE(VISIT_SITE_UID, UUID_STRING()) VISIT_SITE_UID
      ,ASSET_UID
      ,VISIT_ASSET_DATE
      ,TANK_HEIGHT 
  FROM VA_AGR