---
id: form
title: Form
layer: component
version: 1.0.0
status: stable
summary: A structured set of fields that collects, validates, and submits user input toward a goal.
since: 0.2.0
updated: 2026-07-16
tags: [form, input, validation, data-entry]
aliases: [data-entry, input-form]
composedOf: [field, input, textarea, select, checkbox, radio-group, switch, button, alert]
usedBy: [sign-in, settings, dialog, landing-page]
related: [field, input, dialog]
maintainers: [brnrdog]
---

# Form

## Intent

A form gathers structured input from a user, validates it, and submits it to
accomplish a goal — signing in, creating a record, updating settings. It
orchestrates fields, guidance, validation, and submission into one coherent,
accessible flow, minimizing effort and error.

## When to use / When not to use

**Use when**
- Collecting one or more related values the user reviews and submits.

**Avoid when**
- A single setting applies instantly — a lone **switch** may be enough.
- The interaction is a search box — that's a single input, not a form flow.

## Anatomy

- **Fields** (required) — label + control + help/error (the field archetype).
- **Groups / sections / fieldsets** (optional) — related fields with a legend.
- **Guidance** (optional) — instructions and required-field conventions.
- **Validation feedback** (required) — inline per-field and a summary for errors.
- **Actions** (required) — submit plus optional cancel/reset.
- **Status** (required) — submitting, success, and error states.

## States & behavior

- **Editing** — users enter values; validate at sensible times (blur/submit).
- **Invalid** — inline messages plus an error summary; focus moves to the first
  error on submit.
- **Submitting** — controls disabled or the submit shows progress; prevent double
  submit.
- **Success / error** — clear outcome, preserving input on failure.
- **Dirty** — warn before discarding unsaved changes.

## Variants

- **Single-column** — the recommended default for scannability.
- **Sectioned / multi-step (wizard)** — long forms split into steps with progress.
- **Inline / compact** — short forms (login, search-adjacent).

## Layout & responsiveness

Prefer a single column with a comfortable measure and consistent vertical rhythm;
labels above controls. Group related fields; keep the primary action prominent and
predictably placed. On small screens, fields go full-width.

## Accessibility

- **Semantics** — a form landmark; each control labeled; groups use fieldset/legend.
- **Validation** — errors are programmatically associated with fields, announced,
  and summarized; focus moves to the first error on submit.
- **Keyboard** — logical tab order; submit reachable; Enter submits where expected.
- **Status** — submitting/success/error conveyed via live regions, not color alone.

## Content guidelines

- Ask only for what's needed; explain why for sensitive fields.
- Write specific, actionable error messages; mark required consistently.
- Label the submit with its outcome ("Create account"), not "Submit".

## Composition

**Composed of:** field, input, textarea, select, checkbox, radio-group, switch,
button, alert (error summary).

**Used by:** sign-in, settings, dialog, landing-page (lead capture).

## Do / Don't

**Do**
- Validate helpfully and preserve input on error.
- Prevent duplicate submissions and confirm success.

**Don't**
- Clear the form on a failed submit.
- Rely on placeholders as labels or color alone for errors.

## References

- WCAG — Labels or Instructions; Error Identification, Suggestion, and Prevention.
