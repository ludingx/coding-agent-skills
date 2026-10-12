# Example verification feature map

This directory illustrates how to index user-facing verification journeys. Replace the sample app, preconditions, and commands with evidence from the target repository. Do not copy sample commands as if they applied to another app.

## Baseline preconditions

- Start a disposable app instance using the repository's documented command.
- Isolate its database, profile, and ports from the user's normal environment.
- Seed only the data required by each journey.
- Run the verification skill's read-only health check before driving the app.
- Never drive an instance this run did not start or identify.

## Driving conventions

- Begin each journey from its stated baseline.
- Prefer stable accessible names and documented CLI commands over DOM positions or coordinates.
- Capture the user action and resulting state.
- For mutations, confirm persisted state through a second user-facing read path.
- Restore seeded state during cleanup, but preserve proof artifacts.

## Proof and skips

- UI proof includes an app identity marker and a screenshot or accessibility snapshot when available.
- CLI proof includes the exact command, stdout, stderr, and exit code.
- Report an unreachable path with the attempted route and unmet prerequisite.
- Do not mark an entry point verified because a different entry point worked.

## Feature entry contract

Each feature file describes a user-visible behavior and includes:

1. `Sub-features` with stable journey IDs.
2. `How to get to it (user POV)` with every supported entry point.
3. `Driving it with <harness>` with preconditions, exact actions, and observable outcomes.
4. `Gotchas` with conditions that can invalidate the run.

Keep implementation details out of the map unless they are needed to drive or observe the user path.

## Example journeys

- [Create an item](./create-note.md)
- [Search items](./search.md)
