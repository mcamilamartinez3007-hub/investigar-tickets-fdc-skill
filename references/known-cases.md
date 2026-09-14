# Known cases and guardrails

## FDCSD-428

Currently confirmed:

- DOWNTIME_MASTER is rebuilt from Enertia.
- A null FDCUpdateID is intentional for records originating in Enertia.
- Staging attempts to reuse identity through MST.FDCUpdateID = DT.DOWNTIME_UID.
- Identity construction uses COALESCE(FDCUpdateID, DT.DOWNTIME_UID, UUID_STRING()).
- When FDCUpdateID is null and the join cannot resolve a previous identity, a new DOWNTIME_UID may be generated.
- The alternative functional matching logic was found commented out.
- Usp_Inactivate_OldDwntmRecords and Usp_Delete_OldDwntmRecords operate on FDC_VISIT_METRIC for MTR052/MTR085/MTR051, not on FDC_DOWNTIME.
- fdc_downtime_merge_reverse_etl runs after those procedures.
- Observed runtime: source FDC_STG_DOWNTIME_MERGE, target dbo.FDC_DOWNTIME, merge key DOWNTIME_UID, MATCHED UPDATE, and NOT MATCHED INSERT. No NOT MATCHED BY SOURCE delete or inactivation behavior was observed.
- One execution showed 52,324 source rows, zero updates, and 52,324 inserts.
- The observed population contained 27,575 logical events, 55,150 physical rows, 27,575 excess rows, and UID_COUNT = 2 for the affected groups.

Correct wording: null FDCUpdateID is not itself the root cause. The defect is the absence of idempotent identity resolution for that allowed scenario.

Do not claim infinite A+B+C+D accumulation. The cited evidence proves exactly two identities in that population.

## FDCSD-459

A distinct mechanism is confirmed:

- In JT's golden sample, a reason-only edit changed UID 6656592E... to 2885CA1E....
- The new UID appeared before CF, dbt, or Accordia.
- AssetMetricsViewModel contains InvalidateAndCreateDowntimeRecord(), which invalidates the previous version, clones it, and uses Guid.NewGuid().
- Associated metrics may also receive new GUIDs.

Interpretation: FDCSD-459 concerns identity and versioning created inside FDC client/core.

Possible but unconfirmed interaction: App/Web UID A → UID B → Enertia round trip → Data UID C. Trace the golden sample end to end before declaring this chain.

## FDCSD-458

Keep it separate:

- Scope: LASTUPDATED, LAST_UPDATE, and timestamp/version propagation.
- Systemic temporal representation differences exist.
- The evidence does not prove that those differences cause re-surfacing in the external exception service.

Do not conclude without new evidence:

- FDCSD-458 equals FDCSD-428;
- FDCSD-458 equals FDCSD-459;
- timestamp difference causes retrigger;
- timezone is the cause.

## Historical relationship: FDCSD-183 and the 2025 Overhaul

FDCSD-183 proposed canonical identity, DOWNTIME_ID, reconciliation, Enertia priority, an outbound ledger, exceptions, and client/DTO changes.

The 2025 Overhaul evolved toward authoritative Enertia state, VW_DOWNTIME_ALL, rolling six months plus older open records, a freshness gate, metric inactivation/deletion, reload from Enertia, and split orchestration.

Do not treat the overhaul as a literal implementation of FDCSD-183. It pursues consistency but replaces much of the canonical-identity approach with an authoritative refresh model. The 2026 finding is that the intended replacement semantics were not fully reflected in FDC_DOWNTIME, where UID-based upsert behavior remained.
