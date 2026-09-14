# FDC architecture and lineage

This is an initial reference map. Every ticket must verify active objects, environments, schedules, and contracts.

## Common layers

1. FDC App/Web/Mobile/Core creates or changes user-facing state and identity.
2. APIs and SQL Server persist or expose FDC objects.
3. Outbound integrations publish changes to external systems.
4. Enertia is authoritative for processes whose current contract defines it as such, including the Downtime target state under the overhaul.
5. Airflow orchestrates windows, dependencies, freshness checks, and reverse ETL.
6. dbt and Snowflake transform, compare, consolidate, and publish data.
7. PostgreSQL/Timescale and Historian participate in telemetry and downstream consumption.
8. Warehouse API exposes processed outputs to FDC interfaces, including Downtime Exceptions.
9. Interfaces and users validate the final functional behavior.

## Analysis rules

- A shared table does not prove a shared RCA.
- A shared DAG does not prove a shared RCA.
- Similar timestamps do not prove a shared RCA.
- A count difference does not imply data loss when grain changes.
- Compare dynamic views with static mirrors only within compatible load windows.
- Anchor critical schedules to UTC, then translate to the operational timezone and validate DST.
- Full refresh, incremental, append, upsert, and replacement have different contracts.
- A consumer may filter, cache, or reinterpret an otherwise correct upstream output.

## Boundary record

At each boundary, preserve:

- producing system;
- producing object;
- key or UID;
- candidate business key;
- grain;
- business fields;
- audit metadata;
- transformation;
- run or snapshot;
- consuming system;
- expected contract.

## Direction and ownership

Do not assume Data owns every layer. A deviation that already exists before Accordia initially points to App/API/Core. A deviation created in dbt points to the data pipeline. A correct output that fails in the consumer requires API/App/Web validation. An undefined functional rule must return to the business owner for a decision.
