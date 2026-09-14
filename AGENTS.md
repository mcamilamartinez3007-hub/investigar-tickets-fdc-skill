# Agent instructions

## Repository purpose

Maintain an operational skill for FDC investigations. SKILL.md defines runtime behavior, references/ contains modular knowledge, and source-material/ preserves original evidence.

## Before changing knowledge

1. Read SKILL.md and the relevant domain reference.
2. Confirm whether the original source already exists.
3. Separate evidence, interpretation, and hypothesis.
4. Verify date, environment, version, and validity.
5. Detect contradictions and superseded rules.
6. Remove secrets and unnecessary PII.

## Editing rules

- Keep SKILL.md compact and behavior-oriented.
- Do not place large source dumps inside SKILL.md.
- Do not rewrite files under source-material/.
- Add derived knowledge to references/.
- Update source-material-manifest.md and CHANGELOG.md.
- Add or adjust an evaluation for every new guardrail.
- Preserve valid history; mark it historical, superseded, or contradicted.
- Never claim documentary coverage that is not physically present in the repository.
- Keep all internal instructions, references, metadata, and templates in English.
- User invocation examples may remain multilingual when they test language handling.

## Minimum validation

- SKILL.md has valid name and description frontmatter.
- Every path referenced by SKILL.md exists.
- Evaluations cover the change.
- No secrets, tokens, or unnecessary personal data are present.
- Known cases distinguish evidence from inference.
- Read-only operating boundaries remain intact.
- Internal content is in English.

## Operations

This repository does not authorize writing to Jira, executing SQL, deploying, promoting, or modifying infrastructure. Every external action requires a separate explicit request from the user.

## Knowledge Hub maintenance

- Apply references/continuous-learning.md before creating or promoting an entry.
- Validate every entry against schemas/knowledge-entry.schema.json.
- Run scripts/validate_knowledge.py before proposing a knowledge commit.
- Prefer updating an existing entry when the new evidence reinforces or narrows it.
- Store unresolved candidates under knowledge/candidates/.
- Store verified facts and contracts under knowledge/verified/.
- Store proven troubleshooting or remediation patterns under knowledge/operational/.
- Move replaced knowledge to knowledge/superseded/ without destroying provenance.
- Never promote directly from a Jira status, an isolated comment, memory, or an unexecuted recommendation.
- Use a branch or pull request for automated ingestion. Do not let an ingestion workflow push unreviewed knowledge directly to main.
