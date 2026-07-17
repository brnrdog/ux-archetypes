---
id: archetype-id
title: Archetype Title
layer: element # element | component | page | flow
version: 0.1.0
status: draft # draft | stable | deprecated
summary: One sentence describing what this archetype is and the value it provides.
since: 0.1.0
updated: YYYY-MM-DD
tags: []
aliases: []
composedOf: []
usedBy: []
related: []
maintainers: []
---

# Archetype Title

## Intent

<!-- The problem this pattern solves and the value it provides. One or two
     paragraphs. Describe the *idea*, not a specific visual design. -->

## API

<!-- Optional but recommended for element/component archetypes. A
     machine-readable, skin-agnostic interface contract in a `json` fenced
     block. It names the axes of variation (props), structural regions (slots),
     semantic events, accessibility expectations, states, and the design-token
     roles consumed. Validated by schema/api.schema.json. Generated prop types
     (Contracts.res) and the conformance check (npm run conformance) are derived
     from it, so implementations are provably kept in sync. Remove this section
     for archetypes that have no implementable interface (most pages/flows). -->

```json
{
  "props": [
    { "name": "variant", "type": "enum", "values": ["a", "b"], "default": "a", "description": "…" },
    { "name": "disabled", "type": "boolean", "default": "false", "description": "…" }
  ],
  "slots": [
    { "name": "label", "required": true, "description": "…" }
  ],
  "events": ["onActivate"],
  "a11y": { "role": "…", "keyboard": ["Enter"], "announces": ["disabled"] },
  "states": ["default", "hover", "focus-visible", "disabled"],
  "tokens": ["color.action.*", "radius.md"]
}
```

## When to use / When not to use

**Use when**
- <!-- situation -->

**Avoid when**
- <!-- situation, and point to the better alternative archetype -->

## Anatomy

<!-- The structural parts (slots) that make up the archetype. Name each part
     and describe its purpose. Mark parts as required or optional. -->

- **Part name** (required) — purpose.
- **Part name** (optional) — purpose.

## States & behavior

<!-- Interaction states and dynamic behavior. Cover the states that apply,
     e.g. default, hover, focus, active, disabled, loading, error, empty,
     selected, expanded. Describe transitions and what triggers them. -->

- **State** — what it looks like / means and how it is entered.

## Variants

<!-- Named, meaningful variations. Describe when to reach for each. -->

- **Variant name** — when and why.

## Layout & responsiveness

<!-- How parts are arranged and how the archetype adapts across viewport
     sizes and containers. Describe reflow/stacking behavior, not pixel values. -->

## Accessibility

<!-- The accessibility contract. Cover keyboard interaction, roles/semantics,
     screen-reader expectations, focus management, and contrast/target-size
     requirements. This section is required for every archetype. -->

- **Keyboard** — <!-- expected keys and focus order -->
- **Semantics** — <!-- roles, landmarks, name/role/value -->
- **Screen reader** — <!-- what is announced -->
- **Focus** — <!-- focus visibility and management -->

## Content guidelines

<!-- Voice, labels, and copy rules. Length limits, capitalization,
     tone, empty/error copy. -->

## Composition

<!-- For composite archetypes, describe the structural wiring in a `json` block:
     each part references another archetype (`ref`), the `slot` it fills, the
     `props` passed to it, and an optional `note`. The registry derives the flat
     `composedOf` list from these refs, so the frontmatter `composedOf:` line can
     be dropped once this block exists. Primitive elements have no parts — leave
     this section as prose ("Not applicable") or omit it. `usedBy` stays in
     frontmatter. -->

```json
{
  "parts": [
    { "ref": "button", "slot": "actions", "props": { "variant": "primary" }, "note": "…" },
    { "ref": "avatar", "slot": "header", "note": "identity" }
  ]
}
```

## Do / Don't

**Do**
- <!-- guidance -->

**Don't**
- <!-- guidance -->

## References

- <!-- prior art, standards, or further reading -->
