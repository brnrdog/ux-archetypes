---
id: link
title: Link
layer: element
version: 1.0.0
status: stable
summary: A navigational control that takes the user to another location or resource.
since: 0.3.0
updated: 2026-07-17
tags: [navigation, text, interactive, anchor]
aliases: [anchor, hyperlink, a]
composedOf: []
usedBy: [navbar, breadcrumb, pagination, navigation-menu, sidebar, footer, sign-in]
related: [button, icon-button]
maintainers: [brnrdog]
implementation: Link.res
---

# Link

## Intent

A link takes the user somewhere — another page, a section of the current page,
or an external resource. It represents _navigation_, not an action: activating a
link changes location, and users rightly expect to be able to open it in a new
tab, copy its address, and go back. This is the defining distinction from a
button, which performs an action in place.

## API

```json
{
  "props": [
    {"name":"variant","type":"enum","values":["default","muted"],"default":"default","description":"Emphasis."},
    {"name":"href","type":"string","default":"#","description":"Destination URL."},
    {"name":"newTab","type":"boolean","default":"false","description":"Open in a new browsing context."}
  ],
  "slots": [
    {"name":"label","required":true,"description":"The link text (describes the destination)."}
  ],
  "events": ["onActivate"],
  "a11y": {"role":"link","keyboard":["Enter"],"announces":["name"]},
  "states": ["default","hover","focus-visible","visited"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Navigating to a URL, a route, an anchor on the page, or a downloadable file.

**Avoid when**
- The control performs an action (submit, delete, open a dialog) — use a
  **button**, even if it should look like a link.
- The target is a compact icon-only affordance — consider an **icon-button** or a
  linked icon with an accessible name.

## Anatomy

- **Label** (required) — descriptive link text that makes sense out of context.
- **Destination** (required) — the address the link resolves to.
- **Affordance** (required) — a visual cue (color, underline) that marks it as a
  link and distinguishes it from surrounding text.
- **External/indicator** (optional) — a marker for links that open in a new tab
  or leave the site.

## States & behavior

- **Default / hover / focus (visible)** — with a clearly visible focus indicator.
- **Visited** (optional) — distinguishes previously followed links.
- **Active** — during activation.
- **Current** — a link to the current page is marked as current (or made inert).

Activation follows the destination on click and on `Enter`. Modifier-click and
context-menu behaviors (open in new tab, copy address) are preserved.

## Variants

- **Inline** — within running text.
- **Standalone** — navigation items, calls to read more.
- **External** — opens in a new context, indicated and announced.
- **Button-styled** — visually a button but still a navigation link.

## Layout & responsiveness

Inline links flow with text and wrap naturally; standalone links align with
their navigation context. Ensure the target area is large enough to tap on touch,
and that underline/spacing keeps adjacent links distinguishable.

## Accessibility

- **Semantics** — exposes a link role with a valid destination; a link without a
  destination is not a link.
- **Keyboard** — focusable in normal order; activates on `Enter`.
- **Screen reader** — the link text is meaningful on its own (avoid "click here");
  external and new-tab behavior is announced.
- **Focus & contrast** — visible focus; link text is distinguishable from body
  text by more than color alone.

## Content guidelines

- Write descriptive link text that names the destination.
- Reserve underline/link styling for actual links.
- Warn when a link opens a new tab or downloads a file.

## Composition

**Composed of:** Not applicable — a primitive element.

**Used by:** navbar, breadcrumb, pagination, navigation-menu, sidebar, footer,
sign-in.

## Do / Don't

**Do**
- Use links for navigation and buttons for actions.
- Keep link text meaningful out of context.

**Don't**
- Style an action button as a link that can't be opened in a new tab.
- Use "click here" or bare URLs as link text.

## References

- WAI-ARIA Authoring Practices — Link pattern.
- Nielsen Norman Group — "Links vs. Buttons".
