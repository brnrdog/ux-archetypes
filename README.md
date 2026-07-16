# UX Archetypes

A collection of **User Experience (UX) Archetypes** — reusable, technology-agnostic
definitions of UI patterns written in words, meant to be used as a shared
reference for design and implementation by both **humans and AI agents**. They span
the full experience: from the smallest interface element up to complete pages and
flows.

> An archetype is an original model, perfect example, or universal pattern upon
> which other things are copied or based. From the Greek _archein_ (to begin)
> and _typos_ (a mold or pattern).

In this repository an archetype describes **what** a pattern _is_, **when** to
use it, how it is **composed**, how it **behaves**, and how it stays
**accessible** — without prescribing a framework, styling approach, or a single
visual design. That makes each archetype portable across projects, contexts,
and tech stacks while keeping the meaning of the pattern consistent everywhere.

---

## Why this exists

Design systems and component libraries get re-invented on every project and
every stack. The visual skin and the framework change, but the underlying
_pattern_ — what a Button is, what a Navbar must do, what a Landing Page is
for — does not. This repository captures those stable patterns once, so they
can be:

- **Reused** across projects and stacks (React, Vue, SwiftUI, design tools, …).
- **Referenced** by AI agents as a source of truth when generating UI.
- **Composed** from small units into components and full pages.
- **Versioned** so changes are explicit and traceable.

An archetype is a _specification of intent and structure_, not an
implementation. Each project maps archetypes onto its own tokens, framework,
and visual language.

---

## Taxonomy: layers

Archetypes are organized into **layers**, from the smallest unit to the
complete experience. The structure is intentionally flat: one directory per
layer, one Markdown file per archetype.

| Layer          | Directory                | What it is | Examples |
| -------------- | ------------------------ | ---------- | -------- |
| **Element**    | `archetypes/elements/`   | An indivisible UI unit with a single responsibility. | button, input, badge, avatar, icon, checkbox, spinner |
| **Component**  | `archetypes/components/` | A self-contained pattern composed of elements. | navbar, card, form, modal, data-table, tabs |
| **Page**       | `archetypes/pages/`      | A full-screen archetype composing components toward one goal. | landing-page, dashboard, sign-in, pricing, settings |

> **Extension point — Flows.** A sequence of pages toward an outcome
> (onboarding, checkout, auth). Flows are a natural fourth layer
> (`archetypes/flows/`) and follow the same document pattern; add them when you
> start describing multi-page journeys rather than single screens.

The layer of an archetype is declared in its metadata (`layer:`) **and**
reflected by the directory it lives in. Keeping both in sync is the only
structural rule.

### File & naming conventions

- One archetype per file: `archetypes/<layer-plural>/<id>.md`.
- `id` is a lowercase, kebab-case slug and must be unique across the whole
  collection (e.g. `button`, `data-table`, `landing-page`).
- The `id` in the metadata must match the filename.

---

## The archetype document

Every archetype follows the **same document pattern** so they are predictable
for both readers and machines. A document has two parts:

1. **Metadata** — a YAML frontmatter block at the top (see
   [`schema/archetype.schema.json`](schema/archetype.schema.json)).
2. **Body** — a fixed set of sections (see
   [`templates/ARCHETYPE_TEMPLATE.md`](templates/ARCHETYPE_TEMPLATE.md)).

### Metadata fields

| Field         | Required | Description |
| ------------- | :------: | ----------- |
| `id`          | ✅ | Unique kebab-case slug; matches the filename. |
| `title`       | ✅ | Human-readable name. |
| `layer`       | ✅ | `element` \| `component` \| `page` \| `flow`. |
| `version`     | ✅ | Semantic version **of this archetype** (independent of the collection). |
| `status`      | ✅ | `draft` \| `stable` \| `deprecated`. |
| `summary`     | ✅ | One-sentence description of intent. |
| `since`       | ✅ | Collection version in which the archetype first appeared. |
| `updated`     | ✅ | ISO date (`YYYY-MM-DD`) of the last meaningful change. |
| `tags`        |   | Free-form keywords for discovery. |
| `aliases`     |   | Alternative names people search for. |
| `composedOf`  |   | `id`s of archetypes this one is built from. |
| `usedBy`      |   | `id`s of archetypes that commonly include this one. |
| `related`     |   | `id`s of adjacent archetypes worth comparing. |
| `maintainers` |   | People accountable for the archetype. |

`composedOf` / `usedBy` turn the collection into a **linked graph**: you can
walk from a page down to the elements it relies on, or from an element up to
everything that uses it.

### Body sections

The body is always the same ordered set of sections. Sections that do not apply
to a given archetype are kept with a short _“Not applicable”_ note rather than
removed, so the shape stays constant.

1. **Intent** — the problem it solves and the value it provides.
2. **When to use / When not to use** — selection guidance and alternatives.
3. **Anatomy** — the structural parts (slots) that make it up.
4. **States & behavior** — interaction states and dynamic behavior.
5. **Variants** — named, meaningful variations.
6. **Layout & responsiveness** — arrangement and how it adapts across sizes.
7. **Accessibility** — keyboard, screen-reader, focus, and contrast requirements.
8. **Content guidelines** — voice, labels, and copy rules.
9. **Composition** — what it is composed of and what composes it.
10. **Do / Don't** — concise usage guidance.
11. **References** — prior art and further reading.

---

## Versioning

The collection uses **[Semantic Versioning](https://semver.org/)** at two levels.

### Collection version

Tracked in [`VERSION`](VERSION), [`package.json`](package.json), and
[`CHANGELOG.md`](CHANGELOG.md).

- **MAJOR** — a breaking change to the document pattern or metadata schema, or
  the removal of an archetype.
- **MINOR** — a new archetype is added, or a backward-compatible addition to the
  template/schema.
- **PATCH** — clarifications, fixes, and content refinements that don't change
  the structure.

### Per-archetype version

Each archetype carries its own `version` in metadata, using the same rules
scoped to that single document:

- **MAJOR** — the meaning/anatomy changes in a way that would break existing
  implementations.
- **MINOR** — a new variant, state, or section content is added compatibly.
- **PATCH** — wording and clarity fixes.

The `status` field describes lifecycle: `draft` (in progress), `stable` (safe to
build on), `deprecated` (kept for reference, avoid in new work).

---

## Using archetypes in a project

Archetypes are stack-agnostic on purpose. To adopt them:

1. **Pick** the archetypes you need (start from [`INDEX.md`](INDEX.md)).
2. **Map** each one onto your design tokens and framework — the archetype tells
   you the required parts, states, and accessibility contract; your project
   decides the visual language and code.
3. **Point your AI agents at it.** Because the format is consistent and
   machine-readable, an agent can read an archetype and scaffold a compliant
   implementation for your stack, then you review against the same document.

Consume the collection however suits you: git submodule, vendored copy, or the
published package metadata in `package.json`.

---

## Repository layout

```
ux-archetypes/
├── README.md                     # this file
├── CONTRIBUTING.md               # how to add or change an archetype
├── CHANGELOG.md                  # semver history of the collection
├── VERSION                       # current collection version
├── package.json                  # version + distribution metadata
├── INDEX.md                      # registry of all archetypes
├── schema/
│   └── archetype.schema.json     # JSON Schema for the frontmatter metadata
├── templates/
│   └── ARCHETYPE_TEMPLATE.md     # canonical document pattern to copy
└── archetypes/
    ├── elements/                 # indivisible units (button, input, badge, …)
    ├── components/               # composed patterns (navbar, card, dialog, …)
    └── pages/                    # full-screen experiences (landing-page, …)
```

See [`INDEX.md`](INDEX.md) for the full, current list of archetypes.

---

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). In short: copy the template, fill in
the metadata and every section, keep the `id`/filename/layer in sync, and bump
the versions and changelog.

## License

[MIT](LICENSE).
