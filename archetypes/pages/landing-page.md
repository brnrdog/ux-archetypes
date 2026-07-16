---
id: landing-page
title: Landing Page
layer: page
version: 1.0.0
status: stable
summary: A standalone marketing page designed to convert a focused audience toward a single primary action.
since: 0.1.0
updated: 2026-07-16
tags: [marketing, conversion, page, funnel]
aliases: [landing, marketing-page, splash]
composedOf: [navbar, hero, feature-grid, testimonial, pricing-table, faq, cta-section, footer, button, input]
usedBy: []
related: [dashboard, pricing, sign-in]
maintainers: [brnrdog]
---

# Landing Page

## Intent

A landing page exists to move a specific audience toward **one primary action** —
sign up, request a demo, start a trial, buy. Unlike a general home page, it is
purpose-built and self-contained: every section builds the argument for that one
action, and distractions that don't serve it are removed. Success is measured by
conversion, so clarity and momentum matter more than exhaustiveness.

## When to use / When not to use

**Use when**
- You are driving a defined audience (from an ad, campaign, or referral) toward a
  single conversion goal.
- You need a focused narrative: problem → solution → proof → action.

**Avoid when**
- The user is already inside the product and needs to accomplish work — use a
  **dashboard** or task page.
- The goal is broad navigation to many destinations — that's a home page, not a
  landing page.

## Anatomy

Sections are ordered to build and re-assert the argument; most are optional but
the hero and a primary call to action are required.

- **Navbar** (required) — minimal, conversion-oriented; often just logo + CTA.
- **Hero** (required) — headline, supporting subhead, and the primary CTA above
  the fold; optionally a visual or product shot.
- **Social proof** (optional) — logos, ratings, or user counts that build trust
  early.
- **Feature / benefit sections** (optional) — framed as user outcomes, not raw
  features.
- **Testimonials / case studies** (optional) — credible, specific proof.
- **Pricing** (conditional) — when price is part of the decision.
- **FAQ** (optional) — removes last-mile objections.
- **Closing CTA section** (required) — restates the primary action for users who
  scrolled.
- **Footer** (required) — legal, secondary links, and trust signals.

## States & behavior

- **Default** — static content optimized for scannability.
- **Lead capture** — inline form or CTA that submits interest; shows loading and
  success/error feedback.
- **Empty/loading media** — images and embeds reserve space to avoid layout shift.
- **Personalized / variant (optional)** — content may differ by campaign or A/B
  test; the primary action stays singular.

The primary CTA repeats at natural decision points (hero, after proof, closing)
without introducing competing primary actions.

## Variants

- **Lead-gen** — optimized to capture contact details via a short form.
- **Click-through** — sends the user onward to a sign-up or checkout flow.
- **Product launch** — narrative-heavy, announcement-oriented.
- **App/store redirect** — funnels to an app store or download.

## Layout & responsiveness

A single scrollable column of full-width sections with a constrained content
measure for readability. The hero leads; supporting sections alternate emphasis
to maintain rhythm. Multi-column sections (features, pricing) stack into a single
column on small screens. Keep the primary CTA reachable — recurring in-flow and,
optionally, persistent in the navbar. Design for fast load and no cumulative
layout shift, since landing traffic is often first-touch and impatient.

## Accessibility

- **Structure** — a single, logical heading outline (one page title, then
  sectioned subheadings) so the page is navigable by headings.
- **Landmarks** — header, main, and footer landmarks are present and correct.
- **Keyboard** — every interactive element, including the lead form, is fully
  operable by keyboard in a sensible order.
- **Media** — images have appropriate text alternatives; decorative media is
  marked as such; no essential meaning is carried by color alone.
- **Motion** — respect reduced-motion preferences for animated or autoplaying
  content.
- **Forms** — lead-capture fields follow the input archetype's accessibility
  contract.

## Content guidelines

- Lead with the value to the user, not the product's internals.
- One primary message and one primary action; everything else supports them.
- Keep the hero headline concrete and benefit-led; keep CTAs specific ("Start
  free trial", not "Submit").
- Use proof (numbers, names, quotes) rather than adjectives.

## Composition

**Composed of:** navbar, hero, feature-grid, testimonial, pricing-table, faq,
cta-section, footer — which in turn use elements like button and input.

**Used by:** Not applicable — a landing page is a top-level experience.

## Do / Don't

**Do**
- Keep a single, repeated primary action throughout the page.
- Front-load the value proposition and the CTA above the fold.
- Back claims with specific, credible proof.

**Don't**
- Compete the primary goal with many equally-weighted actions.
- Bury the CTA or make users hunt for the next step.
- Sacrifice load performance and stability for heavy media.

## References

- Nielsen Norman Group — landing page usability guidance.
- WCAG — headings, landmarks, alternatives, and reduced motion.
