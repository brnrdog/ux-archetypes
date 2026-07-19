// GENERATED FILE — do not edit by hand.
// Run `npm run contracts` (scripts/generate-contracts.mjs) to regenerate.
// Types are derived from the `## API` contracts in the spec markdown.

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

module Icon = {
  type size = [#xs | #sm | #md | #lg | #xl]
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

module Accordion = {
  type type_ = [#single | #multiple]
}

module Alert = {
  type variant = [#info | #success | #warning | #danger]
}

module ButtonGroup = {
  type orientation = [#horizontal | #vertical]
}

module Calendar = {
  type mode = [#single | #range | #multiple]
}

module Carousel = {
  type orientation = [#horizontal | #vertical]
}

module Chart = {
  type type_ = [#bar | #line | #area | #pie]
}

module Drawer = {
  type side = [#left | #right | #top | #bottom]
}

module Resizable = {
  type orientation = [#horizontal | #vertical]
}

module Sheet = {
  type side = [#left | #right | #top | #bottom]
}

module Stat = {
  type trend = [#up | #down | #flat]
}

module Tabs = {
  type orientation = [#horizontal | #vertical]
}

module Toast = {
  type variant = [#info | #success | #warning | #danger]
}

module Toolbar = {
  type orientation = [#horizontal | #vertical]
}

module PricingTable = {
  type interval = [#monthly | #yearly]
}
