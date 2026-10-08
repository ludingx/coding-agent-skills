# Authoring or modifying a skill

**You own the instruction contract.** Use this route for a new or edited `SKILL.md` or its bundled references. An agent-behavior comparison is a separate **Skill eval**; syntax and link checks do not establish that a skill triggers or works.

1. Identify the intended trigger, the decision or action the skill should change, and the existing skill that owns it. Read the surrounding skills and the call sites that route to them. Prefer changing an existing skill over creating a duplicate. Respect the target agent's actual tools and the current repo's PR and autonomy rules.
2. Draft the smallest change. Keep common instructions in `SKILL.md`; put optional, longer procedures in references and link them from the entry point. Do not refer to a skill, playbook, tool, or script that the target environment cannot reach. When porting a skill, compare its caller routes and supporting files as well as its body.
3. Validate every touched skill's `name` and `description`, linked files, relative paths, and cross-skill references. Ensure the description says when to invoke it, not just what it contains. Check that each workflow step is possible with the tools available to its agents. Use an installed skill validator if available; otherwise inspect these checks directly.
4. Exercise representative requests: one that should route to the skill, one that should not, and a concrete task that follows its instructions. For a structural edit, check that the named files and steps resolve. For a claim that the new wording changes agent behavior, run **Skill eval** instead of relying on your own reading or the agent's self-report. Record which checks ran and any gaps.
5. Review the instructions for duplication and stale tool-specific assumptions. Run **Opening a PR** only when the user asks.

Hand back: the intended trigger, files and routes changed, validation results, and whether behavior was evaluated or remains untested.
