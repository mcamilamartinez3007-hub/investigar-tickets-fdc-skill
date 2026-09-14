# Downtime contracts and validation

## Mandatory separation

- IDENTITY: which logical event this is.
- BUSINESS STATE: begin, end, reason, and status.
- VERSION: which technical representation or version is being observed.
- AUDIT: creation, last update, load, and synchronization metadata.

Audit metadata must not independently create a new identity or represent a business change.

## Target architecture reference

- DOWNTIME_ID: stable canonical identity.
- DOWNTIME_UID: representation-, version-, or source-specific identity.
- Begin/End/Reason/Status: functional state.
- Creation/LastUpdated/Load/Sync: audit metadata.

## Duplicate investigation

Capture at least:

- logical event;
- source UID;
- FDC UID;
- Enertia HID/TID;
- metric UIDs;
- creation timestamp;
- last-update timestamp;
- source system;
- run or snapshot.

Do not use ASSET_UID + BEGIN_DATETIME as a permanent identity without proving uniqueness and stability. Begin may change, and multiple legitimate events may exist.

## Idempotent fix requirements

Before recommending code, answer:

- Which contract is broken?
- What historical data exists?
- Which legitimate cases could the fix collapse?
- Does it work under retry and replay?
- What happens with zero, one, or multiple candidates?
- What happens with stale input, authoritative correction, or a partial run?

Primary criterion:

same logical input twice → zero new identities

## Minimum test suite

- create;
- reason edit;
- begin edit;
- end or close;
- reopen;
- delete;
- two events on the same day;
- overlap;
- open sentinel;
- retry;
- same input twice;
- FDC pending and not yet present in Enertia;
- authoritative Enertia correction;
- stale source;
- failed run;
- partial run;
- multiple candidates;
- historical orphan;
- audit-only timestamp change.

## Historical cleanup

Required order:

1. Stop new corruption.
2. Define the canonical identity and version contract.
3. Build lineage and crosswalk.
4. Classify historical populations.
5. Repoint dependencies.
6. Inactivate surplus representations.
7. Validate consumers.
8. Physically delete only when required.

Categories: technical duplicate, legitimate event, FDC version, Enertia version, mixed lineage, partial event, and ambiguous. Never auto-deduplicate ambiguous records.

## Stabilization target

Canonical DOWNTIME_ID + persistent source crosswalk + authoritative Enertia state + FDC outbound ledger + semantic change detection + idempotent inbound reconciliation + atomic snapshot publication + metrics as projection + ambiguity to exception + lineage-aware cleanup.
