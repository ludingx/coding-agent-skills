---
name: deslop
description: Review the current change for unnecessary code, defensive noise, and style that conflicts with the surrounding code. Use before committing or when asked to clean up a diff.
---

# Remove code slop

Review the current branch diff against its base. Include staged and unstaged changes. Remove only changes that add noise or conflict with the surrounding code.

Check for:

- Comments that repeat what the code says.
- Defensive checks or `try`/`catch` blocks on trusted paths without a real failure case.
- `any` casts that hide a type error rather than model a real boundary.
- Deep nesting that a clear early return can replace.
- Other patterns that do not match the conventions in nearby code.

Do not change behavior during cleanup. Prefer small, focused edits. Preserve useful comments, meaningful error handling, and intentional differences in style. Do not reformat unrelated files. Report suspected bugs separately instead of fixing them in this cleanup pass.

After edits, inspect the diff again and run the checks affected by those edits. Report the files changed and any issues left open.
