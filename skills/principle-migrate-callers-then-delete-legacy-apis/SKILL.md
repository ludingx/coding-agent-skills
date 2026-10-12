---
name: principle-migrate-callers-then-delete-legacy-apis
description: Apply when introducing a new internal API while old callers still exist. Migrate callers and delete the old API in the same change instead of preserving compatibility layers.
disable-model-invocation: true
---

# Migrate Callers, Then Delete Legacy APIs

When a new internal API is the right design, migrate its callers and remove the old API in the same refactoring wave instead of preserving a compatibility layer.

**Rule:**

- Do not keep legacy API paths only because internal callers have not migrated yet.
- Inventory callers, migrate them, and delete the old API immediately.
- Treat temporary adapters as exceptional and time-boxed, not as the default architecture.
- Update tests to assert the new contract. Delete tests that only protect pre-refactor implementation details.

**When it applies:**

- There are no external users who depend on backward compatibility.
- The project can absorb a coordinated breaking change.
- The new API is part of a simplification or refactoring effort.

Keeping both APIs creates dual-path complexity, slows cleanup, and makes the codebase append-only.
