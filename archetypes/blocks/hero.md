---
id: hero
title: Hero
layer: block
version: 1.0.0
status: stable
summary: A prominent opening section that states the value proposition and the primary call to action.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, landing, section, conversion]
aliases: [hero-section, banner, masthead]
composedOf: [button, badge, link, typography]
usedBy: [landing-page, pricing]
related: [cta-section, navbar]
maintainers: [brnrdog]
---

# Hero

## Intent

A hero is the first thing a visitor sees: a large opening section that states, in
a few words, what the product is and why it matters, and offers the single most
important next step. It has one job — communicate the value proposition and get
the user to act — so everything in it earns its place toward that goal.

## When to use / When not to use

**Use when**
- Opening a marketing or landing page with a clear value proposition and a
  primary action.

**Avoid when**
- The screen is a working app view — a hero wastes prime space.
- There is no single primary action to feature.

## Anatomy

- **Eyebrow** (optional) — a short tag or announcement above the headline.
- **Headline** (required) — the concise value statement.
- **Subhead** (optional) — a supporting sentence adding specificity.
- **Primary action** (required) — the main call to action; optional secondary.
- **Supporting visual** (optional) — product shot, illustration, or media.
- **Social proof** (optional) — logos, ratings, or a trust line.

## States & behavior

- **Static** — primarily presentational.
- **Media states** — visuals reserve space to avoid layout shift; motion respects
  reduced-motion preferences.
- **Variant/personalized** (optional) — copy may differ by campaign or test while
  the single primary action stays constant.

## Variants

- **Centered** — stacked, centered copy and actions.
- **Split** — copy on one side, visual on the other.
- **Media background** — text over an image/video with sufficient contrast.

## Layout & responsiveness

The headline leads with generous space; actions sit directly beneath. Split
layouts collapse to stacked on small screens with the copy first. Keep the primary
action above the fold and the measure readable.

## Accessibility

- **Structure** — the headline is the page's top heading; the section is a
  landmark or clearly delimited region.
- **Contrast** — text over media meets contrast via overlays/scrims.
- **Keyboard** — actions are fully operable; visuals carry text alternatives.
- **Motion** — background/auto motion respects reduced-motion.

## Content guidelines

- Lead with the benefit to the user, concretely, not adjectives.
- One primary action with a specific verb; keep the subhead to one sentence.

## Composition

**Composed of:** typography, button, badge (eyebrow), link (secondary action).

**Used by:** landing-page, pricing.

## Do / Don't

**Do**
- Keep one clear message and one primary action.
- Front-load the value proposition.

**Don't**
- Stack multiple competing calls to action.
- Bury the message under heavy decorative media.

## References

- Nielsen Norman Group — value proposition and above-the-fold guidance.
