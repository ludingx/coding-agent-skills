# Incident & Postmortem Context

Not a separate source, a **cross-cutting angle**. Incidents often motivate defensive code ("we added this check after the X outage"), so if the target looks defensive (null checks, retry logic, timeout handling, rate limiting, feature flags), specifically hunt for incident history inside your own source:

- **Source control**: commits with messages like "fix for incident", "add defensive check", "revert" followed by "re-apply with..." are strong signals
- **Issue / ticket tracker**: tickets labeled or titled with incident, severity, postmortem action item, or reliability terms
- **Long-form documents**: postmortems mentioning the target file, feature, or error string
- **Real-time team chat**: incident or on-call channels, searched around the dates the target code was added
- **Infrastructure observability**: formal incident records with timelines, and dashboards or monitors created as postmortem action items
- **Error / exception tracking**: issues whose first-seen/last-seen window aligns with the target's PR ship date, and stack traces through the target
- **Product analytics warehouse**: events that record an error condition (client-reported failures, user-visible retries) often spike during an incident window. A drop in that count after the target PR ships is circumstantial support that the target resolved the user-visible symptom, even when observability or error-tracking signal is noisy.

Learn the team's incident naming (labels, channel names, document titles) from what you find before assuming any. If you find an incident link, fetch the full postmortem. Postmortems typically have an "Action Items" section that ties directly to code changes. When multiple sources corroborate (an incident ID appears in a ticket, which appears in a postmortem, which appears in a chat thread that links to the target PR, and the error-event count drops after the fix), the evidence is especially strong.

Worth spending time on when the code's defensive character makes an incident-driven origin plausible. Skip it for code that doesn't look defensive.
