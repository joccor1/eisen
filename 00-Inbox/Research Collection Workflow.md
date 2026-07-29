---
type: workflow
status: active
tags: [system/inbox, system/research, topic/workflow]
---

# Research Collection Workflow

```text
Web Clipper / MarkDownload
        -> 00-Inbox/Downloaded
        -> Research Cleaner
        -> 04-Research/<one primary home>
        -> Topic tags + Topic Hub links
        -> 07-Knowledge concepts / syntheses when reusable
        -> Content idea / project / AI memory when durable
```

The raw capture remains in `00-Inbox/Downloaded`. The cleaned research note is a separate, traceable derivative.

When a note changes a reusable model, run the ingest contract in [[98-AI-Context/Knowledge Iteration System]]. The ledger in `07-Knowledge/.ingested.json` tracks the event but never prevents a later re-ingest.
