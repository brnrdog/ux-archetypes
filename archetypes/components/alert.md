---
id: alert
title: Alert
layer: component
version: 1.0.0
status: stable
summary: An inline message that draws attention to important, contextual information.
since: 0.2.0
updated: 2026-07-16
tags: [feedback, message, status, inline]
aliases: [callout, banner, notice, inline-message]
composedOf: [button, badge]
usedBy: [form, card, dashboard, settings]
related: [toast, alert-dialog, badge]
maintainers: [brnrdog]
---

# Alert

## Intent

An alert surfaces an important message in the flow of a page — a warning, a tip, a
success confirmation, or an error summary. Unlike a toast, it stays in place and
in context; unlike an alert-dialog, it doesn't interrupt or block the user.

## When to use / When not to use

**Use when**
- Communicating persistent, contextual status tied to a region or the page.
- Summarizing form errors or highlighting a condition users should notice.

**Avoid when**
- The message is transient confirmation — use a **toast**.
- The user must decide before continuing — use an **alert-dialog**.

## Anatomy

- **Icon** (optional) — reinforces severity.
- **Title** (optional) — short headline.
- **Message** (required) — the body text.
- **Actions** (optional) — links or buttons to resolve or learn more.
- **Dismiss** (optional) — close affordance for non-critical alerts.

## States & behavior

- **Severity** — info, success, warning, danger, each with a non-color cue.
- **Dismissible** — can be closed; critical alerts may persist.
- **Live** — an alert that appears in response to an event announces itself.

## Variants

- **Informational / success / warning / destructive**.
- **With actions** — remediation controls.
- **Banner** — full-width, page-level placement.

## Layout & responsiveness

Alerts span their container width, with icon, text, and actions aligned in a row
that wraps gracefully on small screens. Place them near what they concern (top of
a form, above a section).

## Accessibility

- **Semantics** — important, time-sensitive alerts use an assertive live role;
  advisory ones use a polite status. Severity is conveyed by text/icon, not color
  alone.
- **Screen reader** — dynamically shown alerts are announced without moving focus.
- **Keyboard** — any actions and the dismiss control are reachable and operable.

## Content guidelines

- Lead with what happened and what to do next.
- Keep severity vocabulary consistent with badges and toasts.

## Composition

**Composed of:** button (actions), badge (optional severity tag).

**Used by:** form, card, dashboard, settings.

## Do / Don't

**Do**
- Match severity to real importance.
- Offer a clear next step where relevant.

**Don't**
- Overuse high-severity styling.
- Rely on color alone for meaning.

## References

- WAI-ARIA Authoring Practices — Alert and status/live regions.
