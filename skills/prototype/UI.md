# UI Prototype

Generate **several radically different UI variations** in an isolated scratch prototype, switchable from a floating bottom bar. The user flips between variants, picks one (or steals bits from each), then throws the rest away.

If the question is about logic/state rather than what something looks like, this is the wrong branch. Use [LOGIC.md](LOGIC.md).

## When this is the right shape

- "What should this page look like?"
- "I want to see a few options for this dashboard before committing."
- "Try a different layout for the settings screen."
- Any time the user would otherwise spend a day picking between three vague mockups in their head.

## Two sub-shapes: strongly prefer sub-shape A

A UI prototype is easier to judge when it reflects the app's real content and constraints. Recreate the relevant page context and realistic data in scratch space. Keep every variant outside production source. The prototype must not add a route, switcher, or production dependency.

### Sub-shape A: simulate an existing page (preferred)

The production route already exists. Recreate enough of its surrounding interface, data density, and behavior in the scratch prototype to judge the design. Keep variants separate from production components and data fetching.

If the prototype is for something that does not yet have a page but would naturally live inside one, simulate that host page in scratch space and place each variant in context.

### Sub-shape B: a new surface

Use this when the thing being prototyped genuinely has no existing page context, such as an entirely new top-level surface or a flow that cannot sensibly be embedded elsewhere.

Create the surface only in the isolated scratch prototype. Do not add a route to the production app.

Before choosing this shape, check whether existing page context would expose design problems that a blank canvas would hide.

In both sub-shapes the floating bottom bar is identical.

## Process

### 1. State the question and pick N

Default to **3 variants**. More than 5 stops being radically different and starts being noise, so cap there.

Create the prototype in an isolated scratch directory outside production source. Write down the plan in one line at the top of the prototype:

> "Three variants of the settings-page design, switchable with `?variant=` in the isolated prototype."

Keep the prototype easy to run with one command. Use vanilla HTML/CSS/JS or the lightest stack that renders the idea. Do not add production dependencies or tests. This works whether the user is here to push back or not.

### 2. Generate radically different variants

Draft each variant. Hold each one to:

- The page's purpose and the data it has access to.
- The project's visual language and constraints. Reuse only what helps the scratch artifact answer the question.
- A clear exported component name, e.g. `VariantA`, `VariantB`, `VariantC`.

Variants must be **structurally different**: different layout, different information hierarchy, different primary affordance, not just different colours. Three slightly-tweaked card grids isn't a UI prototype, it's wallpaper. If two drafts come out too similar, redo one with explicit "do not use a card grid" guidance.

### 3. Wire them together

Create a single switcher component in the scratch prototype:

```tsx
// pseudo-code, adapt to the project's framework
const variant = new URLSearchParams(location.search).get('variant') ?? 'A';
return (
  <>
    {variant === 'A' && <VariantA {...data} />}
    {variant === 'B' && <VariantB {...data} />}
    {variant === 'C' && <VariantC {...data} />}
    <PrototypeSwitcher variants={['A','B','C']} current={variant} />
  </>
);
```

For sub-shape A (existing page context): simulate the relevant data and keep it shared above the switcher; only the rendered subtree changes per variant.

For sub-shape B (new surface): the isolated scratch page mounts the same switcher.

### 4. Build the floating switcher

A small fixed-position bar at the bottom-centre of the screen with three pieces:

- **Left arrow**: cycles to the previous variant (wraps around).
- **Variant label**: shows the current variant key and, if the variant exports a name, that name too. e.g. `B (Sidebar layout)`.
- **Right arrow**: cycles forward (wraps around).

Behaviour:

- Clicking an arrow updates the URL search param so the variant is shareable and reload-stable.
- Keyboard: `←` and `→` arrow keys also cycle. Don't intercept arrow keys when an `<input>`, `<textarea>`, or `[contenteditable]` is focused.
- Visually distinct from the page (e.g. high-contrast pill, subtle shadow) so it's obviously not part of the design being evaluated.
- Kept outside production source, so the switcher cannot ship to users.

Put the switcher in one component within the scratch prototype so both shapes can reuse it.

### 5. Hand it over

Surface the run command and the `?variant=` keys. The user can flip through each option. The interesting feedback is often a combination of parts from different variants, which becomes the design to build.

### 6. Capture the answer and clean up

Once a variant has won, capture the answer (which variant and why) in the implementation issue or design note using **technical-writing**. Keep the complete prototype on a throwaway branch or in isolated scratch storage. Rebuild the winner properly in production code:

- **Sub-shape A**: implement the winner in the existing page. Do not copy prototype scaffolding or the switcher.
- **Sub-shape B**: implement the winning surface as a real route. Do not promote the throwaway route or switcher.

The full set of variants is the primary source. Keep it out of the production branch, where throwaway components and switchers would mislead future readers.

## Anti-patterns

- **Variants that differ only in colour or copy.** That's a tweak, not a prototype. Real variants disagree about structure.
- **Sharing too much code between variants.** A shared `<Header>` is fine; a shared `<Layout>` defeats the point. Each variant should be free to throw out the layout.
- **Wiring variants to real mutations.** Read-only prototypes are fine. If a variant needs to mutate, point it at a stub: the question is "what should this look like", not "does the backend work".
- **Promoting the prototype directly to production.** The variant code was written under prototype constraints (no tests, minimal error handling). Rewrite it properly when you fold it in.
