---
name: principle-name-the-state
description: "Apply when writing or reviewing a condition that combines negations or checks several values inline. Extract a positive, domain-named predicate and negate that once at the call site."
disable-model-invocation: true
---

# Name the State

A guard that decides whether a value is usable should read as the concept, not the boolean algebra. Extract the condition into a positive, domain-named predicate, then negate the name at the call site.

**Why:** An inline negated compound condition forces the reader to reconstruct the positive meaning before they can follow the branch. `if (type !== 'image/png' && type !== 'image/jpeg')` makes the reader invert two comparisons and join them. `if (!isSupportedImage(type))` states the concept once and keeps the accepted values in a single place.

**Pattern:**
- Name the positive concept, not the absence. `isSupportedImage`, not `isNotPngOrJpeg`.
- Keep the accepted values inside the predicate, in one place.
- Negate the name once at the call site.
- Prefer an early return over a nested negation.

**Example:**

Before:

```ts
if (file.type !== 'image/png' && file.type !== 'image/jpeg') {
    throw new UnsupportedFileError(file.type);
}
```

After:

```ts
const SUPPORTED_IMAGE_TYPES = ['image/png', 'image/jpeg'];

const isSupportedImage = (type: string): boolean => SUPPORTED_IMAGE_TYPES.includes(type);

if (!isSupportedImage(file.type)) {
    throw new UnsupportedFileError(file.type);
}
```

**When to apply:** While writing the condition, and again on the review pass. A condition that slipped through is easiest to fix while cleaning up the diff before commit.

**Anti-patterns:**
- A negated compound condition inline, `if (!a && !b)`.
- A predicate named for the failure when a positive concept exists.
- The same accepted-value list repeated across call sites.

**Graduation:** If this rule keeps recurring, promote it to a lint rule. See **principle-encode-lessons-in-structure**.
