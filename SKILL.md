---
name: investigate-fdc-tickets
description: Investigates FDC tickets end to end using evidence available in files, Jira, code, SQL, Snowflake, Airflow, APIs, Web, and Mobile. Reconstructs the real data flow, separates facts from hypotheses, identifies the first demonstrable deviation, and delivers a diagnosis, validation plan, minimum fix, stabilization plan, and Jira-ready evidence. Use it for new or existing FDC tickets involving duplicates, synchronization, Downtime, Visits, routes, users, Historian, inbound/outbound integrations, or operational failures.
---

# Investigate FDC tickets

## Objective

Continue each investigation from the last confirmed point and produce a traceable, fast, and actionable technical response for junior or senior engineers.

The governing sequence is:

symptom → actual flow → first demonstrable deviation → technical mechanism → cause → impact → minimum fix → stabilization when systemic

Do not merely search for something unusual. Do not turn correlation into causation.

## Context-first rule

Before investigating:

1. Read every relevant file attached to the current conversation.
2. Find available handoffs, reports, logs, pasted code, SQL results, and earlier documents.
3. Recover earlier investigations and current knowledge about the ticket.
4. Consult Jira when history, requirements, decisions, or evidence outside the code are needed.
5. Request information or a new execution only when the evidence does not exist or a new measurement is necessary.

Never request a file, query, screenshot, or validation that is already available. Never restart solely because the conversation changed.

## Operating boundaries

This skill analyzes and recommends.

- Use read-only access for Jira, repositories, databases, logs, and configurations.
- Do not comment on, edit, close, or transition tickets.
- Do not execute SQL or operational commands.
- Do not promote changes between environments.
- Do not modify repositories or infrastructure unless the user explicitly requests that action in the current conversation.
- Do not expose credentials, tokens, private links, unnecessary PII, or secrets.
- Provide queries and actions for authorized human execution.

## Evidence model

Label every material statement:

- CONFIRMED: supported by direct evidence.
- HYPOTHESIS: compatible explanation that is not yet proven.
- UNKNOWN: information that is not known.
- NEXT VALIDATION: the test with the greatest uncertainty-reduction value.

When sources conflict, prioritize:

1. Actual runtime behavior and logs.
2. Actual data.
3. Active code.
4. Active configuration.
5. Jira and current business decisions.
6. Design documentation.
7. Historical comments.
8. Hypotheses.

A Jira workflow status does not prove implementation, validation, deployment, or technical validity.

## Minimum starting questions

Answer these first:

- Where does the symptom first appear?
- Which system created it?
- What identity did it have there?
- What did the next layer expect?
- What did it actually receive?

Prefer discriminating A/B tests over broad exploration. Do not inspect dozens of tables without a specific decision to make.

## Reference routing

Read only the references needed for the case:

- General method and closure: references/methodology.md
- Architecture, flow, and grain: references/architecture-and-lineage.md
- Identity and Downtime: references/downtime.md
- Known cases and guardrails: references/known-cases.md
- Ownership and dependencies: references/ownership-and-dependencies.md
- Environments, permissions, and escalation: references/environment-and-permissions.md
- Sources of truth: references/source-of-truth-registry.md
- Knowledge validity and updates: references/knowledge-governance.md
- Client communication: references/client-collaboration.md
- Available or pending technical sources: references/source-material-manifest.md
- Consolidated original requirements: references/fdc-consolidated-knowledge.md

Do not load every reference when the ticket does not require it.

## Investigation flow

1. Define the symptom, business expectation, environment, and time window.
2. Recover previous evidence and establish what is already confirmed.
3. Map source → transformations → destinations → consumer.
4. Record identity, grain, timestamps, and state at each boundary.
5. Find the first layer where expected and actual behavior diverge.
6. Inspect the active mechanism capable of producing that divergence.
7. Discard hypotheses that conflict with evidence.
8. Declare an RCA only when the mechanism and observed case form a demonstrable causal chain.
9. Propose a minimum fix and a separate stabilization plan when applicable.
10. Design regression, retry, replay, ambiguity, and recovery validations.
11. Prepare internal engineering analysis and external client-facing content in English.

## Duplicates and identity

Never begin with DISTINCT, ROW_NUMBER, DELETE, or automatic deduplication.

First determine whether the rows are:

- the same logical event;
- versions of the same event;
- legitimate separate events;
- representations from different systems;
- corrupt or ambiguous lineage.

A business key may discover candidates. It is not automatically a permanent identity.

## RCA closure criteria

An RCA is closed only when all of the following exist:

- reproduced symptom or equivalent evidence;
- identified first deviation;
- active technical mechanism;
- causal chain consistent with the observed case;
- primary competing hypotheses discarded;
- bounded impact;
- validation capable of confirming the fix.

Otherwise, provide CURRENT BEST MECHANISM and state that the RCA remains open.

## Required output structure

- SYMPTOM
- BUSINESS EXPECTATION
- CURRENT FLOW
- CONFIRMED FACTS
- DISCARDED HYPOTHESES
- OPEN QUESTIONS
- ROOT CAUSE or CURRENT BEST MECHANISM
- IMPACT
- FIX OPTIONS
- RECOMMENDED FIX
- REGRESSION / STABILIZATION RISKS
- VALIDATION PLAN
- EVIDENCE FOR JIRA
- NEXT ACTION

Use assets/investigation-template.md. Use assets/client-update-template.md for external communication.

## Language and style

- Internal skill instructions, references, and generated technical artifacts: English.
- User-facing explanation: follow the language used by the user unless they request otherwise.
- Jira, client, handoff, and UAT content: professional, direct English.
- Keep facts, inferences, and unknowns visibly separate.
- Prefer an actionable conclusion over an unnecessarily long investigation diary.
- Never dress a hypothesis in a tie and call it root cause.
