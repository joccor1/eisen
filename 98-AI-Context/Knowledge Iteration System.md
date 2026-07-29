---
type: knowledge-system
status: active
version: 1.0
tags: [system/knowledge-iteration, topic/obsidian, topic/workflow]
---

# Knowledge Iteration System

## Purpose

Turn raw research into reusable, source-grounded knowledge and then into original content. The system is local-first, human-readable, and safe to re-run.

## Four layers

| Layer | Location | Responsibility | Mutability |
| --- | --- | --- | --- |
| Source | `00-Inbox/Downloaded` and external source collections | Preserve original evidence | Read-only after capture |
| Evidence | `04-Research` | Classify, retain complete source material, and connect topics | Derived, source-preserving |
| Knowledge | `07-Knowledge` | Compile concepts, syntheses, indexes, questions, and review state | Recompiled and curated |
| Output | `05-Content` | Create original platform-specific work from knowledge and evidence | Iterative, selectively fed back |

`97-AI-Memory`, `98-AI-Context`, and `06-Projects` are operating state, not substitutes for the Knowledge layer.

## Core loop

```text
capture -> evidence -> ingest -> concepts and syntheses -> create -> review -> improve
                     ^                                           |
                     +-------- approved high-value output --------+
```

1. **Capture**: save source material without silently changing it.
2. **Evidence**: give every note one primary research directory, topic tags, and Topic Hub links.
3. **Ingest**: compile selected evidence into concept pages and synthesis pages. Re-ingest is always allowed.
4. **Create**: create content briefs and outputs by linking to compiled knowledge and evidence.
5. **Review**: revisit important or aging concepts, resolve contradictions, and record changes.
6. **Improve**: promote only approved, durable output back into the knowledge loop.

## Ingest contract

For each selected evidence note, an agent must:

1. Read the source note and preserve the original claim boundaries.
2. Update `07-Knowledge/Concepts/<Concept>.md` only with source-grounded claims.
3. Add or update a synthesis when the source changes a cross-source understanding.
4. Update `07-Knowledge/Indexes/Knowledge Index.md` and `07-Knowledge/.ingested.json`.
5. Link the evidence note, Topic Hub, related concepts, and unresolved questions.

Ingest tracking records history but never prevents re-ingest.

## File Back contract

An agent files back only durable, reusable knowledge: a decision with rationale, validated workflow, best practice, useful contradiction, or source-grounded insight. It must include an evidence link, date, confidence, and target concept or synthesis. Do not file back chat transcripts or unverified opinion.

## Output feedback contract

Publishing does not automatically change the knowledge layer. Promote an output only if it adds a reusable framework, empirical result, corrected explanation, or well-tested workflow. Link the output to its evidence and compiled knowledge before promotion.

## Quality gates

Before a concept or synthesis is marked `stable`, it needs at least one evidence link, a clear scope, a confidence value, and a last-reviewed date. A cross-source claim needs two or more independent evidence links or must be labelled `single-source`.

## Cadence

| Frequency | Action |
| --- | --- |
| Per import | Evidence classification and optional ingest |
| Weekly | Review new concepts, unanswered questions, and content candidates |
| Monthly | Run knowledge lint; review high-value concepts not reviewed in 30 days |
| Quarterly | Prune stale low-value concepts, refresh Topic Hubs, select outputs for feedback |

## Commands for agents

- `ingest <note>`: compile a specific evidence note.
- `ingest unprocessed`: list evidence not in the ledger, then process confirmed selections.
- `file back <insight>`: write a durable, evidenced insight to a concept or synthesis.
- `knowledge review`: generate and work through the review queue.
- `knowledge lint`: run the knowledge audit and address findings.
- `generate <channel/topic>`: create a content brief using linked knowledge and sources.
