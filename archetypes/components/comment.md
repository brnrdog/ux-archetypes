---
id: comment
title: Comment
layer: component
version: 1.0.0
status: stable
summary: A single unit of user-authored discussion, with author, content, and actions.
since: 0.4.0
updated: 2026-07-17
tags: [social, discussion, content, thread]
aliases: [comment-item, reply, post]
usedBy: []
related: [list, card, avatar]
maintainers: [brnrdog]
---

# Comment

## Intent

A comment is one contribution to a discussion — who said it, what they said, when,
and what you can do about it (reply, react, edit). It's the repeating unit that
composes threads and activity feeds, so its clarity about authorship and timing,
and its handling of nesting and moderation, shape the whole conversation.

## When to use / When not to use

**Use when**
- Displaying user-authored discussion, feedback, reviews, or activity entries.

**Avoid when**
- The content is system-generated status — use an activity/list item.
- You need a full rich-text document — that's an editor, not a comment.

## Anatomy

- **Author** (required) — avatar and name, with optional role/badge.
- **Timestamp** (required) — when it was posted (relative and absolute).
- **Body** (required) — the comment text (and any attachments).
- **Actions** (optional) — reply, react/like, edit, delete, report.
- **Replies** (optional) — nested child comments or a reply count.
- **Composer** (conditional) — an inline field to reply.

## States & behavior

- **Default** — author, body, meta, and actions.
- **Own comment** — offers edit/delete.
- **Editing** — the body becomes an editable field with save/cancel.
- **Pending / failed** — optimistic post shows a sending or retry state.
- **Deleted / hidden / flagged** — moderated states are indicated clearly.
- **Nested** — replies indent or collapse under a parent.

## Variants

- **Flat** — a simple list of comments.
- **Threaded** — nested replies.
- **Review** — includes a rating.
- **Compact activity** — terse feed entries.

## Layout & responsiveness

Author and timestamp head the item; the body follows; actions sit beneath or on
hover. Nested replies indent, capping depth on small screens (collapsing or
flattening) to preserve readability.

## Accessibility

- **Structure** — author, time, and body are associated; timestamps expose the
  full date.
- **Actions** — reply/edit/etc. are keyboard operable with accessible names;
  icon-only actions are labeled.
- **Live updates** — newly arriving comments are announced politely.
- **Nesting** — reply relationships are conveyed, not implied by indentation alone.

## Content guidelines

- Show relative time with the exact time available on hover/focus.
- Make moderation states (edited, deleted) explicit and honest.

## Composition

```json
{
  "parts": [
    {"ref":"avatar","slot":"author"},
    {"ref":"badge","slot":"author","props":{"variant":"soft"},"note":"role"},
    {"ref":"link","slot":"body"},
    {"ref":"button","slot":"actions"},
    {"ref":"icon-button","slot":"actions"},
    {"ref":"textarea","slot":"composer"}
  ]
}
```

## Do / Don't

**Do**
- Make authorship and timing unmistakable.
- Label icon-only actions and support keyboard use.

**Don't**
- Convey nesting by indentation alone.
- Hide moderation state or fake authorship.

## References

- Nielsen Norman Group — online discussion and comment usability.
