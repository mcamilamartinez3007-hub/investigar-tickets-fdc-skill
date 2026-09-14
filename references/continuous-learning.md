# Continuous learning and knowledge promotion

## Purpose

The skill must become stronger through completed investigations without turning Jira, chat history, or engineer opinions into an unreviewed fact store.

Learning is a controlled pipeline:

investigation evidence → candidate extraction → novelty evaluation → evidence evaluation → conflict analysis → scope definition → utility evaluation → promotion decision → reviewed persistence

The goal is not to collect everything. The goal is to preserve the smallest set of high-value knowledge that materially improves future diagnosis.

## What is worth learning

Create a candidate only when the finding is reusable beyond the current status update. Eligible types:

- SYSTEM_CONTRACT: source of truth, direction, grain, identity, timing, or interface contract.
- FAILURE_MECHANISM: a demonstrated way the system produces an incorrect outcome.
- DIAGNOSTIC_PATTERN: a discriminating test or evidence pattern that narrows a defect class.
- OPERATIONAL_PLAYBOOK: a remediation or recovery sequence proven in a bounded scope.
- OWNERSHIP_RULE: which role owns, executes, validates, or approves a boundary.
- ENVIRONMENT_RULE: a confirmed environment-specific difference.
- BUSINESS_RULE: a current and attributable functional decision.
- HISTORICAL_DECISION: an earlier design that explains behavior but may not remain active.
- NEGATIVE_KNOWLEDGE: a plausible hypothesis that evidence disproved and the conditions of that disproof.

Do not create entries for routine ticket narration, personal names without durable role value, meeting logistics, speculative causes, one-time counts without diagnostic value, or content already represented.

## Ingestion triggers

Run knowledge harvest when any of these occurs:

- the first demonstrable deviation is identified;
- an RCA is closed;
- a hypothesis is materially disproved;
- an environment difference is confirmed;
- a fix passes or fails controlled validation;
- an owner makes a durable functional decision;
- a ticket is absorbed by another and technical continuity must be preserved;
- a repeated investigation reveals the same mechanism;
- a new source changes or supersedes an existing contract.

Jira searches and engineer conversations may trigger extraction, but not automatic verification.

## Candidate construction

Use assets/knowledge-entry-template.yaml and schemas/knowledge-entry.schema.json.

A candidate must be atomic: one claim, one bounded scope, one primary knowledge type. Split combined claims when they can change independently.

Every candidate requires:

- stable knowledge_id;
- normalized fingerprint;
- human-readable claim;
- ticket and source references;
- date and environment;
- affected systems and objects;
- evidence items;
- validity and confidence;
- applicability boundaries;
- conflict assessment;
- reusable decision or action;
- validation status;
- security review.

## Stable fingerprint

Build the fingerprint from normalized semantic components:

domain | component | knowledge_type | subject | mechanism_or_contract | environment_scope | version_scope

Do not fingerprint volatile values such as timestamps, usernames, row counts, ticket status, or wording.

A fingerprint is a duplicate detector, not proof of semantic equivalence.

## Novelty gate

Compare the candidate with:

1. exact knowledge_id;
2. exact fingerprint;
3. same domain, component, knowledge type, and affected objects;
4. semantically equivalent claim;
5. same mechanism with different scope;
6. contradictory outcome under overlapping scope.

Assign exactly one relationship:

- NEW: no material existing equivalent.
- DUPLICATE: same claim, scope, and mechanism; do not create another entry.
- REINFORCES: same claim and scope with additional evidence; update evidence only.
- EXTENDS: same mechanism with broader or additional bounded scope; update or create a linked extension.
- CONTRADICTS: incompatible claims with overlapping scope; keep both quarantined from automatic use until resolved.
- SUPERSEDES: a newer valid contract or implementation replaces the old one; preserve history and link both directions.

When uncertain between DUPLICATE and EXTENDS, prefer EXTENDS only if the new boundary changes a future diagnostic decision.

## Evidence classes

- E1_RUNTIME: runtime result or log tied to a run, environment, and window.
- E2_DATA: reproducible data evidence with query or snapshot context.
- E3_ACTIVE_CODE: active code tied to branch, commit, release, or deployment.
- E4_ACTIVE_CONFIG: active configuration tied to environment and version.
- E5_CONTROLLED_VALIDATION: documented test with baseline, action, expected result, actual result, and outcome.
- E6_BUSINESS_DECISION: attributable current decision from the functional owner.
- E7_ENGINEER_CONFIRMATION: attributable technical confirmation with role, environment, test case, and artifact.
- E8_JIRA_HISTORY: ticket description, comment, attachment, or workflow history.
- E9_DESIGN_DOC: intended architecture or specification.
- E10_MEMORY: chat memory or recollection used only for discovery.

Jira status is administrative metadata, not evidence of deployment or correctness.

## Promotion gates

### Candidate

Default state for extracted knowledge. May guide what to validate, but must not be presented as fact.

Requirements:

- atomic claim;
- provenance;
- bounded preliminary scope;
- no obvious secret or unnecessary PII.

### Provisional

May guide investigation as a hypothesis with visible caveats.

Requirements:

- at least one evidence item from E1 through E7;
- no unresolved direct contradiction;
- reproducible next validation;
- confidence and limitations recorded.

### Verified

May be used as a fact within its stated scope.

A system fact or contract requires either:

- one direct active source from E1 through E4 plus a consistent independent source; or
- a controlled validation E5 that directly demonstrates the claim.

A causal mechanism additionally requires:

- symptom;
- first deviation;
- active mechanism;
- observed output consistent with that mechanism;
- competing hypotheses addressed.

Engineer confirmation qualifies only when it records role, environment, exact case, observed result, date, and evidence artifact. “The engineer confirmed it” is insufficient.

### Operational

May be recommended as a reusable remediation or playbook.

Requirements:

- VERIFIED underlying mechanism;
- exact preconditions and excluded cases;
- successful E5 validation in the intended environment;
- retry or replay behavior when relevant;
- regression and downstream checks;
- rollback or recovery boundary;
- no unresolved safety or data-loss concern;
- named owner role for execution and validation.

A fix that merely looks correct in code cannot be OPERATIONAL.

## About “100% verified”

No knowledge system can honestly guarantee universal truth. This skill enforces bounded verification instead:

- what was proven;
- where;
- when;
- against which version;
- by which evidence;
- under which conditions;
- what remains excluded or unknown.

The strongest reusable statement is not “always true.” It is “verified for this explicit scope and invalidated when the scope changes.”

## Conflict gate

When a candidate contradicts current knowledge:

1. Do not overwrite either claim.
2. Determine whether environment, date, version, grain, or source authority explains the difference.
3. Mark both entries conflict_pending.
4. Design the smallest discriminating validation.
5. Resolve as scope_split, superseded, source_error, implementation_drift, or still_unresolved.
6. Record the resolution evidence.

Unresolved contradictory knowledge must not drive an automatic remediation.

## Utility gate

Promote only knowledge that changes a future decision. Score each dimension from 0 to 2:

- recurrence: likely to appear again;
- discrimination: narrows the search space;
- actionability: changes a query, owner, fix, or validation;
- blast-radius awareness: prevents harmful generalization;
- transferability: useful beyond a single ticket.

A total below 5 remains in the ticket or candidate archive unless it prevents a high-severity mistake.

Scores prioritize review. They never replace evidence gates.

## Safety and privacy gate

Reject or sanitize entries containing:

- credentials, tokens, passwords, or private keys;
- unnecessary personal data;
- private meeting links;
- production connection strings;
- raw customer data not required for the reusable claim;
- destructive instructions without preconditions, validation, and recovery.

Preserve roles rather than names when ownership is durable.

## Persistence modes

### Default mode

Produce a Knowledge Update Proposal in the investigation output. Do not write externally.

### Authorized managed mode

When the user has explicitly authorized repository updates:

1. write candidates to a dedicated branch;
2. run schema, duplicate, conflict, and secret checks;
3. create a pull request or present the diff;
4. require review for promotion;
5. never push unreviewed ingestion directly to main.

A standing automation may collect candidates, but promotion still requires the defined gates.

## Feedback loop

A knowledge entry is not permanent truth. Re-evaluate it when:

- active code or configuration changes;
- a newer ticket contradicts it;
- validation fails;
- the authoritative system changes;
- its revalidation date expires;
- the same playbook produces a different outcome.

Failed remediation is valuable negative knowledge. Downgrade the entry, record the failure conditions, and block automatic reuse until resolved.

## End-of-investigation decision

Every material investigation ends with one of:

- NO_KNOWLEDGE_UPDATE: nothing reusable.
- UPDATE_EXISTING: duplicate or reinforcing evidence.
- CREATE_CANDIDATE: useful but not verified.
- PROMOTE_VERIFIED: evidence gates passed.
- PROMOTE_OPERATIONAL: effectiveness gates passed.
- RECORD_CONTRADICTION: conflict requires resolution.
- SUPERSEDE: a newer valid rule replaces an older one.
