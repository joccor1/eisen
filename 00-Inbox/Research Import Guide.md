---
type: guide
status: active
tags: [system/inbox, system/research]
---

# Research Import Guide

Put raw web captures, exports, and Markdown downloads in `00-Inbox/Downloaded`. Put local files and images in `00-Inbox/Attachments`. Do not manually move a source into multiple research folders.

Run `../98-AI-Context/Automation/Research-Cleaner.ps1` from the vault root (or pass `-SourcePath`). The cleaner retains raw content, creates one cleaned research note, assigns topic tags, and adds a Topic Hub link.

Use [[Research Triage Guide]] for uncertain material and [[Research Collection Workflow]] for the full flow.
