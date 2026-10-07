# Connected sources

One section per MCP-backed evidence category. Each investigator gets only its own section. Source control has its own playbook in `code-archaeology.md`.

Rules for every category:

- **Learn the tools from their schemas.** Tool names, parameters, and auth differ by vendor and by MCP server. Read the schemas before the first call.
- **Probe before you assume.** Channel names, labels, project keys, table names, and service names are specific to each team. Discover them (list, search, describe) before you query them by name.
- **Auth failure is a gap.** If the MCP isn't authenticated or a resource is access-restricted, stop and report that it wasn't searchable. Don't make up findings.
- **Time-bound your searches** around the target's commit and PR dates, then widen if the window comes up empty.
- **Retention cliffs are gaps, not null results.** If nothing exists before a certain date, name the cliff so the synthesizer doesn't read it as "no activity".

## Issue / ticket tracker

**Contains.** Tickets with descriptions and comments, parent and sub-issue trees, projects with attached docs, labels, milestones.

**How to search.**

1. Start with the ticket IDs from the code anchor (commit messages, PR bodies). Read each ticket in full, including comments.
2. Keyword search for the feature name, key symbols, and the business term. Try several phrasings.
3. Walk the tree. Sub-issues are tactical. Parents often carry the why.
4. Read project-level docs attached to the ticket's project.
5. Read labels and milestones. Labels hint at the motivation (customer request, incident follow-up, compliance). Milestones tie work to deadlines.

**Pitfalls.** Scope drift (a ticket closed and reopened with a new scope). Boilerplate "Why" sections. Stale tickets that describe a plan that later changed. Closed-as-duplicate chains (follow them to the canonical ticket).

## Long-form documents

**Contains.** Design docs, specs, RFCs, ADRs, postmortems, meeting notes.

**How to search.**

1. Keyword search for the feature name, symbols, PR title, and ticket IDs.
2. Fetch candidate pages and read the full content, not the preview. Rationale is often buried mid-document.
3. Follow backlinks and child pages. Alternatives considered often live in sub-pages or appendices.
4. Check meeting notes and databases that may record the decision.

**Pitfalls.** Docs written before implementation and never updated. Doc vs. reality drift (the spec says X, the code does Y). Flag the divergence. Boilerplate templates. Unlinked docs that only broad search finds. Multiple drafts (find the finalized or latest one by date).

## Real-time team chat

**Contains.** Design threads, incident channels, reviewer questions answered by the author, customer asks relayed by product or support. Often where the real decision got made, and the most ephemeral source.

**How to search.**

1. Messages from the PR author around the PR merge date.
2. Keyword search for the feature name and symbols, including casual phrasings and misspellings.
3. The PR URL, or `/pull/<number>`.
4. The exact error string, if the code handles a specific error.
5. Channel-scoped search once you've discovered the team's engineering, project, and incident channels.
6. Fetch the whole thread for every hit. The decision usually lives in the replies.

**Pitfalls.** Unsearchable DMs (a known blind spot). Jokes read as decisions ("lol just do the thing" is not a decision). Single messages read without their thread.

**Return.** Channel, permalink, participants, date range, verbatim quotes with attribution.

## Infrastructure observability

**Contains.** Metrics, monitors and alerts, dashboards, traces and spans, logs, incident records, notebooks. The production reality around the time the code was written.

**How to search.**

1. Identify the owning service and its dependencies.
2. Dashboards and monitors first. A watched threshold is often the answer to "why is this clamped at N?"
3. Metrics around the target. Compare the trajectory with the target's merge date.
4. Logs, narrow and time-bounded, by symbol, error string, or feature. Aggregate instead of dumping raw lines.
5. Traces for timeouts, retries, slow paths, and cross-service behavior.
6. Incident records near the date the target was added, when the code looks defensive.

**Pitfalls.** Correlation is not causation (check neighboring PRs in the same window). A metric existing means someone cared, not that the code exists because of it. Renamed or expired telemetry is a gap, not a null.

## Error / exception tracking

**Contains.** Grouped issues with counts and first/last-seen times, individual events with stack traces, releases, issue comments.

**How to search.**

1. Discover the organization and project for the target's service.
2. Search issues by error string, exception type, and the target's file or function names.
3. Narrow by release and a window around the target's ship date.
4. Pull full events for stack traces through the target.
5. Check which releases landed near the target and which issues stopped after them.

**Pitfalls.** Grouping drift (a refactor can move the "same" error to a new issue ID). A release holds many commits, so an issue stopping at a release doesn't prove the target fixed it. Upstream changes can silence an error. "Resolved" is a human marker, not proof of a fix. Sampling can make a common error look rare. AI-generated issue summaries are not evidence. Cite the events.

## Product analytics warehouse

**Contains.** Product events, usage and billing data, experiment and feature-flag exposure, query history, pipeline lineage.

**How to search.** Discover the schema first (list and describe tables). Never report a result from a table whose existence you didn't confirm. Then:

1. **Usage trajectory.** Daily event counts in a window around the PR merge. A step from zero to steady volume suggests a launch. A decay to zero suggests a deprecation.
2. **Threshold origin.** The distribution (median, p99, max) of the relevant value before the PR. A p99 matching the target's constant suggests the number came from data.
3. **Experiment lookup.** Exposure counts by variant for the relevant flag near the PR date.
4. **Query history** for migrations, backfills, or perf rewrites. The expensive queries in a tight window around the change.
5. **Lineage.** If a pipeline model's own code lives in the repo, hand that lead to the source control investigator.

**Pitfalls.** Instrumented is not caused. A volume step can mean a new event started being logged, not a behavior change. Schema drift (a column may not have existed when the target was written). Pipeline refresh lag for recent data. Notebooks are usually not queryable over SQL, so name them as a gap.

**Return.** Fully qualified tables, the time windows, and the numeric summaries that bear on the question.

## What every investigator returns

Every item that bears on the question, with its exact text or numbers, its location (ticket ID, doc URL, permalink, issue ID, table), author and date where available, and whether it's direct or circumstantial. Follow the output format in the investigator prompt.
