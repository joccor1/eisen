---
type: workflow
status: manual-step-required
tags: [system/capture, topic/workflow]
---

# MarkDownload Workflow

Configure MarkDownload's download directory to `D:\obsidian\eisen\00-Inbox\Downloaded`. Preserve frontmatter and full article content.

```text
MarkDownload
  -> 00-Inbox/Downloaded
  -> Research-Cleaner.ps1 -All
  -> 04-Research/<one primary home>
  -> topic tags + Topic Hub links
```

The cleaner normalizes line spacing, extracts source URLs, preserves original content, creates one derived research note, and leaves the raw download untouched.
