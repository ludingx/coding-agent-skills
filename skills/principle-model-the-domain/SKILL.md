---
name: principle-model-the-domain
description: Apply when writing stateful logic, when code branches a lot, or repeats shape assumptions across files. Encode the domain in structure instead of scattered conditionals.
disable-model-invocation: true
---

# Model the Domain

Encode the domain in a data structure instead of scattering it across conditionals.

Scattered booleans, repeated shape assumptions, and branching across files create accidental complexity. A structure that matches the domain makes invalid states harder to represent and removes branches.

Reach for structures such as:

- A state machine instead of scattered booleans, phases, and lifecycle checks.
- A typed model instead of loose parameters and repeated shape assumptions.
- A map, registry, lookup table, or discriminated union instead of branching across files.
- A reducer or command/event model instead of ad hoc state mutations.
- A module organized around one body of domain knowledge instead of an execution sequence such as load, validate, transform, and save.
- A small module boundary that gathers repeated behavior, ownership, or invariants.
- A queue, cache, index, graph, tree, or normalized collection when the access pattern calls for it.
- Any other structure that fits. When none fits, identify what the code must never allow and how the data gets read, then choose the structure that encodes those constraints.

Do not force an abstraction. Keep boring code when its current shape is clear, local, and unlikely to grow. Be skeptical of abstractions that add indirection without removing branches, duplicated rules, invalid states, or lifecycle risk.

Apply this principle before writing logic. Choose the data shape and organizing structure first, then implement behavior around it.

Watch for a feature that adds one more branch to an existing if/else chain, a second boolean that must stay in sync with the first, or phase-named modules that repeat the same domain rules across steps.
