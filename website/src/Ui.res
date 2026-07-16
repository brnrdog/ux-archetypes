// Shared monochrome design tokens (Tailwind class strings) and small helpers
// used across the example implementations and the app shell.

// Read the current value of an input/textarea/select from a DOM event.
let inputValue = (evt: Dom.event): string => %raw(`(e) => (e.target && e.target.value) || ""`)(evt)

let checked = (evt: Dom.event): bool => %raw(`(e) => !!(e.target && e.target.checked)`)(evt)

@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

let preventDefault: Dom.event => unit = %raw(`(e) => { if (e && e.preventDefault) e.preventDefault(); }`)

let copyToClipboard: string => unit = %raw(`(text) => { if (navigator && navigator.clipboard) navigator.clipboard.writeText(text); }`)

// Buttons
let btnBase = "inline-flex items-center justify-center gap-2 rounded-md px-4 py-2 text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-neutral-900 focus-visible:ring-offset-2 focus-visible:ring-offset-white disabled:opacity-40 disabled:pointer-events-none"
let btnPrimary = btnBase ++ " bg-neutral-900 text-white hover:bg-neutral-700"
let btnSecondary = btnBase ++ " border border-neutral-300 bg-white text-neutral-900 hover:bg-neutral-100"
let btnGhost = btnBase ++ " text-neutral-700 hover:bg-neutral-100"
let btnDestructive = btnBase ++ " bg-neutral-900 text-white ring-1 ring-inset ring-neutral-900 hover:bg-neutral-700"

// Surfaces
let card = "rounded-lg border border-neutral-200 bg-white"
let inputBase = "w-full rounded-md border border-neutral-300 bg-white px-3 py-2 text-sm text-neutral-900 placeholder:text-neutral-400 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-neutral-900 focus-visible:ring-offset-0"
let label = "block text-sm font-medium text-neutral-800"
let muted = "text-neutral-500"

// Layer badge classes (still monochrome — differ by fill weight only)
let layerBadge = layer =>
  switch layer {
  | "element" => "bg-neutral-900 text-white"
  | "component" => "bg-neutral-200 text-neutral-800"
  | "page" => "border border-neutral-300 text-neutral-700"
  | _ => "border border-dashed border-neutral-300 text-neutral-500"
  }
