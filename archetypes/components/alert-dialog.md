---
id: alert-dialog
title: Alert Dialog
layer: component
version: 1.0.0
status: stable
summary: A blocking modal that interrupts to confirm a consequential or irreversible action.
since: 0.2.0
updated: 2026-07-16
tags: [modal, confirmation, overlay, destructive]
aliases: [confirm-dialog, confirmation-modal]
usedBy: [data-table, settings, form]
related: [dialog, alert, toast]
traits: [focus-trap]
maintainers: [brnrdog]
---

# Alert Dialog

## Intent

An alert dialog interrupts the user to confirm an action that is consequential or
hard to undo — deleting data, discarding changes, or canceling a running job. It
demands an explicit decision before anything continues, making it distinct from a
general-purpose dialog used for tasks and forms.

## API

```json
{
  "props": [
    {"name":"open","type":"boolean","default":"false","description":"Whether the dialog is shown."}
  ],
  "slots": [
    {"name":"title","required":true},
    {"name":"description","required":true},
    {"name":"cancel","required":true},
    {"name":"confirm","required":true},
    {"name":"surface","required":false,"description":""},
    {"name":"actions","required":false,"description":""}
  ],
  "events": ["onConfirm","onCancel"],
  "a11y": {"role":"alertdialog","keyboard":["Tab","Escape"],"announces":["name","description"]},
  "states": ["closed","open"],
  "tokens": ["color.neutral.*","radius.lg"]
}
```

## When to use / When not to use

**Use when**
- Confirming a destructive or irreversible action.
- A decision must be made before proceeding.

**Avoid when**
- The task is routine or non-destructive — use a **dialog**.
- The message is informational only — use an **alert** or **toast**.

## Anatomy

- **Overlay / scrim** (required) — blocks and dims the background.
- **Title** (required) — states the decision plainly.
- **Description** (required) — the consequence, especially for destructive acts.
- **Confirm action** (required) — clearly labeled, styled to match risk.
- **Cancel action** (required) — the safe way out.

## States & behavior

- **Open / closed** — modal while open; background inert.
- **Pending** — confirm shows progress during async work.
- **Focus trapped** — focus stays within until dismissed.

`Escape` and the cancel action dismiss without acting. The safe option is the
default focus target.

## Variants

- **Confirm / cancel** — standard two-action.
- **Destructive** — confirm emphasized as dangerous.
- **Type-to-confirm** — requires typing a phrase for high-risk actions.

## Layout & responsiveness

A centered, size-constrained panel over a scrim, with actions grouped by
convention (safe vs. risky). On small screens it adapts to available width while
keeping actions reachable.

## Accessibility

- **Semantics** — an alert-dialog role with the title and description associated
  as its name and message.
- **Keyboard** — focus moves into the dialog on open, is trapped while open, and
  returns to the trigger on close; `Escape` cancels.
- **Screen reader** — announces as an alert dialog with its consequence text.
- **Focus default** — the non-destructive action receives initial focus.

## Content guidelines

- Title names the action; buttons use specific verbs ("Delete", "Discard"), not
  "Yes/No".
- Describe the consequence and whether it can be undone.

## Composition

```json
{
  "parts": [
    {"ref":"dialog","slot":"surface"},
    {"ref":"button","slot":"actions","props":{"variant":"primary"}}
  ]
}
```

## Do / Don't

**Do**
- Default focus to the safe choice.
- Name actions by their outcome.

**Don't**
- Use blocking confirmation for trivial actions.
- Make the destructive action the easiest to hit by accident.

## References

- WAI-ARIA Authoring Practices — Alert Dialog pattern.
