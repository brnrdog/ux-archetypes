---
id: cta-section
title: CTA Section
layer: block
version: 1.0.0
status: stable
summary: A focused section that restates the primary action to drive conversion.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, landing, section, conversion]
aliases: [call-to-action, cta-banner, conversion-section]
composedOf: [button, input, link, typography]
usedBy: [landing-page, pricing]
related: [hero, footer]
maintainers: [brnrdog]
---

# CTA Section

## Intent

A CTA section is a focused band, usually near the end of a page, that restates the
one action you want the visitor to take. After they've scrolled the argument, it
gives momentum a place to land — a clear prompt and a single button (or a short
lead-capture) — without the distraction of surrounding content.

## When to use / When not to use

**Use when**
- Re-asserting the page's primary action after the supporting content.
- Capturing a lead with a short prompt (email + submit).

**Avoid when**
- It would introduce a second, competing primary action.
- The page already ends with an equivalent conversion point right above.

## Anatomy

- **Headline** (required) — a short, action-oriented prompt.
- **Supporting line** (optional) — one sentence of reassurance.
- **Primary action** (required) — the button, or a short inline form.
- **Secondary action** (optional) — a lower-emphasis link.
- **Reassurance** (optional) — "no credit card", "cancel anytime".

## States & behavior

- **Static prompt** — a headline and button.
- **Lead capture** — an inline input submits interest, with loading and
  success/error feedback.
- **Emphasis** — often a contrasting band to stand out from the page.

## Variants

- **Button-only** — headline plus a single CTA.
- **Inline form** — email field plus submit.
- **Split** — copy on one side, action on the other.

## Layout & responsiveness

A full-width band with centered (or split) content and the action prominent. Inline
forms stack the field and button on small screens. Keep the single action visually
dominant.

## Accessibility

- **Structure** — a clear heading; the section is a delimited region.
- **Form** — any lead-capture field follows the input/field accessibility contract.
- **Keyboard** — the action and form are fully operable.
- **Contrast** — text and controls meet contrast against the band's background.

## Content guidelines

- One prompt, one primary action, a specific verb.
- Keep any form to the minimum (usually just email).
- Add brief reassurance to lower the perceived cost of acting.

## Composition

**Composed of:** typography, button, input (lead capture), link.

**Used by:** landing-page, pricing.

## Do / Don't

**Do**
- Keep a single, unmistakable action.
- Reduce friction with minimal fields and reassurance.

**Don't**
- Introduce competing calls to action.
- Ask for more than you need to capture interest.

## References

- Nielsen Norman Group — calls to action and conversion.
