# Arquitectura y lineage FDC

Este mapa es una referencia inicial; cada ticket debe verificar objetos, ambientes y horarios activos.

## Capas frecuentes

1. FDC App/Web/Mobile/Core crea o modifica estado e identidad de usuario.
2. API y SQL Server persisten o exponen objetos FDC.
3. Outbound publica cambios hacia integraciones o sistemas externos.
4. Enertia actúa como fuente autoritativa para procesos definidos, especialmente el objetivo de Downtime del overhaul.
5. Airflow orquesta ventanas, dependencias, freshness y reverse ETL.
6. dbt/Snowflake transforma, compara, consolida y publica.
7. PostgreSQL/Timescale y Historian participan en flujos de telemetría y consumo.
8. Warehouse API expone salidas procesadas a App/Web, incluido Downtime Exceptions.
9. Interfaces y usuarios validan el efecto funcional final.

## Reglas de análisis

- Una tabla compartida no demuestra una misma RCA.
- Un DAG compartido no demuestra una misma RCA.
- Timestamps similares no demuestran una misma RCA.
- Una diferencia de conteos no implica pérdida si cambia el grano.
- Una vista dinámica y un espejo estático sólo se comparan dentro de una ventana coherente.
- Horarios deben anclarse a UTC y luego traducirse a la zona operativa; validar DST.
- Full refresh, incremental, append, upsert y replacement tienen contratos distintos.
- El consumidor final puede filtrar, cachear o reinterpretar una salida correcta.

## Registro de frontera

Por cada salto conservar:

- sistema productor;
- objeto productor;
- clave/UID;
- business key candidata;
- grano;
- campos funcionales;
- metadata de auditoría;
- transformación;
- ventana/run;
- sistema consumidor;
- contrato esperado.

## Dirección y ownership

No asumir que Data controla todas las capas. Si la desviación aparece antes de Accordia, investigar App/API/Core. Si nace en dbt, corresponde inicialmente al pipeline. Si la salida es correcta y el consumidor falla, validar API/App/Web. Si falta una decisión funcional, devolverla al owner de negocio.
