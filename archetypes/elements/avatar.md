---
id: avatar
title: Avatar
layer: element
version: 1.0.0
status: stable
summary: A compact visual representation of a person or entity, with a graceful fallback when no image is available.
since: 0.2.0
updated: 2026-07-16
tags: [identity, media, display, user]
aliases: [profile-picture, user-pic, gravatar]
composedOf: []
usedBy: [navbar, card, dropdown-menu, comment, sidebar]
related: [badge, skeleton]
maintainers: [brnrdog]
---

# Avatar

## Intent

An avatar represents a person or entity in a small, recognizable footprint so
users can identify _who_ is associated with content or an action at a glance. It
must degrade gracefully: when an image is missing or slow, it shows a meaningful
fallback rather than a broken graphic.

## When to use / When not to use

**Use when**
- Attributing content or presence to a person or organization.
- Space is limited and identity must be recognizable at small sizes.

**Avoid when**
- You need a large, decorative image — use a plain media element.
- Identity is better carried by a full name label alone.

## Anatomy

- **Image** (optional) — the portrait or logo.
- **Fallback** (required) — initials or a placeholder shown while loading or when
  no image exists.
- **Status/badge overlay** (optional) — presence dot or count, via the badge element.
- **Shape** (required) — circular or rounded-square frame that clips content.

## States & behavior

- **Loading** — shows the fallback (or a skeleton) until the image resolves.
- **Loaded** — shows the image.
- **Error / empty** — remains on the fallback; never a broken image.

## Variants

- **Single** — one image/fallback.
- **Group / stack** — overlapping avatars with an overflow count ("+3").
- **With status** — presence or notification overlay.
- **Sizes** — from inline-small to profile-large, on a consistent scale.

## Layout & responsiveness

Avatars keep a fixed aspect ratio and clip content to their shape. In stacks,
they overlap by a consistent offset and cap the visible count with an overflow
indicator. Sizes come from a defined scale rather than arbitrary values.

## Accessibility

- **Semantics** — provide a text alternative naming the person/entity; decorative
  duplicates of an adjacent name are marked decorative.
- **Screen reader** — announces the accessible name, not the file.
- **Contrast** — fallback text/initials meet contrast against the background.
- **Interactive** — if the avatar is a control (opens a menu), it exposes a
  button/link role with an accessible name.

## Content guidelines

- Prefer initials from the entity's name for the fallback; cap at one or two.
- Keep alt text to the entity name, not "avatar of…".

## Composition

**Composed of:** Not applicable — a primitive; may host a **badge** overlay.

**Used by:** navbar, card, dropdown-menu, sidebar, and any attribution surface.

## Do / Don't

**Do**
- Always provide a fallback and a text alternative.
- Use a consistent size scale and shape.

**Don't**
- Show a broken image when the source fails.
- Encode identity by color alone.

## References

- WAI — text alternatives for images.
