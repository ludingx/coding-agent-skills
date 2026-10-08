# Prototype

**You own the design decision, not the code. The prototype is a throwaway instrument. The real build follows Feature.**

The one playbook where the Laziness Protocol's "smallest change" and the verification bar invert. Speed over polish, code quality does not matter, no planning. The rigor is in picking the right design cheaply. Propose variations the user didn't ask for, throw an approach away and try another.

1. Scope the decision the prototype exists to make: which layout, which interaction, which density, or for an empirical fork which behavior, timing, or approach. No decision means no prototype. Route to Feature.
2. Gather references when the design space is open. Search for prior art, summarize a moodboard of themes, palettes, and layouts, let the user pick directions before building. Skip when the direction is set.
3. Build it with the **prototype** skill. It picks the logic or UI branch and keeps the code throwaway. For a behavioral or timing decision, the smallest script that exercises the question is enough.
4. When comparing alternatives, build them behind one switcher (buttons or a keypress), each variant labeled. This is the **principle-exhaust-the-design-space** skill made cheap.
5. Verify on the matching surface. For a visual decision, drive each variant and capture a screenshot of each. For a behavioral or timing decision, observe the behavior or timing directly. Before trusting or reporting a number, apply **principle-explain-the-number**. The observation is the test here, not an assertion. With no way to drive the surface, say so and hand the user the run command.
6. Present alternatives, evidence, tradeoffs, and a recommendation. Capture the selected direction and why in the implementation issue or design note using **technical-writing**. Keep the complete prototype as the primary source on a throwaway branch or in isolated scratch storage, not in production code. Hand the chosen direction and its evidence to **Feature** (or `architect` for the shape) for the real build. The prototype is throwaway; rewrite it for production.

Hand back: the variants explored, the evidence (screenshots for a visual decision, the observed output or timing for a behavioral one), tradeoffs, your recommendation, and the prototype path. Say plainly that the prototype is throwaway.
