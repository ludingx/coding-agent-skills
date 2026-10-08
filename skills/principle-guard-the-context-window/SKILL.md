---
name: principle-guard-the-context-window
description: Apply when context is filling with large outputs, long files, repeated reads, or fan-out planning. Route bulk work to subagents and keep concise summaries in the main thread.
disable-model-invocation: true
---

# Guard the Context Window

The context window is finite. Spend its tokens on information that changes the work.

- Route verbose outputs, screenshots, and large documents to subagents. Keep concise findings in the main thread, not raw payloads.
- Keep frequently used instructions inline when reading a separate reference each time would add repeated cost.
- Limit each phase by files, scope, or turns. Include the cost of tools and fan-out when setting the limit.
