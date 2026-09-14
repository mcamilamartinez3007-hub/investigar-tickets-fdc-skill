# Changelog

## 0.2.0 - 2026-09-14

- Added a continuous-learning lifecycle for knowledge discovered through Jira and engineer-led validation.
- Added novelty, evidence, scope, conflict, safety, and operational-effectiveness gates.
- Added a structured Knowledge Hub with candidate, verified, operational, and superseded states.
- Added a machine-readable knowledge schema and a dependency-free validator.
- Added adversarial ingestion evaluations covering duplicates, contradictions, unsupported Jira claims, and failed fixes.
- Updated the source manifest to reflect the 30 ingested Downtime files and their validation findings.


## 1.0.1 - 2026-09-14

- Converted all internal skill instructions, references, templates, and metadata to English.
- Preserved the existing investigar-tickets-fdc identifier for invocation compatibility.
- Preserved multilingual user prompts only in usage and evaluation examples.
- Added an explicit internal-language validation rule.

## 1.0.0 - 2026-09-14

- Created the first operational version of the FDC investigation skill.
- Added context-first methodology and an evidence hierarchy.
- Added identity, audit, and grain contracts.
- Documented separate guardrails for FDCSD-428, FDCSD-458, and FDCSD-459.
- Added ownership, dependencies, sources of truth, permissions, and knowledge governance.
- Added investigation, Jira, UAT, and handoff templates.
- Added behavioral evaluations for continuity, causality, duplicates, and operational boundaries.
- Recorded that original technical source files were not physically present in the initial repository.
