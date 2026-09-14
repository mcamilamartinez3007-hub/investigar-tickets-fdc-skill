#!/usr/bin/env python3
"""Validate mechanical FDC Knowledge Hub invariants without external packages."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
KNOWLEDGE = ROOT / "knowledge"
ENTRY_DIRS = [
    KNOWLEDGE / "candidates",
    KNOWLEDGE / "verified",
    KNOWLEDGE / "operational",
    KNOWLEDGE / "superseded",
]
REQUIRED = {
    "knowledge_id", "title", "domain", "component", "knowledge_type",
    "lifecycle_status", "claim", "fingerprint", "source_tickets",
    "source_references", "date_observed", "environment", "affected_systems",
    "affected_objects", "evidence", "confidence", "validity", "applicability",
    "novelty", "conflict", "validation", "reuse", "promotion",
    "security_review", "revalidation",
}
ALLOWED_STATUS = {
    "candidate", "provisional", "verified", "operational",
    "conflict_pending", "superseded", "rejected",
}
SECRET_PATTERNS = {
    "private key": re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----", re.I),
    "AWS access key": re.compile(r"\bAKIA[0-9A-Z]{16}\b"),
    "credential assignment": re.compile(
        r"\b(?:password|passwd|pwd|api[_-]?key|secret|token)\s*[:=]\s*['\"][^'\"\r\n]{8,}",
        re.I,
    ),
}


def load_json_entries() -> list[tuple[Path, dict]]:
    entries = []
    for directory in ENTRY_DIRS:
        for path in sorted(directory.glob("*.json")):
            try:
                value = json.loads(path.read_text(encoding="utf-8"))
            except Exception as exc:
                fail(f"{path.relative_to(ROOT)}: invalid JSON: {exc}")
                continue
            if not isinstance(value, dict):
                fail(f"{path.relative_to(ROOT)}: entry must be a JSON object")
                continue
            entries.append((path, value))
    return entries


ERRORS: list[str] = []


def fail(message: str) -> None:
    ERRORS.append(message)


def validate_entry(path: Path, entry: dict) -> None:
    relative = path.relative_to(ROOT)
    missing = sorted(REQUIRED - set(entry))
    if missing:
        fail(f"{relative}: missing required fields: {', '.join(missing)}")

    knowledge_id = entry.get("knowledge_id", "")
    if not re.fullmatch(r"FDC-KNOWLEDGE-[0-9]{4,}", str(knowledge_id)):
        fail(f"{relative}: invalid knowledge_id {knowledge_id!r}")

    status = entry.get("lifecycle_status")
    if status not in ALLOWED_STATUS:
        fail(f"{relative}: invalid lifecycle_status {status!r}")

    if not str(entry.get("claim", "")).strip() or len(str(entry.get("claim", ""))) < 20:
        fail(f"{relative}: claim is missing or too short")

    if not entry.get("source_references"):
        fail(f"{relative}: source_references must not be empty")
    if not entry.get("evidence"):
        fail(f"{relative}: evidence must not be empty")

    conflict = entry.get("conflict") or {}
    if status == "conflict_pending" and not conflict.get("conflicting_knowledge_ids"):
        fail(f"{relative}: conflict_pending requires conflicting_knowledge_ids")

    validation = entry.get("validation") or {}
    if status == "operational" and validation.get("status") != "passed":
        fail(f"{relative}: operational knowledge requires passed validation")

    promotion = entry.get("promotion") or {}
    gates = promotion.get("gate_results") or {}
    if status == "verified":
        for gate in ("provenance", "novelty", "evidence", "scope", "conflict", "safety"):
            if gates.get(gate) is not True:
                fail(f"{relative}: verified knowledge requires {gate}=true")
    if status == "operational":
        for gate in ("provenance", "novelty", "evidence", "scope", "conflict", "utility", "safety", "effectiveness"):
            if gates.get(gate) is not True:
                fail(f"{relative}: operational knowledge requires {gate}=true")

    raw = json.dumps(entry, ensure_ascii=False)
    for label, pattern in SECRET_PATTERNS.items():
        if pattern.search(raw):
            fail(f"{relative}: possible {label} detected")


def main() -> int:
    entries = load_json_entries()
    seen_ids: dict[str, Path] = {}
    seen_fingerprints: dict[str, Path] = {}

    for path, entry in entries:
        validate_entry(path, entry)
        knowledge_id = str(entry.get("knowledge_id", "")).strip().lower()
        fingerprint = str(entry.get("fingerprint", "")).strip().lower()

        if knowledge_id:
            if knowledge_id in seen_ids:
                fail(
                    f"{path.relative_to(ROOT)}: duplicate knowledge_id also used by "
                    f"{seen_ids[knowledge_id].relative_to(ROOT)}"
                )
            else:
                seen_ids[knowledge_id] = path

        if fingerprint:
            if fingerprint in seen_fingerprints:
                fail(
                    f"{path.relative_to(ROOT)}: duplicate fingerprint also used by "
                    f"{seen_fingerprints[fingerprint].relative_to(ROOT)}"
                )
            else:
                seen_fingerprints[fingerprint] = path

    if ERRORS:
        print("Knowledge validation failed:")
        for error in ERRORS:
            print(f"- {error}")
        return 1

    print(f"Knowledge validation passed: {len(entries)} entries checked.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
