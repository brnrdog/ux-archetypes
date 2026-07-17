// GENERATED FILE — do not edit by hand.
// Run `npm run contracts` (scripts/generate-contracts.mjs) to regenerate.
// Types are derived from the `## API` contracts in the archetype markdown.

module Badge = {
  type variant = [#solid | #soft | #outline]
}

module Button = {
  type variant = [#primary | #secondary | #ghost | #destructive]
  type size = [#sm | #md | #lg]
  type type_ = [#button | #submit | #reset]
}

module IconButton = {
  type variant = [#solid | #ghost]
}

module Link = {
  type variant = [#default | #muted]
}

module RadioGroup = {
  type orientation = [#vertical | #horizontal]
}

module ScrollArea = {
  type orientation = [#vertical | #horizontal | #both]
}

module Separator = {
  type orientation = [#horizontal | #vertical]
}

module Skeleton = {
  type shape = [#text | #circle | #rect]
}

module ToggleGroup = {
  type type_ = [#single | #multiple]
}

module Typography = {
  type variant = [#h1 | #h2 | #h3 | #h4 | #body | #small | #muted | #code]
}
