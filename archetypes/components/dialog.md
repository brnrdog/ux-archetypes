---
id: dialog
title: Dialog
layer: component
version: 1.0.0
status: stable
summary: A modal overlay that focuses the user on a self-contained task or piece of content.
since: 0.2.0
updated: 2026-07-16
tags: [overlay, modal, focus, task]
aliases: [modal, modal-dialog, lightbox]
composedOf: [button, scroll-area, separator]
usedBy: [form, data-table, dashboard, command]
related: [alert-dialog, sheet, drawer, popover]
maintainers: [brnrdog]
---

# Dialog

## Intent

A dialog overlays the page to give a focused, self-contained space for a task or
content — a form, details, a confirmation with body content — while dimming and
disabling the rest of the interface. It concentrates attention without navigating
away, then returns the user exactly where they were.

## When to use / When not to use

**Use when**
- A focused subtask benefits from isolating the user from the page (edit, create,
  view details).
- The user should complete or dismiss before returning to context.

**Avoid when**
- It merely confirms a risky action — use an **alert-dialog**.
- The content is large or navigational — consider a **sheet**/**drawer** or a page.
- Only a small contextual overlay is needed — use a **popover**.

## Anatomy

- **Overlay / scrim** (required) — dims and blocks the background.
- **Container / panel** (required) — the focused surface.
- **Header** (required) — title and close control.
- **Body** (required) — content, scrollable if long.
- **Footer** (optional) — primary and secondary actions.

## States & behavior

- **Open / closed** — modal; the background is inert while open.
- **Scrolling** — long bodies scroll within the panel, keeping header/footer visible.
- **Pending** — actions can show progress.
- **Dismiss** — via close, `Escape`, or scrim click (unless work would be lost).

## Variants

- **Modal** — blocks interaction (default).
- **Non-modal** (rare) — background remains usable.
- **Scrollable / fixed-footer** — for long content.

## Layout & responsiveness

A centered, size-constrained panel over a scrim. On small screens it may go
full-screen or become a sheet. Long content scrolls in the body while the title
and actions stay reachable.

## Accessibility

- **Semantics** — a dialog with its title as accessible name (and body described
  where useful).
- **Keyboard** — focus moves into the dialog on open, is trapped while open, and
  returns to the trigger on close; `Escape` closes.
- **Screen reader** — announces the dialog and its purpose on open.
- **Background** — content behind is inert and hidden from assistive tech.

## Content guidelines

- Title names the task; keep the body focused on one job.
- Use specific action verbs; place the primary action consistently.

## Composition

**Composed of:** button (actions/close), scroll-area, separator.

**Used by:** form, data-table, dashboard, command (as its overlay base).

## Do / Don't

**Do**
- Trap and restore focus; support `Escape`.
- Keep dialogs focused on a single task.

**Don't**
- Stack dialogs on dialogs.
- Discard unsaved work on an accidental scrim click without warning.

## References

- WAI-ARIA Authoring Practices — Dialog (Modal) pattern.
