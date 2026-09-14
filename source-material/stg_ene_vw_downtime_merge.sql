with MAX_ENE AS
  (
    select HDRTYPECODE, HDRCODE, to_timestamp(DTBEGINDATETIME) DTBEGINDATETIME, max(TO_TIMESTAMP(LASTUPDATED)) LASTUPDATED
    from {{ source('enertia', 'vw_downtime_all') }}
    group by HDRTYPECODE, HDRCODE, to_timestamp(DTBEGINDATETIME)
  )
  SELECT HDRTYPECLASS,
      ENE.HDRTYPECODE,
      TRIM(ENE.HDRCODE) ASSETCODE,
      HDRNAME ASSETNAME,
      DOWNTIMETID,
      DOWNTIMEHID,
      DTPRODDAYSTART,
      TRIM(DTREASON) DTREASON,
      DTREASONDESC,
      to_timestamp(ENE.DTBEGINDATETIME) DTBEGINDATETIME,
     /* CASE WHEN TO_DATE(DTENDDATETIME)='2078-12-31' THEN NULL 
      WHEN DATEDIFF('hour', to_timestamp(ENE.DTBEGINDATETIME), to_timestamp(DTENDDATETIME))=24 THEN DATEADD(SECOND, -1, to_timestamp(DTENDDATETIME))
      ELSE to_timestamp(DTENDDATETIME) END DTENDDATETIME,*/
      CASE WHEN TO_DATE(DTENDDATETIME)='2078-12-31' THEN NULL 
      WHEN DATEDIFF('hour', to_timestamp(ENE.DTENDDATETIME), to_timestamp(  lead(ene.dtbegindatetime) over (partition by assetcode order by  ene.dtbegindatetime )))=0 THEN 
      DATEADD(SECOND, -1, to_timestamp(DTENDDATETIME))
      ELSE to_timestamp(DTENDDATETIME) END DTENDDATETIME,
      DTTOTALHRS,
      null OPERATOR_UID,
      DTREMARKS,
      'SL-ERP' SOURCESYSTEM,
      RECORDSRCTID,
      DTENTRYDATETIME,
      LASTUPDATEID,
      convert_timezone( 'America/New_York' , 'UTC',  TO_TIMESTAMP(ENE.LASTUPDATED))::timestamp_ntz  LASTUPDATED,
      convert_timezone( 'America/Los_Angeles' , 'UTC', current_timestamp())::timestamp_ntz  WHLOADDATEUTC
  FROM {{ source('enertia', 'vw_downtime_all') }} ENE
  INNER JOIN MAX_ENE ON ENE.HDRTYPECODE = MAX_ENE.HDRTYPECODE AND ENE.HDRCODE = MAX_ENE.HDRCODE AND to_timestamp(ENE.DTBEGINDATETIME) = MAX_ENE.DTBEGINDATETIME AND  TO_TIMESTAMP(ENE.LASTUPDATED) = MAX_ENE.LASTUPDATED 
  WHERE    --  1: OPEN Downtimes
  TO_DATE(ENE.DTENDDATETIME) = '2078-12-31'
  OR
  --  2: Closed Downtimes WHERE end date >6 months
    (TO_DATE(ENE.DTENDDATETIME) <> '2078-12-31' 
     AND to_timestamp(ENE.DTBEGINDATETIME) > dateadd(month, -6, current_date()))
    OR
    -- 3: End dates >6 months (Pull reason and start regardless of age)
    (TO_DATE(ENE.DTENDDATETIME) <> '2078-12-31' 
     AND to_timestamp(ENE.DTENDDATETIME) > dateadd(month, -6, current_date()))