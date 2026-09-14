WITH DWNT_ENE AS (
  -- Enertia is the main source - get all downtime data from Enertia
  SELECT 
        ENE.HDRTYPECLASS,
        ENE.HDRTYPECODE,
        ENE.ASSETCODE,
        ENE.ASSETNAME,
        ENE.DOWNTIMETID,
        ENE.DOWNTIMEHID,
        ENE.DTPRODDAYSTART,
        ENE.DTREASON,
        ENE.DTREASONDESC,
        ENE.DTBEGINDATETIME,
        ENE.DTENDDATETIME,
        ENE.DTTOTALHRS,
        ENE.OPERATOR_UID,
        ENE.DTREMARKS,
        ENE.SOURCESYSTEM,
        ENE.RECORDSRCTID,
        ENE.DTENTRYDATETIME,
        ENE.LASTUPDATEID,
        ENE.LASTUPDATED,
        ENE.WHLOADDATEUTC
    -- Reads the source that is filtered for recent data (last 6 months) 
  FROM {{ ref('stg_ene_vw_downtime_merge') }} ENE

)

, new_enertia_downtime AS (
  -- Insert new downtime records from Enertia (main source)
  SELECT 
    ENE.HDRTYPECLASS
  , ENE.HDRTYPECODE AS ASSETTYPECODE
  , ENE.ASSETCODE
  , ENE.ASSETNAME
  , ENE.DOWNTIMETID
  , ENE.DOWNTIMEHID
  , ENE.DTPRODDAYSTART
  , ENE.DTREASON
  , ENE.DTREASONDESC
  , ENE.DTBEGINDATETIME
  , ENE.DTENDDATETIME
  , ENE.DTTOTALHRS
  , ENE.OPERATOR_UID
  , ENE.DTREMARKS
  , NULL AS FDCUpdateID
  , 2 AS DTStatus  -- Enertia source status
  , ENE.SOURCESYSTEM
  , ENE.RECORDSRCTID
  , ENE.DTENTRYDATETIME
  , ENE.LASTUPDATEID
  , ENE.LASTUPDATED
  , ENE.WHLOADDATEUTC
  , COALESCE(ENE.LASTUPDATED, convert_timezone('America/Los_Angeles', 'UTC', current_timestamp())) AS CREATION_DATE
  , ENE.LASTUPDATED AS LAST_UPDATE
  , 1 AS STATUS  -- Active status
  , convert_timezone('America/Los_Angeles', 'UTC', CURRENT_DATE()) AS LAST_SYNC_DATETIME
  FROM DWNT_ENE ENE

)
-- Final output:Records with Enertia as the leading source
SELECT * FROM new_enertia_downtime


  
  
