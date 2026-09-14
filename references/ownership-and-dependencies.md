# Ownership and dependencies

People change. Reason by role and revalidate named owners whenever ownership affects the next action.

| Role or layer | Typical responsibility | Deliverable | Dependencies |
|---|---|---|---|
| Data team | Lineage, SQL/dbt/Airflow, first deviation, DEV changes, validation, and RCA | Evidence, queries, fix, and plan | Access, runtime, requirements, and windows |
| FDC App/Web/API/Core | Client identity, sync, cache, DTOs, endpoints, and builds | Application/API fix and builds | Release, API contract, and testers |
| DEC or business | Expected behavior and operational reality | Functional decision, UAT, and acceptance | Testers, permissions, and windows |
| Enertia | Authoritative state where defined | Operational state and corrections | Extracts, views, and publication |
| Accordia/Airflow/dbt | Orchestration, transformation, and publication | Runs, models, logs, and outputs | Freshness, sources, and targets |
| Snowflake/TSDB | Analytical and integration persistence | Data and output contracts | Grain, refresh, and permissions |
| Historian | Specialized operational consumption | Downstream validation | Integration and owner acceptance |
| Warehouse API | Output exposure to interfaces | Service response | Terminal tables and API contract |
| Engineer | Performs authorized actions and communicates | Changes and evidence | Skill recommendations |
| Skill | Analyzes and recommends | Diagnosis and next action | Read-only evidence |

## Dependencies to verify

- source availability and freshness;
- DAG order and schedules;
- UTC, local timezone, and DST;
- full refresh versus incremental behavior;
- source and target grain;
- object ownership;
- App/Web/API release;
- test users and devices;
- UAT or production window;
- functional approval;
- cleanup or backfill;
- downstream consumers;
- monitoring and recovery;
- related, absorbed, or superseded tickets.

## Minimum RACI

Record technical owner, functional owner, developer, executor, validator, approver, informed parties, environment, permissions, window, and escalation route. Mark missing information UNKNOWN and request it only when it blocks the next action.
