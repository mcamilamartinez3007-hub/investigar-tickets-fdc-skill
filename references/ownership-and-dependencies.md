# Ownership y dependencias

Los nombres de personas son temporales. Razonar por rol y verificar owners cuando afecten el siguiente paso.

| Rol/capa | Responsabilidad típica | Entrega | Dependencias |
|---|---|---|---|
| Equipo de datos | Lineage, SQL/dbt/Airflow, primera desviación, cambios DEV, validaciones y RCA | Evidencia, queries, fix y plan | Accesos, runtime, requerimiento y ventanas |
| FDC App/Web/API/Core | Identidad del cliente, sync, cache, DTOs, endpoints y builds | Fix de aplicación/API y builds | Release, contrato API y testers |
| DEC/negocio | Comportamiento esperado y realidad operacional | Decisión funcional, UAT y aceptación | Testers, permisos y ventanas |
| Enertia | Estado autoritativo donde esté definido | Estado/correcciones operacionales | Extractos, vistas y publicación |
| Accordia/Airflow/dbt | Orquestación, transformación y publicación | Runs, modelos, logs y salidas | Freshness, fuentes y destinos |
| Snowflake/TSDB | Persistencia analítica e integración | Datos y contratos de salida | Grano, refresh y permisos |
| Historian | Consumo operacional especializado | Validación downstream | Integración y aceptación |
| Warehouse API | Exposición de salidas a interfaces | Respuesta de servicio | Tablas terminales y contrato |
| Ingeniero | Ejecuta acciones autorizadas y comunica | Cambios y evidencias | Recomendaciones de la skill |
| Skill | Analiza y recomienda | Diagnóstico y siguiente acción | Lectura de evidencia |

## Dependencias a verificar

- fuente disponible y fresca;
- orden y horario de DAGs;
- UTC, zona local y DST;
- full refresh vs incremental;
- grano origen/destino;
- propiedad de objetos;
- release App/Web/API;
- usuarios/dispositivos de prueba;
- ventana UAT/PROD;
- aprobación funcional;
- cleanup/backfill;
- consumidores downstream;
- monitoreo y recovery;
- tickets absorbidos, relacionados o reemplazados.

## RACI mínimo por cambio

Registrar owner técnico, owner funcional, desarrollador, ejecutor, validador, aprobador, informados, ambiente, permisos, ventana y escalamiento. Si no se conoce, marcar UNKNOWN y pedir confirmación sólo si bloquea la siguiente acción.
