--==============================================
-- FDC_DOWNTIME (Done)
--==============================================
with RSA as (
    SELECT
        'MERGE' as ORIGIN,
        R.ROUTE_UID,
        R.FDC_ROUTE_NUMBER,
        R.FDC_ROUTE_NAME,
        UPPER(O.OPERATOR_NAME) AS TENDER_NAME,
        UPPER(M.OPERATOR_NAME) AS FOREMAN_NAME,
        CONCAT(R.FDC_ROUTE_NUMBER, ' ',R.FDC_ROUTE_NAME) AS ROUTE_TITLE,
        S.SITE_UID,
        S.SITE_CODE,
        S.SITE_NAME,
        A.ASSET_UID,
        A.ASSET_CODE,
        A.ASSET_CODE AS ASSET_CODE_DOWNTIME,
        A.ASSET_NAME, 
        CONCAT((case when T.ASSET_TYPE_NAME = 'House Gas' then 'House Gas' when ASSET_TYPE_NAME = 'Zone' then 'Downtime'  when T.ASSET_TYPE_NAME in ('Zone','Salt Water Disposal','SWD') then 'SWD'  else '' end ) 
        ,case when C.ASSET_CLASS_NAME ='Equipment' or T.ASSET_TYPE_NAME ='Fluid Meter'  then T.ASSET_TYPE_NAME when C.ASSET_CLASS_NAME  in ('Zone','Salt Water Disposal','SWD') then '' else C.ASSET_CLASS_NAME end
        , ' ', A.ASSET_CODE, ' ', A.ASSET_NAME) ASSET_TITLE,
        C.ASSET_CLASS_UID,
        C.ASSET_CLASS_NAME,
        CASE WHEN C.ASSET_CLASS_NAME = 'House Gas' THEN 'Domestic Locations' ELSE C.ASSET_CLASS_NAME END ASSET_CLASS_TITLE,
        T.ASSET_TYPE_UID, 
        T.ASSET_TYPE_NAME
    FROM       {{source('fdc_app_raw_merge', 'asset')}} A 
    INNER JOIN {{source('fdc_app_raw_merge', 'asset_type')}}   AS T ON A.ASSET_TYPE_UID    = T.ASSET_TYPE_UID
    INNER JOIN {{source('fdc_app_raw_merge', 'asset_class')}}  AS C ON T.ASSET_CLASS_UID   = C.ASSET_CLASS_UID
    INNER JOIN {{source('fdc_app_raw_merge', 'site')}}         AS S ON A.SITE_UID          = S.SITE_UID
    INNER JOIN {{source('fdc_app_raw_merge', 'route')}}        AS R ON S.ROUTE_UID         = R.ROUTE_UID
    INNER JOIN {{source('fdc_app_raw_merge', 'operator')}}     AS O ON R.OPERATOR_UID      = O.OPERATOR_UID
    LEFT  JOIN {{source('fdc_app_raw_merge', 'operator')}}     AS M ON O.MANAGER_UID       = M.OPERATOR_UID
)
SELECT 
    COALESCE(FDCUpdateID,DT.DOWNTIME_UID,UUID_STRING()) DOWNTIME_UID
    , RSA.ASSET_UID
    , MST.DTBEGINDATETIME BEGIN_DATETIME
    , RSN.METRIC_DOMAIN_UID
    , CASE WHEN MST.DTENDDATETIME IS NULL OR MST.DTENDDATETIME = TO_DATE('12-31-2078','MM-DD-YYYY') THEN NULL ELSE MST.DTENDDATETIME END END_DATETIME
    , MST.SOURCESYSTEM SOURCE_SYSTEM
    , CASE WHEN MST.STATUS > 0 THEN 1 ELSE 0 END IS_ACTIVE
    , COALESCE(LASTUPDATED, convert_timezone('America/Los_Angeles' , 'UTC',CURRENT_TIMESTAMP())) LAST_UPDATE
    , MST.DTSTATUS
    , COALESCE(DT.VISIT_METRIC_BEGIN_DATE_UID, UUID_STRING()) VISIT_METRIC_BEGIN_DATE_UID
    , COALESCE(DT.VISIT_METRIC_DTREASON_UID, UUID_STRING()) VISIT_METRIC_DTREASON_UID
    , CASE WHEN MST.DTENDDATETIME IS NULL OR MST.DTENDDATETIME = TO_DATE('12-31-2078','MM-DD-YYYY') THEN NULL ELSE COALESCE(DT.VISIT_METRIC_END_DATE_UID, UUID_STRING()) END VISIT_METRIC_END_DATE_UID
    , MST.CREATION_DATE
FROM {{source('fdc_app_raw_merge', 'downtime_master')}} MST
INNER JOIN RSA ON MST.ASSETCODE = RSA.ASSET_CODE_DOWNTIME
INNER join (
              SELECT METRIC_DOMAIN_UID, METRIC_DOMAIN_CODE
              FROM {{source('fdc_app_raw_merge', 'metric')}} M
              INNER JOIN {{source('fdc_app_raw_merge', 'metric_domain')}} MD ON M.METRIC_UID =MD.METRIC_UID
              WHERE METRIC_CODE ='MTR085'
            ) RSN ON TRIM(MST.DTREASON) = RSN.METRIC_DOMAIN_CODE
LEFT JOIN {{source('fdc_app_raw_merge', 'fdc_downtime')}} DT ON --RSA.ASSET_UID = DT.ASSET_UID  AND TO_CHAR(MST.DTBEGINDATETIME,'YYYYMMDD_HH24MISSFF') = TO_CHAR(to_timestamp(DT.BEGIN_DATETIME),'YYYYMMDD_HH24MISSFF') and MST.status = CASE WHEN dt.IS_ACTIVE = true THEN 1 ELSE 0 END
        MST.FDCUpdateID = DT.DOWNTIME_UID
WHERE ORIGIN = 'MERGE'
--AND MST.LASTUPDATED >= dateadd('day',-20,current_date())