---
id: navbar
title: Navbar
layer: component
version: 1.0.0
status: stable
summary: A persistent top-level bar that anchors identity and primary navigation across a product.
since: 0.1.0
updated: 2026-07-16
tags: [navigation, header, layout, wayfinding]
aliases: [navbar, top-nav, header, app-bar]
usedBy: [landing-page, dashboard, settings]
related: [sidebar, tabs, breadcrumb, footer]
maintainers: [brnrdog]
---

# Navbar

## Intent

A navbar is the primary wayfinding surface of a product. It stays present across
screens to answer three questions at a glance: _where am I_, _where can I go_,
and _what can I do from anywhere_. It anchors brand identity and the top level of
the information architecture, and it hosts the handful of global actions (search,
account, primary call to action) that should be reachable from every page.

## When to use / When not to use

**Use when**
- A product needs consistent, always-available top-level navigation and identity.
- The primary sections number roughly two to seven and benefit from horizontal
  exposure.

**Avoid when**
- Navigation is deep or has many peer sections — a **sidebar** scales better.
- The screen is a focused, single-task flow (checkout, onboarding step) where a
  minimal header reduces distraction.

## Anatomy

- **Brand / logo** (required) — identity; typically links to home.
- **Primary navigation** (required) — the top-level destinations.
- **Global actions** (optional) — search, primary CTA, notifications.
- **Account / user menu** (optional) — avatar opening account and session actions.
- **Menu toggle** (conditional) — reveals collapsed navigation on small screens.
- **Active indicator** (required when nav is present) — shows the current section.

## States & behavior

- **Default** — resting bar with current section indicated.
- **Sticky / scrolled** (optional) — remains pinned; may compact or gain a
  shadow to separate from content.
- **Collapsed (mobile)** — primary navigation is hidden behind a menu toggle
  that opens a drawer or overlay.
- **Menu open** — a disclosed menu (account, or the mobile drawer) with managed
  focus.
- **Authenticated vs. anonymous** — the action cluster differs (e.g. "Sign in"
  vs. account menu).

The current-location indicator updates as the user navigates. Opening a menu
traps focus appropriately and closes on `Escape` and outside interaction.

## Variants

- **Marketing navbar** — logo, a few section links, and a prominent CTA;
  optimized for conversion.
- **Application navbar** — adds search, notifications, and an account menu for
  signed-in product use.
- **Minimal header** — logo and at most one action, for focused flows.
- **Centered vs. leading** — brand and navigation alignment variations.

## Layout & responsiveness

On wide viewports, parts lay out horizontally: brand at the leading edge,
navigation adjacent or centered, actions at the trailing edge. As width
decreases, secondary items collapse first, then primary navigation moves behind a
menu toggle into a drawer or overlay. The bar keeps a consistent height and
predictable landmark position. If sticky, it must not obscure content behind it
(anchor targets and scroll offsets account for its height).

## Accessibility

- **Keyboard** — every destination and action is reachable and operable by
  keyboard; logical focus order from brand to navigation to actions.
- **Semantics** — exposed as a navigation landmark with an accessible name; the
  current item is marked as current.
- **Screen reader** — announces the landmark, item names, and current state;
  disclosed menus announce expanded/collapsed.
- **Focus** — opening the mobile drawer or a menu moves focus into it, traps it
  while open, and restores it on close; `Escape` closes.
- **Target size** — touch targets meet minimum size, especially the menu toggle.

## Content guidelines

- Label sections with short, distinct nouns that match their destination titles.
- Keep top-level items few; demote the long tail into menus or a sidebar.
- Give the primary CTA a specific verb; don't compete with multiple primaries.

## Composition

```json
{
  "parts": [
    {"ref":"logo","slot":"brand","note":"links home"},
    {"ref":"link","slot":"nav"},
    {"ref":"input","slot":"actions","note":"search"},
    {"ref":"button","slot":"actions","props":{"variant":"primary"}},
    {"ref":"dropdown-menu","slot":"account"},
    {"ref":"avatar","slot":"account"}
  ]
}
```

## Do / Don't

**Do**
- Keep the current location obvious at all times.
- Preserve landmark position and identity across pages.
- Collapse gracefully to a menu on small screens with proper focus management.

**Don't**
- Overload the bar with more top-level items than can be scanned at a glance.
- Hide essential actions behind unlabeled icons.
- Let a sticky bar cover the content it links to.

## References

- WAI-ARIA Authoring Practices — landmark and menu/disclosure patterns.
- Nielsen Norman Group — navigation and information architecture guidance.
