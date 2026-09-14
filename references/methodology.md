# Investigation methodology

## 1. Frame the case

Record the ticket, symptom, environment, affected consumer, time window, impact, and functional expectation. Separate what the reporter stated from what direct evidence shows.

## 2. Recover existing work

Search available materials first. Build an evidence table with source, date, environment, observation, confidence, and validity. Do not rerun a test when an existing result still answers the question.

## 3. Build the minimum map

| Layer | Object or process | Grain | Identity | Time | Expected | Observed |
|---|---|---|---|---|---|---|

The first row where expected and observed behavior diverge determines where to investigate next.

## 4. Use discriminating tests

Choose the next test by its uncertainty-reduction value. Examples:

- Does the new UID exist before Accordia?
- Is the row present in the dynamic view but absent from the static mirror?
- Did the grain change between source and target?
- Does a second run with the same input create another identity?
- Does the difference appear only after Mobile synchronization?

State what YES and NO mean before executing or requesting the test.

## 5. Prove causality

Declare an RCA only when:

1. The mechanism exists in active code or configuration.
2. The case traversed that mechanism.
3. The mechanism output matches the observed deviation.
4. No alternative explanation has equal or stronger support.
5. A controlled validation can show that the fix removes the symptom.

Otherwise, use CURRENT BEST MECHANISM.

## 6. Separate solution types

- Mitigation: temporarily reduces impact.
- Recovery: restores operations or data.
- Immediate fix: repairs the ticket mechanism.
- Cleanup: classifies and repairs historical data.
- Stabilization: eliminates the defect class.
- Monitoring: detects recurrence or degradation.

Do not confuse cleanup with prevention. Stop new corruption first.

## 7. Validate

Every validation must state baseline, action, expected result, actual result, and evidence. Include retry, replay, repeated input, zero/one/multiple candidates, partial failure, and downstream consumers when relevant.

## 8. Close technically

Technical closure requires a demonstrated cause, known scope, verifiable fix, covered risks, and a named next-step owner. Jira status may differ from technical state.
