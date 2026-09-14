# Knowledge governance

## Minimum record

Every extracted knowledge item must record:

- source
- ticket
- date
- environment
- domain
- evidence_type
- confidence
- validity
- supersedes
- related_tickets
- requires_revalidation

## Validity states

- current: confirmed and applicable.
- historical: valid for an earlier version or period.
- superseded: replaced by a later decision or implementation.
- contradicted: incompatible with direct evidence.
- unverified: recalled or narrated without corroboration.
- environment-specific: applicable only to the stated environment.

## Memory versus evidence

Memory and conversations help locate knowledge. Jira, data, runtime, and active code corroborate it. Do not present a conversation as an accessible source when it is not in the current context or attached.

## Future ingestion

1. Add the unchanged original source under source-material/.
2. Remove secrets and unnecessary PII.
3. Extract facts with metadata.
4. Link tickets, objects, and domains.
5. Detect contradictions and supersession.
6. Update derived references.
7. Run evaluations.
8. Record the change in CHANGELOG.md.

## Prohibitions

- Do not store credentials, tokens, or access codes.
- Do not silently replace a historical rule.
- Do not treat Jira closure as technical proof.
- Do not promote a hypothesis to current knowledge.
- Do not turn SKILL.md into a source dump.
