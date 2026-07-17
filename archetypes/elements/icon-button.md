---
id: icon-button
title: Icon Button
layer: element
version: 1.0.0
status: stable
summary: A compact, icon-only button that triggers an action where space is tight.
since: 0.3.0
updated: 2026-07-17
tags: [action, control, interactive, icon, compact]
aliases: [icon-btn, square-button]
composedOf: []
usedBy: [toolbar, navbar, data-table, dialog, card]
related: [button, tooltip, toggle]
maintainers: [brnrdog]
implementation: IconButton.res
---

# Icon Button

## Intent

An icon button triggers an action using a glyph alone, trading an explicit text
label for compactness. It suits dense contexts — toolbars, table rows, card
corners — where a full button would crowd the layout. Because it drops the
visible label, it carries a strict obligation: the icon must be recognizable and
the control must still expose an accessible name.

## API

```json
{
  "props": [
    {"name":"variant","type":"enum","values":["solid","ghost"],"default":"ghost","description":"Emphasis."},
    {"name":"label","type":"string","default":"","description":"Accessible name (required; visually hidden)."}
  ],
  "slots": [
    {"name":"icon","required":true,"description":"The single glyph conveying the action."}
  ],
  "events": ["onActivate"],
  "a11y": {"role":"button","keyboard":["Enter","Space"],"announces":["disabled"]},
  "states": ["default","hover","focus-visible","active","disabled"],
  "tokens": ["color.action.*","radius.md"]
}
```

## When to use / When not to use

**Use when**
- Space is constrained and the action's icon is well understood (close, edit,
  more, search).
- Repeating the same action across many rows or items.

**Avoid when**
- The action is important or ambiguous — a labeled **button** communicates better.
- The icon's meaning isn't obvious without a label.

## Anatomy

- **Icon** (required) — a recognizable glyph conveying the action.
- **Hit target** (required) — meets minimum interactive size even when the glyph
  is small.
- **Accessible name** (required) — a visually-hidden label describing the action.
- **Tooltip** (recommended) — reveals the name on hover/focus.

## States & behavior

- **Default / hover / focus (visible) / active** — as a button.
- **Disabled** — not focusable; communicates unavailability in context.
- **Toggle** (optional) — some icon buttons are pressed/unpressed toggles.

Activates on click and `Enter`/`Space`.

## Variants

- **Standalone** — a single compact action.
- **In a group** — several within a toolbar or button group.
- **Emphasis** — solid, subtle, or ghost, mapped to importance.
- **Toggle** — reflects an on/off state.

## Layout & responsiveness

Icon buttons are typically square with the glyph centered. Keep consistent sizing
within a group and honor the minimum touch target regardless of visual size,
expanding the hit area beyond the glyph if needed.

## Accessibility

- **Accessible name** — required; provided via a visually-hidden label or
  equivalent, since there is no visible text.
- **Keyboard** — focusable; activates on `Enter`/`Space`; disabled removes it from
  the tab order.
- **Screen reader** — announces the action name and, for toggles, pressed state.
- **Tooltip** — supplements but never replaces the accessible name.

## Content guidelines

- Choose conventional, unambiguous icons; pair with a tooltip.
- Name the action by its outcome ("Delete row", not "Trash icon").

## Composition

**Composed of:** Not applicable — a primitive; a compact form of the **button**.

**Used by:** toolbar, navbar, data-table, dialog (close), card.

## Do / Don't

**Do**
- Always provide an accessible name and, ideally, a tooltip.
- Keep the target comfortably tappable.

**Don't**
- Use an icon button for a critical or unfamiliar action without a label.
- Rely on the glyph alone to convey meaning to assistive tech.

## References

- WAI-ARIA Authoring Practices — Button pattern; WCAG Target Size.
