---
name: principle-type-system-discipline
description: Apply when designing types, reviewing a function signature, or writing statically typed code. Make illegal states unrepresentable, distinguish semantic primitives, parse external data at boundaries, avoid bypassing the compiler, exhaust variants, and derive types from authoritative schemas.
disable-model-invocation: true
---

# Type System Discipline

Make the compiler reject impossible states, mismatched primitives, and unhandled variants. Prefer defining errors and special cases out of existence over adding handlers for them. For TypeScript-specific patterns, see [`typescript-best-practices`](../typescript-best-practices/SKILL.md).

- **Make illegal states unrepresentable.** Model variants as sum types (discriminated unions, enums with payloads, sealed classes), not bags of optional fields that allow contradictory combinations. If a comment must explain when a field combination is valid, consider splitting it into variants.
- **Construct types from valid values.** Build a type up from the values callers need instead of carving legal values out of a looser type with repeated checks. For example, represent a non-empty list as a head plus a rest, and a time range as a start plus a duration.
- **Distinguish semantic primitives.** `UserId` and `OrderId` may both be strings, but they are not interchangeable. Give different concepts distinct types, validate them at creation, and trust the resulting types downstream.
- **Parse external data at boundaries.** RPC payloads, JSON, IPC messages, CLI arguments, configuration, environment variables, and database rows are untyped until parsed. Convert them to the typed model at each boundary. See [Boundary Discipline](../principle-boundary-discipline/SKILL.md) for where validation belongs.
- **Do not lie to the type system.** Casts, unsafe coercions, and assertion functions that bypass the compiler can hide runtime failures. Validate, narrow, or refine the model so the compiler can prove the fact; otherwise treat the cast as a hazard.
- **Make variant handling exhaustive.** A match over a sum type should fail compilation when a variant is added without handling it. Use the language's exhaustiveness mechanism.
- **Derive types from authoritative schemas.** When a protocol buffer, OpenAPI spec, GraphQL schema, database migration, or other source owns a shape, derive the type instead of hand-maintaining a parallel one. See [Encode Lessons in Structure](../principle-encode-lessons-in-structure/SKILL.md).
- **Strengthen types where partiality appears.** A runtime assertion, null check, or “should never happen” throw may reveal a type that is too weak. Push the constraint into the type where it prevents a real failure, then stop. Prefer total functions; do not make every type maximally precise without a concrete need.
