# FDC Knowledge Hub

This directory contains governed reusable knowledge produced by investigations.

## Lifecycle directories

- candidates/: extracted knowledge that has not passed verification gates.
- verified/: bounded facts, contracts, mechanisms, and diagnostic patterns.
- operational/: verified playbooks with demonstrated effectiveness.
- superseded/: retained historical knowledge replaced by a newer valid entry.

Entries use the schema in schemas/knowledge-entry.schema.json and the template in assets/knowledge-entry-template.yaml.

## Rules

- One atomic claim per entry.
- Never duplicate an existing claim and scope.
- Reinforcing evidence updates the existing entry.
- Contradictions remain visible until resolved.
- Verified knowledge is always bounded by environment, date, version, and evidence.
- Operational knowledge requires a passed controlled validation.
- Source files remain unchanged under source-material/.
