---
id: typography
title: Typography
layer: element
version: 1.0.0
status: stable
summary: The system of text styles — headings, body, and inline elements — that gives content hierarchy and rhythm.
since: 0.2.0
updated: 2026-07-16
tags: [text, hierarchy, content, foundation]
aliases: [text-styles, prose, type-scale]
composedOf: []
usedBy: [card, landing-page, dialog, form]
related: [label, separator]
maintainers: [brnrdog]
---

# Typography

## Intent

Typography is the shared set of text styles — headings, body copy, lists, quotes,
code, and inline emphasis — that gives written content clear hierarchy and
comfortable reading rhythm. It is the connective tissue of nearly every screen;
consistent type is what makes an interface feel coherent.

## When to use / When not to use

**Use when**
- Presenting any textual content that needs hierarchy and legibility.
- Rendering long-form or authored prose ("rich text") consistently.

**Avoid when**
- A value is really a control's label or a status — use **label** or **badge**.

## Anatomy

- **Headings** (required) — a ranked scale (page title down through subsections).
- **Body text** (required) — default reading style with comfortable measure.
- **Inline elements** (optional) — emphasis, strong, links, inline code.
- **Blocks** (optional) — lists, blockquotes, code blocks, captions.
- **Lead / muted** (optional) — intro and secondary text treatments.

## States & behavior

Mostly static. Links carry interactive states; truncated text may reveal full
content on interaction. Text reflows with container width.

## Variants

- **Display / heading scale** — for titles and section headers.
- **Body / lead / small / muted** — reading and secondary styles.
- **Prose block** — a styled container for authored rich text.

## Layout & responsiveness

Constrain body text to a readable measure (line length) and maintain a consistent
vertical rhythm between elements. Scale headings responsively so hierarchy holds
on small and large screens without overwhelming the layout.

## Accessibility

- **Structure** — headings follow a logical, non-skipping order and convey real
  document structure, not just visual size.
- **Readability** — sufficient text contrast and a minimum comfortable size;
  respect user font-size and zoom.
- **Semantics** — emphasis, lists, quotes, and code use meaningful markup, not
  styling alone.

## Content guidelines

- Use one page title; nest subheadings by meaning, not appearance.
- Keep line length readable; avoid overly long measures.
- Reserve emphasis for genuine emphasis.

## Composition

**Composed of:** Not applicable — a foundational element used throughout.

**Used by:** card, landing-page, dialog, form, and essentially every archetype
containing text.

## Do / Don't

**Do**
- Map visual scale to semantic structure.
- Maintain consistent rhythm and readable measure.

**Don't**
- Choose heading levels for size instead of hierarchy.
- Convey meaning through styling alone.

## References

- WCAG — Info and Relationships; Text contrast and resize.
- Practical typography — measure, scale, and rhythm.
