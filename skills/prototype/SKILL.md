---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
---

# Prototype

A prototype is **throwaway code that answers a question**. Keep it in an isolated scratch directory or throwaway branch, separate from production source. The question decides the shape.

## Pick a branch

Identify which question is being answered, using the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build a single shareable HTML file (free-play buttons plus tabbed guided walkthroughs) that pushes the state machine through cases that are hard to reason about on paper, and that a non-developer can drive.
- **"What should this look like?"** → [UI.md](UI.md). Generate several radically different UI variations in an isolated scratch prototype, switchable via a URL search param and a floating bottom bar.

The two branches produce very different artifacts, so getting this wrong wastes the whole prototype. If the question is genuinely ambiguous and the user isn't reachable, default to whichever branch better matches the problem (a state model → logic; a page or interaction → UI) and state the assumption at the top of the prototype.

For product or UX tradeoffs, apply **principle-experience-first**. Choose based on the experience for the person using and maintaining the result, not implementation convenience.

For behavioral or timing measurements, apply **principle-explain-the-number** before trusting or reporting a measured number.

## Rules that apply to both

1. **Throwaway from day one, and clearly marked as such.** Keep prototype code in an isolated scratch directory or throwaway branch, outside production source. Simulate relevant page context and realistic data without adding prototype routes or switchers to the production app.
2. **Trivial to run.** A UI prototype starts with one command, using the lightest stack that renders the idea. A logic demo is a single HTML file the user double-clicks. Either way, make it easy to start.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is _checking_, not something it should depend on. If the question explicitly involves a database, hit a scratch DB or a local file with a clear "PROTOTYPE, wipe me" name.
4. **Skip the polish.** No tests, no error handling beyond what makes the prototype _runnable_, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action (logic) or on every variant switch (UI), print or render the full relevant state so the user can see what changed.
6. **Capture it when done.** Capture the selected direction and why, with its evidence, in the implementation issue or a design note. Write that durable artifact with **technical-writing**. Keep the complete prototype as a primary source on a throwaway branch or in isolated scratch storage, and leave a context pointer from the implementation issue. Rebuild the chosen direction properly in production code. The production branch keeps only the validated decision and implementation.
