# Source material manifest

## Repository state at version 1.0.1

The repository initially contained only README.md. Technical files discussed during earlier investigations were not physically available when the first skill version was built.

Therefore:

- Their content was not invented or reconstructed.
- Consolidated findings were documented as derived knowledge.
- Line-level traceability must be revalidated after original sources are added.
- source-material/ is reserved for unchanged originals.

## Mentioned but not yet incorporated sources

Known source categories include:

- downtime-process-maps.html;
- fdc_downtime_mrg.json;
- Usp_Delete_OldDwntmRecords;
- Usp_Inactivate_OldDwntmRecords;
- Downtime stg_pre_upsert models;
- DOWNTIME_MASTER and DOWNTIME_EXCEPTIONS models;
- orchestration manifests and jobs;
- historical handoffs for FDCSD-428, FDCSD-458, and FDCSD-459;
- AssetMetricsViewModel code related to versioning.

This list does not claim exact filenames or complete contents beyond the consolidated evidence.

## Ingestion procedure

1. Store files under source-material/<domain>/ without modification.
2. Add a SHA or commit reference.
3. Update this inventory.
4. Link derived facts.
5. Revalidate known-cases.md.
6. Run evals/evaluation-cases.yaml.
