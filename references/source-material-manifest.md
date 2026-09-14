# Source material manifest

## Ingestion state

Commit 8cb5deb9b415509cfbf9c48190d5b680f005f455 added 30 original text-readable technical files under source-material/.

Inventory:

- 18 SQL files;
- 5 JSON files;
- 3 Python files;
- 2 text files;
- 1 YAML file;
- 1 HTML process map.

All 30 files were readable through the repository connection. No obvious private-key, password-assignment, API-key, token-assignment, or AWS access-key patterns were detected by the initial heuristic scan. This is not a substitute for organizational secret scanning.

## Validation findings

- source-material/dec_fdc_tsk_raw_downtime_master_truncate.json is not valid JSON because the tags array contains the unexpected character in: "SP",x.
- source-material/stg_fdc_stg_dwntime_merge .sql and source-material/stg_fdc_stg_dwntime_merge.sql are different versions, not identical duplicates.
- The version without the extra space contains DTCOMMENT handling and additional VISIT_ASSET_UID and VISIT_ASSET_DATE output.
- Preserve both versions until active-code or deployment evidence identifies their exact chronology and status.
- Original files must not be silently corrected. Store a corrected or active version as a separate sourced artifact with provenance.

## Current coverage

The uploaded set strongly supports:

- Downtime Master;
- Downtime Exceptions;
- FDC Downtime reverse ETL;
- IMP_PDMASDOWNTIME;
- related Visit Site, Visit Asset, and Visit Metric processing;
- overhaul stored procedures;
- Airflow/dbt orchestration;
- Downtime-related Historian publication.

It does not yet provide equally deep source coverage for Routes, Users, Mobile Sync, Carry Forward, general Historian pipelines, or every FDC API and client path. The skill must learn those domains from future Jira investigations and engineer-validated evidence through the controlled lifecycle.

## Ingestion procedure

1. Preserve the original under source-material/<domain>/.
2. Record commit SHA, original path, source system, environment, and date.
3. Scan for secrets and unnecessary PII.
4. Parse or validate the file format without altering the original.
5. Extract atomic knowledge candidates.
6. Apply novelty, evidence, conflict, scope, utility, and safety gates.
7. Update the Knowledge Hub through a reviewed branch or pull request.
8. Re-run affected evaluations.
