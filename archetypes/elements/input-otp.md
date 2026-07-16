---
id: input-otp
title: One-Time-Code Input
layer: element
version: 1.0.0
status: stable
summary: A segmented field for entering a short verification code one character per slot.
since: 0.2.0
updated: 2026-07-16
tags: [form, field, control, verification, security]
aliases: [otp-input, pin-input, code-input, verification-code]
composedOf: []
usedBy: [form, sign-in, dialog]
related: [input, field]
maintainers: [brnrdog]
---

# One-Time-Code Input

## Intent

A one-time-code input collects a short verification code (from SMS, email, or an
authenticator) with one visible slot per character. The segmented layout makes the
expected length obvious, eases review, and pairs naturally with auto-advance and
paste of the full code.

## When to use / When not to use

**Use when**
- Entering a fixed-length numeric or alphanumeric verification code.

**Avoid when**
- The value is free-form or variable length — use a plain **input**.
- A long secret is being entered — use a password input.

## Anatomy

- **Slots** (required) — one per character, fixed count.
- **Active-slot indicator** (required) — shows where input lands next.
- **Separator** (optional) — groups slots (e.g. 3-3).
- **Validation message** (conditional).

## States & behavior

- **Empty / partially filled / complete** — with the active slot highlighted.
- **Auto-advance** — typing moves focus forward; backspace moves back.
- **Paste** — pasting the full code distributes characters across slots.
- **Invalid** — wrong or expired code, with a clear message.
- **Disabled / loading** — during verification.

Completing the last slot may auto-submit.

## Variants

- **Numeric vs. alphanumeric**.
- **Grouped** — visual separators between segments.
- **Masked** — obscured characters for sensitive codes.

## Layout & responsiveness

Slots sit in a single row, evenly spaced, centered in their context. On mobile the
numeric variant surfaces a numeric keypad and integrates with OS code
auto-fill. Keep slots large enough to tap.

## Accessibility

- **Keyboard** — type, backspace, and arrow between slots; paste supported.
- **Semantics** — the control has a single accessible name describing the code;
  slots are not announced as separate meaningless fields.
- **Screen reader** — announces progress and the active position; errors are
  associated and announced.
- **Autofill** — supports platform one-time-code autofill where available.

## Content guidelines

- State where the code was sent and its length/expiry.
- Provide a resend affordance and clear expiry messaging.

## Composition

**Composed of:** Not applicable — a specialized primitive.

**Used by:** form, sign-in, dialog (verification steps).

## Do / Don't

**Do**
- Support paste and OS autofill of the whole code.
- Auto-advance and allow easy correction.

**Don't**
- Force character-by-character typing without paste.
- Hide why a code was rejected.

## References

- WCAG — Labels or Instructions; platform one-time-code autofill guidance.
