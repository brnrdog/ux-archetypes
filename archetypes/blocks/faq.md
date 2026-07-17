---
id: faq
title: FAQ
layer: block
version: 1.0.0
status: stable
summary: A list of common questions with expandable answers that removes last-mile objections.
since: 0.4.0
updated: 2026-07-17
tags: [marketing, landing, content, support, disclosure]
aliases: [faqs, questions, help-list]
composedOf: [accordion, link]
usedBy: [landing-page, pricing]
related: [accordion, empty-state]
maintainers: [brnrdog]
---

# FAQ

## Intent

An FAQ answers the questions that block a decision — pricing details, limits,
security, cancellation — in one scannable place. By surfacing common objections and
answering them plainly, it removes friction late in the funnel and reduces support
load, letting users self-serve the reassurance they need.

## When to use / When not to use

**Use when**
- A handful of recurring questions predictably stand between users and acting.

**Avoid when**
- The content is really documentation — link to proper docs instead.
- "Questions" are marketing copy in disguise — answer honestly or omit.

## Anatomy

- **Section heading** (optional) — introduces the FAQ.
- **Question items** (required) — each a question header and an expandable answer.
- **Answers** (required) — concise, with links to detail where useful.
- **Escape hatch** (optional) — a link to contact support or full docs.

## States & behavior

- **Collapsed / expanded** — per item, toggled by its header (an accordion).
- **Single vs. multiple open** — one at a time, or several.
- **Deep-linkable** (optional) — a specific question can be linked and opened.

## Variants

- **Accordion** — collapsible Q&A (the common default).
- **Two-column list** — questions and answers shown fully in columns.
- **Categorized** — grouped by topic.

## Layout & responsiveness

A single readable column of question rows; answers expand in place, pushing content
below. Two-column variants collapse to one column on small screens. Keep questions
short and scannable.

## Accessibility

- **Disclosure semantics** — each question is a button controlling its answer,
  exposing expanded/collapsed state (the accordion pattern).
- **Keyboard** — headers are focusable and toggle on `Enter`/`Space`.
- **Screen reader** — announces the question, state, and answer relationship.
- **Structure** — questions participate in a sensible heading order.

## Content guidelines

- Write real questions in the user's words; answer directly and briefly.
- Link to detail rather than expanding into documentation.

## Composition

**Composed of:** accordion, link.

**Used by:** landing-page, pricing.

## Do / Don't

**Do**
- Answer the questions that actually block decisions.
- Keep answers concise with links to more.

**Don't**
- Use the FAQ as disguised marketing copy.
- Bury essential information only inside collapsed answers.

## References

- WAI-ARIA Authoring Practices — Accordion/Disclosure patterns.
