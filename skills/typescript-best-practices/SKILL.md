---
name: typescript-best-practices
description: TypeScript-specific applications of type-system discipline. Use when reading or editing .ts or .tsx files.
disable-model-invocation: true
---

# TypeScript best practices

For `.ts` or `.tsx` work, apply **principle-type-system-discipline** first. These are TypeScript-specific applications of that language-agnostic principle.

| Rule | Summary |
|---|---|
| Discriminated unions | Model variants with a `kind` literal discriminant so impossible states cannot be represented. Avoid optional-field bags. |
| Branded types | Brand semantic primitives with `& { readonly __brand: "X" }` so distinct IDs cannot be mixed up. Validate once at the boundary. |
| Constructive modeling | Build types so illegal values cannot be constructed. Use `[T, ...T[]]` for non-empty lists and `[T, T][]` for pairs. |
| Simplest total type | Keep `T[]` while its operations are total. Strengthen it to `NonEmpty<T>` only where the loose type forces a non-null assertion, cast, or “should never happen” throw. |
| `unknown` over `any` | Treat external data as `unknown` and narrow or parse it before use. |
| Schemas before guards | Before hand-writing a property-by-property type guard, use the repository's runtime schema library and infer the type from the schema. |
| No `as` casts | Treat assertions as hazards. Validate, narrow, or refine the type so the compiler can prove the fact. |
| Narrowing hierarchy | Prefer a discriminant, then `in`, `typeof` or `instanceof`, then a truthful user-defined guard. Cast only after validation when unavoidable. |
| Exhaustiveness | Make switches over variants fail to compile when a variant is added without a case. |
| `satisfies` over `as` | Validate a value without widening its literal types. |
| Boundary validation | Parse data where it enters into a named domain type, then trust that type internally. See **principle-boundary-discipline**. |
| Schema-derived types | Reach for `Pick`, `Omit`, `Parameters`, `ReturnType`, `Awaited`, or `typeof` before declaring a duplicate interface. |
| Object arguments | Prefer named object arguments when positional order is easy to confuse. Skip on hot paths where allocation matters. |
| Real tests | Do not mock behavior you can run. Prefer real framework test primitives and verify UI in a running build. Mock only external systems that cannot run locally. |
| Structured telemetry | Prefer structured diagnostics with enough context to debug from an identifier. Do not ship `console.log`. |

Examples are in [`references/patterns.md`](references/patterns.md). Use the repository's actual schema library and conventions; do not add dependencies or invent a new branding convention just to follow an example.
