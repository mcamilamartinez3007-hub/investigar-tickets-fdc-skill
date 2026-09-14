# investigate-fdc-tickets skill

Reusable skill for investigating FDC tickets through traceable evidence, lineage reconstruction, and strict separation of facts, hypotheses, and unknowns.

## What it does

- Continues existing investigations without restarting.
- Reconstructs flows across FDC App/Web/Mobile, APIs, SQL Server, Airflow, dbt, Snowflake, PostgreSQL/Timescale, Enertia, and Historian.
- Finds the first demonstrable deviation.
- Separates mitigation, recovery, immediate fixes, cleanup, and stabilization.
- Produces technical evidence and client-ready English communication.

## Usage

Recommended invocation:

$investigate-fdc-tickets FDCSD-XYZ

The skill should also activate for equivalent requests in English or Spanish, including:

- Investigate this FDC ticket.
- Continue the FDCSD-428 analysis.
- Investiga este ticket FDC.
- Continúa el análisis del 428.
- Compare this result with the previous handoff.
- Prepare the UAT validation.
- Determine whether the defect belongs to Data, App/API, or the client.

## Structure

- SKILL.md: runtime behavior and activation rules.
- AGENTS.md: maintenance instructions for agents working on this repository.
- references/: modular technical knowledge, governance, ownership, and known cases.
- assets/: investigation and communication templates.
- evals/: behavioral evaluation cases.
- source-material/: immutable original evidence after safe ingestion.

## Safety

The skill analyzes and recommends. It does not write to Jira, execute SQL, promote changes, or modify systems without a separate explicit user request.

## Status

Version 1.0.1. The initial knowledge base contains consolidated findings. Original technical files should be added to source-material/ to improve line-level traceability without rewriting the methodology.
