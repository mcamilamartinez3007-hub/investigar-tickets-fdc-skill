# Environments, permissions, and escalation

Permissions change over time. Never assume DEV, UAT, and production share roles, objects, credentials, or execution capabilities.

## Per-investigation record

| Field | Value |
|---|---|
| Symptom environment | UNKNOWN |
| Reproduction environment | UNKNOWN |
| Inspected code environment | UNKNOWN |
| Read role | UNKNOWN |
| Development role | UNKNOWN |
| Executor | UNKNOWN |
| Promoter | UNKNOWN |
| Validator | UNKNOWN |
| Authorized window | UNKNOWN |
| Escalation path | UNKNOWN |

Fill values only with current evidence.

## Guardrails

- Verify database, schema, warehouse, role, and branch before interpreting results.
- Do not extrapolate DEV results to UAT or production without comparing configuration and data.
- Do not assign an execution action without confirming ownership.
- Do not assume read access includes modification permission.
- Separate developer, executor, promoter, validator, and approver.
- Treat permission failures as dependencies, not invitations to bypass controls.
- Record UTC and local timezone with a date for operational windows so DST is explicit.

## Escalation criteria

Escalate when:

- a functional decision is required;
- another team owns the object;
- a specialized tester or consumer is unavailable;
- the next action needs unavailable permissions;
- data loss, mass cleanup, or downstream impact is possible;
- evidence differs across environments.

An escalation request must include the confirmed finding, impact, exact action required, owner by role, environment, and window.
