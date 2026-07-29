# Eisen AI Native Knowledge Base

Local-first Obsidian knowledge base for research, projects, AI agents, and multi-channel publishing.

## Operating model

1. Capture unprocessed material in `00-Inbox/Downloaded`.
2. Run `98-AI-Context/Automation/Research-Cleaner.ps1` to preserve the original content, normalize structure, and route a copy to one research home.
3. Develop research through tags, internal links, and `04-Research/Topic-Hubs` instead of duplicating files.
4. Move durable operating knowledge to `97-AI-Memory`, current instructions to `98-AI-Context`, and active delivery work to `06-Projects`.

Read [[98-AI-Context/AI Operating Context]] before an AI agent makes material edits.

## Git

Run `98-AI-Context/Automation/Sync-Vault.ps1` for an explicit sync. Obsidian Git can provide the scheduled equivalent after its community plugin is installed and enabled.
