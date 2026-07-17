---
name: ux-archetypes
description: Implement UI to a technology-agnostic spec. Use when building or reviewing user-interface elements, components, page sections, pages, or flows (buttons, inputs, dialogs, tabs, menus, forms, navbars, cards, data tables, etc.), a design system, or design tokens — in any framework. Provides each pattern's interface contract (props, slots, events, states), accessibility and keyboard behavior, structural composition, shared behavior traits, and a themeable design-token system, so the implementation is correct and consistent instead of improvised.
---

# UX Archetypes

A catalogue of **UX archetypes** — technology-agnostic definitions of UI patterns
— plus a design-token system. Use it to implement UI **to a contract** rather
than inventing prop names, states, and accessibility each time. The archetypes
describe the *idea* (structure, behavior, a11y); you implement it in whatever
stack the user is working in (React, Vue, Svelte, SwiftUI, plain HTML, …).

## When to use

Reach for this whenever you're about to build or review a piece of UI: an
element (button, input, avatar…), a component (dialog, tabs, select, form,
navbar, data-table…), a page section/block (hero, pricing-table…), a whole page,
or a multi-step flow — or when setting up design tokens / theming.

## Workflow

1. **Find the archetype.** Look it up in `reference/archetypes.json` (keyed by
   `id`, e.g. `button`, `dialog`, `data-table`). Match the user's request to the
   closest `id`/`title`/`tags`. If nothing fits, it may genuinely be a novel
   pattern — say so.
2. **Read its contract.** Each archetype has an `api` block:
   - `props` — the axes of variation with their `type`, allowed `values` (for
     enums), and `default`. Implement exactly these; keep the names.
   - `slots` — the named content regions.
   - `events` — the semantic events to emit.
   - `a11y` — `role`, required `keyboard` keys, and what state to `announce`.
   - `states` — every interaction state to handle.
   - `tokens` — the design-token roles it consumes (see Tokens below).
3. **Apply its traits.** `traits` lists shared behaviors (`dismissible`,
   `focus-trap`, `anchored`, `roving-focus`, `typeahead`). Look each up in
   `reference/traits.json` for the exact keyboard/focus contract, and honor the
   `keys` it requires — they must appear in the archetype's `a11y.keyboard`.
4. **Wire its composition.** `composition` lists the parts an archetype is built
   from — each `ref` (another archetype), the `slot` it fills, and any `props`
   passed. Reuse those archetypes rather than re-building them.
5. **Implement to the contract**, in the user's framework and style. Cover every
   prop, state, and a11y requirement. Prefer composing existing archetypes.

## Design tokens

`reference/tokens.json` is a W3C DTCG token set: a monochrome `color.neutral`
ramp plus **semantic roles** the components bind to — `color.action.*` (interactive
fills), `color.status.{info,success,warning,danger}` (feedback), `color.ink` /
`color.muted` (text), `color.surface` / `color.paper` / `color.border`
(surfaces), `color.chart.*`, plus `font`, `space`, `radius`, `shadow`, etc.

Style components against the **roles**, not hardcoded grays — e.g. a primary
button uses `action.default` / `action.hover` with `action.onAction` text; an
alert's severity uses `status.*`. Then a re-theme is just changing token values.
`reference/themes.json` ships ready-made themes (bundles of token overrides) and
orthogonal light/dark `modes`.

If the target is Tailwind, the roles map to utilities (`bg-action`,
`text-on-action`, `bg-status-danger`, `text-ink`, `bg-surface`, `border-border`);
otherwise emit CSS variables (`--color-action`, …) or the stack's token
equivalent.

## Reference files

- `reference/archetypes.json` — every archetype: `id`, `layer`, `summary`,
  `intent`, `api` contract, `traits`, `composition`, `usedBy`, `related`.
- `reference/traits.json` — the shared behavior contracts (+ required keys).
- `reference/tokens.json` — the design tokens (DTCG).
- `reference/themes.json` — ready-made themes and light/dark modes.

## Principles

- The contract is the source of truth: match prop names, enum values, and
  defaults; don't add undeclared props or drop declared states.
- Accessibility is non-negotiable — implement the `a11y` and trait keyboard
  contracts, not just the happy path.
- Stay skin-agnostic: describe layout/behavior with tokens, never hardcoded
  pixels or colors.
