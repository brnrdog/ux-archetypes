---
id: toast
title: Toast
layer: component
version: 1.0.0
status: stable
summary: A brief, self-dismissing message that confirms an action or reports a background event.
since: 0.2.0
updated: 2026-07-16
tags: [feedback, notification, transient, status]
aliases: [snackbar, notification, flash-message]
composedOf: [button, progress]
usedBy: [dashboard, form, data-table]
related: [alert, alert-dialog, badge]
maintainers: [brnrdog]
---

# Toast

## Intent

A toast briefly surfaces a low-friction message — "Saved", "Copied", "Upload
failed" — then dismisses itself, confirming an action or reporting a background
event without interrupting the user's flow. It's ephemeral and non-blocking, the
opposite of a dialog.

## When to use / When not to use

**Use when**
- Confirming an action succeeded or a background event occurred.
- Delivering a short, non-critical, transient message.

**Avoid when**
- The message is critical or must be acknowledged — use an **alert-dialog** or a
  persistent **alert**.
- The information must remain available — a toast disappears.

## Anatomy

- **Message** (required) — concise text; optional title.
- **Icon** (optional) — reinforces status.
- **Action** (optional) — a single quick action (e.g. "Undo").
- **Dismiss** (optional) — manual close.
- **Timer / progress** (optional) — indicates auto-dismiss.

## States & behavior

- **Enter / visible / exit** — appears, persists briefly, then auto-dismisses.
- **Pause on interaction** — hover/focus pauses the timer so it can be read/acted on.
- **Stacking** — multiple toasts queue or stack with sensible limits.
- **Severity** — success, info, warning, error (with non-color cues).

## Variants

- **Simple** — text only.
- **With action** — e.g. undo.
- **Promise-driven** — loading → success/error for async tasks.

## Layout & responsiveness

Anchored to a screen corner/edge, stacking a limited number and collapsing
overflow. On small screens they typically span the width near an edge. They never
block content beneath.

## Accessibility

- **Semantics** — announced via a live region: polite for routine confirmations,
  assertive for errors — without stealing focus.
- **Timing** — auto-dismiss is long enough to read; pauses on hover/focus;
  actionable toasts persist or are easily recoverable.
- **Keyboard** — actions and dismiss are keyboard-reachable while present.
- **Non-color** — severity conveyed by text/icon, not color alone.

## Content guidelines

- One short, clear sentence; lead with the outcome.
- Offer at most one action; keep error toasts actionable.

## Composition

**Composed of:** button (action/dismiss), progress (timer indicator).

**Used by:** dashboard, form, data-table (operation feedback).

## Do / Don't

**Do**
- Announce politely/assertively per severity without moving focus.
- Pause auto-dismiss on hover/focus.

**Don't**
- Put critical, must-act information in a transient toast.
- Auto-dismiss so fast it can't be read or acted on.

## References

- WAI-ARIA Authoring Practices — Alert and status/live region guidance.
