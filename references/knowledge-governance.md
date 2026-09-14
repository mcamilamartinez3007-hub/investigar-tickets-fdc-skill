# Knowledge governance

## Objective

Maintain a compact, traceable, conflict-aware Knowledge Hub that improves future investigations without treating volume as quality.

The complete ingestion and promotion lifecycle is defined in references/continuous-learning.md.

## Required metadata

Every entry must record:

- knowledge_id;
- title;
- domain;
- component;
- knowledge_type;
- lifecycle_status;
- claim;
- fingerprint;
- source tickets;
- source references;
- date observed;
- environment;
- version scope;
- affected objects;
- evidence;
- confidence;
- validity;
- applicability and exclusions;
- conflict status;
- validation;
- reuse guidance;
- security review;
- related, superseded, and superseding entries;
- revalidation policy.

## Lifecycle states

- candidate: extracted but not trusted as fact.
- provisional: supported enough to guide an explicit hypothesis.
- verified: proven within a bounded scope.
- operational: verified remediation or diagnostic playbook with effectiveness evidence.
- conflict_pending: incompatible with another applicable entry.
- superseded: replaced while retained for history.
- rejected: false, unsafe, non-reusable, or unsupported.

## Knowledge layers

- Method: universal investigation behavior.
- Contract: source-of-truth, grain, identity, interface, or timing rules.
- Domain: reusable component and flow knowledge.
- Case: ticket-specific evidence and RCA.
- Playbook: validated diagnosis, recovery, or remediation.
- Negative knowledge: disproved hypotheses and failed remediations.

Do not promote a case-specific observation into a universal contract.

## Authority rules

Memory and chat help locate evidence; they do not independently verify it. Jira supplies history and attributable decisions, but its status does not prove implementation. Active runtime, data, code, configuration, and controlled validation have the strongest technical authority.

## Change policy

- Add new evidence to an existing entry when the claim and scope match.
- Create a linked extension only when scope materially changes future decisions.
- Preserve contradictions until a discriminating validation resolves them.
- Preserve superseded knowledge for historical diagnosis.
- Never silently rewrite the claim of a verified or operational entry.
- Re-review downstream entries when a contract they depend on changes.

## Quality controls

Before persistence:

1. schema validation;
2. exact ID and fingerprint collision check;
3. semantic novelty classification;
4. evidence gate;
5. scope and applicability review;
6. contradiction review;
7. utility gate;
8. secret and PII scan;
9. broken-reference check;
10. promotion decision.

Run scripts/validate_knowledge.py for mechanical checks. Human or agent reasoning is still required for semantic equivalence and causal quality.

## Repository policy

Automated learning writes to a branch or pull request, never directly to main. Promotion requires explicit review or a previously authorized governed workflow. Source evidence remains unchanged under source-material/.
