# Consolidated FDC knowledge for this skill

This reference preserves the requirements used to organize investigate-fdc-tickets. It is derived from prior work and must be checked against active sources whenever environment, version, or date changes.

## Core rules

1. Context first: read attachments, handoffs, reports, logs, code, and previous results before asking.
2. Follow symptom → actual flow → first deviation → mechanism → cause → impact → fix → stabilization.
3. Separate CONFIRMED, HYPOTHESIS, UNKNOWN, and NEXT VALIDATION.
4. Prioritize runtime, data, active code, and active configuration over historical narrative.
5. First answer where the symptom appears, who created it, which identity it had, and what the next layer expected.
6. Investigate identity before deduplication.
7. Separate identity, business state, version, and audit.
8. Do not use audit metadata as identity or a business change.
9. Keep FDCSD-428, FDCSD-458, and FDCSD-459 separate.
10. Do not treat the 2025 Overhaul as a literal implementation of FDCSD-183.
11. Produce an immediate fix and stabilization plan when the mechanism is systemic.
12. Validate idempotency, retry, replay, and ambiguity.
13. Stop new corruption before historical cleanup.
14. Always deliver symptom, expectation, flow, facts, discarded hypotheses, questions, cause or best mechanism, impact, options, recommendation, risks, validation, evidence, and next action.

## FDCSD-428

A null FDCUpdateID is allowed for Enertia records. The consolidated defect is not the null itself. It is the lack of idempotent identity resolution when that field cannot reuse DOWNTIME_UID. The observed merge uses DOWNTIME_UID as its key and inserts unmatched rows. The cited overhaul procedures operate on metrics and do not clean FDC_DOWNTIME. The measured population showed pairs, not proven infinite accumulation.

## FDCSD-459

In the golden sample, a reason edit produced a new UID before the data pipeline. Client/core code invalidates the earlier version, clones it, and generates a GUID. This is FDC client/core versioning and does not automatically share the FDCSD-428 RCA.

## FDCSD-458

This case concerns timestamp and version propagation. Observed timestamp differences do not independently prove retrigger, timezone causation, or equivalence with FDCSD-428 or FDCSD-459.

## Stabilization target

Canonical identity, persistent crosswalk, authoritative Enertia state, FDC outbound ledger, semantic change detection, idempotent inbound reconciliation, atomic publication, metrics as projection, ambiguity routed to exceptions, and lineage-aware cleanup.

## Continuity

When invoked for FDCSD-XYZ, recover available evidence and continue from the last uncertainty. Do not request SQL, files, tickets, repositories, DAGs, screenshots, or validations that are already available.
