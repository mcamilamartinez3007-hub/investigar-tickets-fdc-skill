# Source-of-truth registry

This registry is contextual, not universal.

| Domain or question | Initial priority source | Required confirmation |
|---|---|---|
| What actually happened | Runtime and logs | Run, environment, and window |
| Actual data contents | Affected-environment data | Dated snapshot or query |
| Implemented mechanism | Active code and configuration | Branch, version, or deployment |
| Functional expectation | Current business decision or Jira evidence | Owner and date |
| Downtime target state | Enertia when the active contract defines it | Specific flow and window |
| Identity created in client | FDC App/Web/Mobile/Core | Case observed before the pipeline |
| Exception publication | Accordia output and Warehouse API | Endpoint and consumer contract |
| Historian behavior | Historian pipeline and consumer | Owner acceptance |
| Delivery state | Implementation, validation, and deployment evidence | Never infer from Jira status |

## Temporal rule

Every claim needs an environment, date, and validity state. When historical material conflicts with current runtime, preserve both and mark the historical statement as superseded or scope-limited.

## Separate states

Track independently:

- administrative state;
- implementation state;
- validation state;
- deployment state;
- knowledge state;
- ticket where work continues.
