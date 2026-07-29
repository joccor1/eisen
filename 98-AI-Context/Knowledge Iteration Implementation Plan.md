---
type: implementation-plan
status: completed
tags: [system/knowledge-iteration]
---

# Knowledge Iteration Implementation Plan

## Goal

Add an LLM Wiki compilation layer to Eisen without moving or weakening the existing source-preserving research system.

## Changes

1. Create `07-Knowledge` for concepts, syntheses, indexes, review state, and the ingest ledger.
2. Seed the knowledge layer with concepts drawn from the current Easy Vibe course and collected research.
3. Add repeatable PowerShell tools for ingest tracking, review queue generation, and knowledge linting.
4. Update Agent operating context and content rules to require evidence-to-knowledge-to-output links.
5. Verify source preservation, ledger coverage, review queue generation, lint output, and clean PowerShell syntax.

## Boundaries

- `00-Inbox/Downloaded` remains raw and unchanged.
- `04-Research` remains the complete evidence layer.
- `07-Knowledge` contains concise compiled knowledge, not copies of whole source documents.
- Existing uncommitted changes outside this system are excluded from commits.
