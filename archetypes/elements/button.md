---
id: button
title: Button
layer: element
version: 1.1.0
status: stable
summary: An interactive control that triggers an action or event when activated.
since: 0.1.0
updated: 2026-07-17
tags: [action, control, interactive, form, cta]
aliases: [btn, cta]
composedOf: []
usedBy: [input, navbar, card, form, dialog, landing-page]
related: [link, icon-button]
maintainers: [brnrdog]
implementation: Button.res
---

# Button

## Intent

A button lets a person trigger a single, well-defined action — submit a form,
open a dialog, confirm a choice. It is the most fundamental unit of intent in an
interface: the user says "do this now." A button represents an _action_, not a
_destination_; navigation to another location is the job of a link.

## API

<!-- Machine-readable interface contract. Skin-agnostic: names the axes of
     variation, slots, events, a11y expectations, and the token roles consumed.
     Implementations are checked against this block (npm run conformance). -->

```json
{
  "props": [
    { "name": "variant", "type": "enum", "values": ["primary", "secondary", "ghost", "destructive"], "default": "primary", "description": "Emphasis of the action." },
    { "name": "size", "type": "enum", "values": ["sm", "md", "lg"], "default": "md", "description": "Control density." },
    { "name": "type", "type": "enum", "values": ["button", "submit", "reset"], "default": "button", "description": "Native button behavior in a form." },
    { "name": "disabled", "type": "boolean", "default": "false", "description": "Action unavailable; removed from tab order." },
    { "name": "loading", "type": "boolean", "default": "false", "description": "Async action in flight; blocks re-activation." }
  ],
  "slots": [
    { "name": "label", "required": true, "description": "Verb-led text naming the action." },
    { "name": "leadingIcon", "required": false, "description": "Reinforces meaning." },
    { "name": "trailingIcon", "required": false, "description": "e.g. a chevron opening a menu." }
  ],
  "events": ["onActivate"],
  "a11y": { "role": "button", "keyboard": ["Enter", "Space"], "announces": ["disabled", "busy"] },
  "states": ["default", "hover", "focus-visible", "active", "disabled", "loading"],
  "tokens": ["color.action.*", "radius.md", "space.inline.*", "font.weight.medium"]
}
```

## When to use / When not to use

**Use when**
- The user needs to perform an action (submit, save, delete, add, confirm).
- The action changes state, sends data, or opens a transient surface.

**Avoid when**
- You are navigating to a URL or a new view — use a **link** instead, even if it
  is styled to look like a button.
- The control toggles between two states and should read as on/off — consider a
  **switch** or **checkbox**.

## Anatomy

- **Label** (required for text buttons) — a verb-led phrase naming the action.
- **Container / hit target** (required) — the activatable surface; must meet
  minimum target size even when the visible box is small.
- **Leading icon** (optional) — reinforces meaning; never the sole carrier of it
  unless the button is an explicit icon-only variant with an accessible name.
- **Trailing icon** (optional) — e.g. a chevron indicating a menu will open.
- **Loading indicator** (optional) — replaces or accompanies the label while an
  async action is in flight.

## States & behavior

- **Default** — resting, ready to be activated.
- **Hover** — pointer over the target; signals affordance.
- **Focus (visible)** — reached via keyboard; a clearly visible focus indicator
  is required.
- **Active / pressed** — during activation.
- **Disabled** — action not currently available; not focusable by default and
  communicates why through surrounding context.
- **Loading** — the action is in progress; the button prevents duplicate
  submissions and communicates that work is happening.

Activation fires on click/tap and on `Enter`/`Space` when focused. An async
button should return to an appropriate state (default, or a success/error cue
owned by the surrounding component) when the action resolves.

## Variants

- **Primary** — the single most important action in a given context; used
  sparingly (ideally one per view or section).
- **Secondary** — a supporting action of lower emphasis.
- **Tertiary / ghost** — minimal emphasis for low-stakes actions.
- **Destructive** — actions that remove or irreversibly change data; visually
  distinct and often paired with confirmation.
- **Icon-only** — compact; requires an accessible name and usually a tooltip.

Emphasis is a spectrum expressed through your design tokens; the archetype only
requires that emphasis map to _importance of the action_.

## Layout & responsiveness

Buttons size to their content plus consistent internal padding. In tight
containers they may go full-width to maximize the target. When several buttons
sit together, order them by importance and keep the primary action in the
position your platform conventions expect (e.g. trailing edge in a dialog). On
touch targets, honor the minimum target size regardless of visual size.

## Accessibility

- **Keyboard** — focusable in normal tab order; activates on `Enter` and
  `Space`. Disabled buttons are removed from the tab order.
- **Semantics** — exposes a button role. An icon-only button must have an
  accessible name (visually-hidden label or equivalent).
- **Screen reader** — announces name, role, and state (e.g. disabled, pressed
  for toggle buttons, busy while loading).
- **Focus** — a visible, high-contrast focus indicator is required and must not
  be removed.
- **Target size & contrast** — meet minimum interactive target size and text/icon
  contrast against the button surface.

## Content guidelines

- Lead with a verb and name the outcome: "Save changes", "Delete account".
- Keep labels short (ideally one to three words) and specific; avoid "OK"/"Submit"
  when a precise verb is available.
- Use sentence case unless your brand dictates otherwise, consistently.
- Never rely on color alone to convey a destructive or primary action.

## Composition

**Composed of:** Not applicable — a button is a primitive element.

**Used by:** input (as an inline action), navbar, card, form, dialog, landing-page.

## Do / Don't

**Do**
- Use one clear primary action per context.
- Keep the accessible name and the visible label in agreement.
- Disable and show progress during async work to prevent double submission.

**Don't**
- Use a button to navigate to a URL.
- Fill a screen with primary buttons — emphasis loses meaning.
- Convey the only meaning through an icon without an accessible name.

## References

- WAI-ARIA Authoring Practices — Button pattern.
- Nielsen Norman Group — "Buttons vs. Links".
