WITH DWNT_FDC AS (
  -- FDC Overhaul staging used to find FDC-new and FDC-closure candidates
  SELECT 
      HDRTYPECLASS
    , ASSETTYPECODE
    , ASSETCODE
    , ASSETNAME
    , DTBEGINDATETIME
    , DTENDDATETIME
    , DTTOTALHRS
    , DTREASON
    , DTREASONDESC
    , OPERATOR_UID
    , DTREMARKS
    , METRIC_VALUE_UID
    , DTStatus
    , SOURCESYSTEM
    , LASTUPDATED
    , IS_ACTIVE
  FROM {{ ref('stg_fdc_stg_dwntime_merge') }} F
  WHERE  F.IS_ACTIVE = TRUE
  AND       TO_TIMESTAMP(F.LASTUPDATED)>=  DATEADD('Day',-1,TO_DATE(convert_timezone('UTC',current_timestamp())))
  AND       TO_TIMESTAMP(F.LASTUPDATED) <  TO_DATE(convert_timezone('UTC',current_timestamp()))
   -- convert_timezone('UTC','America/Chicago', TO_TIMESTAMP_NTZ(F.LASTUPDATED)) > TO_TIMESTAMP_NTZ(DATEADD(hour, 3,DATE_TRUNC('day', CONVERT_TIMEZONE('America/Chicago', CURRENT_TIMESTAMP()))))
    /*AND convert_timezone('UTC','US/Central', TO_TIMESTAMP(F.LASTUPDATED))::timestamp_ntz >= DATEADD('Day',-1,TO_DATE(convert_timezone('US/Central',current_timestamp())))
    AND convert_timezone('UTC','US/Central', TO_TIMESTAMP(F.LASTUPDATED))::timestamp_ntz <  TO_DATE(convert_timezone('US/Central',current_timestamp()))*/
)
 SELECT 
        cast(null as VARCHAR(50)) PROCESSID
      , cast(null as VARCHAR(50))  RECFLAG
      , cast(null as VARCHAR(50))  HDRXREFTYPE
      , cast(null as VARCHAR(50))  HDRXREFVALUE
      , ASSETTYPECODE HDRTYPECODE
      , ASSETCODE HDRCODE
      , ASSETNAME HDRNAME
      , cast(null as VARCHAR(50))  HDRHID
      , cast(null as VARCHAR(50))  DTENTRYDATETIME
      , DTBEGINDATETIME
      , DTENDDATETIME
      , DTTOTALHRS
      , DTREASON
      , DTREASONDESC
      , DTREMARKS
      , cast(null as VARCHAR(50))  DOWNTIMEHID
      , cast(null as VARCHAR(50))  DOWNTIMETID
      , cast(null as VARCHAR(50))  HDRTYPETID
      , cast(null as VARCHAR(50))  RECORDSRCCODE
      , cast(null as VARCHAR(50))  RECORDSRCDESC
      , cast(null as VARCHAR(50))  RECORDSRCTID
      , cast(null as VARCHAR(50))  LASTUPDATEID
      , LASTUPDATED
      , cast(null as VARCHAR(50))  DTPRODDAYSTART
      , cast(null as VARCHAR(50))  DTBEGDAYHRSDOWN
      , cast(null as VARCHAR(50))  DTENDDAYHRSDOWN
      , cast(null as VARCHAR(50))  DTTOTALHRSCALC
      , 0 FORCENEWRECORD
      , cast(null as VARCHAR(50))  RECORDSRCID
      , cast(null as VARCHAR(50))  ERRORNUMBER
      , cast(null as VARCHAR(50))  ERRORDESC
      , cast(null as VARCHAR(50))  OUTCOME
      , current_timestamp() WHLOADDATEUTC      
  FROM DWNT_FDC 
