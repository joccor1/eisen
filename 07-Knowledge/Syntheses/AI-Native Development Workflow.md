---
type: synthesis
status: active
confidence: medium
first_compiled: 2026-07-29
last_reviewed: 2026-07-29
review_after: 2026-08-28
topics: [topic/vibe-coding, topic/agent, topic/workflow, topic/software-engineering]
evidence:
  - [[07-Knowledge/Concepts/Vibe Coding]]
  - [[07-Knowledge/Concepts/AI Agent Development]]
  - [[04-Research/AI/Vibe-Coding/Easy-Vibe-Course/项目介绍]]
  - [[04-Research/AI/Agents/Developer-Agents/从 Vibe Coding 到 Spec Coding：AI 编程的进化之路]]
tags: [type/synthesis, topic/vibe-coding, topic/agent, topic/workflow]
---

# AI-Native Development Workflow

## Scope

An operating model for turning a product intent into a verified implementation with AI coding tools, while retaining project state and evidence.

## Synthesis

1. Define an outcome, constraints, and acceptance checks before asking an agent to act.
2. Give the agent the smallest sufficient context: relevant repository rules, project state, source material, and an explicit task boundary.
3. Work in observable increments: implement, inspect the diff, run the relevant verification, then record the durable result.
4. Promote repeatable decisions into a specification, prompt, workflow, or project record rather than relying on a previous chat.
5. When a workflow becomes stable, connect it to [[97-AI-Memory/Best-Practices]] and the relevant Topic Hub.

## Evidence boundary

This is an operating synthesis, not a claim that every AI coding tool or project follows the same process. Tool-specific guidance remains in the linked research evidence.

## Related knowledge

[[Vibe Coding]] | [[AI Agent Development]] | [[Research-to-Content Pipeline]] | [[04-Research/Topic-Hubs/Workflow Hub]]

## Open questions

- Which specification template best balances speed and reliability for the owner's typical projects?

## Review log

- 2026-07-29: Initial synthesis from Easy Vibe course evidence and developer-agent research. Confidence: medium.
