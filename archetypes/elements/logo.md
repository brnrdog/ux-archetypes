---
id: logo
title: Logo
layer: element
version: 1.0.0
status: stable
summary: A brand mark that identifies the product or organization and usually links home.
since: 0.4.0
updated: 2026-07-17
tags: [brand, identity, navigation, display]
aliases: [brand, brandmark, wordmark]
composedOf: []
usedBy: [navbar, footer, sign-in]
related: [icon, link]
maintainers: [brnrdog]
---

# Logo

## Intent

A logo is the brand's mark in the interface — a wordmark, symbol, or lockup that
identifies whose product this is. Beyond identity, it plays a functional role:
placed in the navbar it is the conventional "home" affordance users reach for,
and it anchors trust on auth and marketing pages.

## API

```json
{
  "props": [
    {"name":"href","type":"string","default":"/","description":"Where the logo links (usually home)."},
    {"name":"size","type":"string","default":"md","description":"Rendered size."}
  ],
  "slots": [
    {"name":"mark","required":false,"description":"The symbol/glyph."},
    {"name":"wordmark","required":false,"description":"The set brand name."}
  ],
  "a11y": {"role":"link","announces":["brand name"]},
  "states": ["default","hover","focus-visible"],
  "tokens": ["color.neutral.*"]
}
```

## When to use / When not to use

**Use when**
- Establishing brand identity in a navbar, footer, or auth/marketing header.
- Providing the conventional link back to the home page.

**Avoid when**
- Space is so tight the mark becomes illegible — use a compact symbol-only form.

## Anatomy

- **Mark** (required) — the wordmark, symbol, or combined lockup.
- **Clear space** (required) — protective padding around the mark.
- **Link target** (optional) — typically home when placed in navigation.
- **Responsive forms** (optional) — full lockup vs. symbol-only.

## States & behavior

- **Static identity** — in most placements.
- **Interactive** — when it links home, it carries link states and an accessible
  name.
- **Theme variants** — light/dark or monochrome forms for different surfaces.

## Variants

- **Wordmark** — the name set in the brand type.
- **Symbol / icon** — the mark alone, for compact spaces.
- **Lockup** — symbol plus wordmark.

## Layout & responsiveness

The logo sits at the leading edge of headers with protected clear space. On small
screens it may reduce to a symbol-only form. Maintain minimum size for legibility
and never distort the mark.

## Accessibility

- **Accessible name** — provides the brand/organization name as its text
  alternative (e.g. "Acme home" when it links home).
- **Interactive** — when linking, exposes a link role and is keyboard operable.
- **Contrast** — legible against its surface; provide theme-appropriate variants.

## Content guidelines

- Use the approved mark and clear space; don't recolor or distort it.
- When it links home, name it accordingly.

## Composition

**Composed of:** Not applicable — a brand asset (a specialized image/icon).

**Used by:** navbar, footer, sign-in.

## Do / Don't

**Do**
- Preserve clear space and minimum size.
- Give a linked logo an accessible name.

**Don't**
- Stretch, recolor, or crowd the mark.
- Rely on the logo alone for navigation without a name.

## References

- WAI — text alternatives for images and logos.
