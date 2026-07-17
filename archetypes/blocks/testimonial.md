---
id: testimonial
title: Testimonial
layer: block
version: 1.0.0
status: stable
summary: A customer quote with attribution that builds trust through credible social proof.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, landing, section, social-proof, trust]
aliases: [quote, review, social-proof]
composedOf: [avatar, card, badge, typography]
usedBy: [landing-page, pricing]
related: [card, hero]
maintainers: [brnrdog]
---

# Testimonial

## Intent

A testimonial presents a real customer's words to build trust: a quote paired with
who said it. Its power comes from credibility and specificity — a named person,
their role and company, and a concrete outcome — which reassures prospects far
more than the brand describing itself.

## When to use / When not to use

**Use when**
- Reinforcing claims with credible, attributable social proof.

**Avoid when**
- You have no genuine, attributable quote — fabricated proof erodes trust and can
  mislead.

## Anatomy

- **Quote** (required) — the customer's words.
- **Attribution** (required) — name, and ideally role and company.
- **Avatar / logo** (optional) — the person's photo or company mark.
- **Rating / metric** (optional) — a star rating or a quantified result.
- **Source link** (optional) — to the original review or case study.

## States & behavior

- **Static** — presentational.
- **Group** — several testimonials in a grid or a carousel.
- **Featured** — a single prominent quote.

## Variants

- **Single featured quote** — large and prominent.
- **Grid of quotes** — several compact cards.
- **Logo wall + quote** — proof breadth plus a highlighted quote.

## Layout & responsiveness

A single quote centers with generous space; grids reflow to fewer columns and then
a single column on small screens. Keep the attribution visually tied to its quote.

## Accessibility

- **Semantics** — marked up as a quotation with its attribution associated.
- **Media** — avatars/logos carry appropriate text alternatives or are marked
  decorative.
- **Contrast** — text meets contrast; ratings are conveyed by more than color.
- **Carousel** — if used, follows the carousel accessibility contract.

## Content guidelines

- Use real, attributable quotes; keep them specific and concise.
- Include enough attribution to be credible (name, role, company).

## Composition

**Composed of:** avatar, card, badge (rating), typography.

**Used by:** landing-page, pricing.

## Do / Don't

**Do**
- Attribute quotes to real, identifiable people.
- Favor specific outcomes over generic praise.

**Don't**
- Fabricate or anonymize to the point of meaninglessness.
- Rely on color alone to convey ratings.

## References

- Nielsen Norman Group — testimonials and social proof.
