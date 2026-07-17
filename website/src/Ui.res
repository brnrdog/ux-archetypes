// Shared monochrome design tokens (Tailwind class strings) and small helpers
// used across the example implementations and the app shell.

// Read the current value of an input/textarea/select from a DOM event.
let inputValue = (evt: Dom.event): string => %raw(`(e) => (e.target && e.target.value) || ""`)(evt)

let checked = (evt: Dom.event): bool => %raw(`(e) => !!(e.target && e.target.checked)`)(evt)

@val external setTimeout: (unit => unit, int) => unit = "setTimeout"

let preventDefault: Dom.event => unit = %raw(`(e) => { if (e && e.preventDefault) e.preventDefault(); }`)

let copyToClipboard: string => unit = %raw(`(text) => { if (navigator && navigator.clipboard) navigator.clipboard.writeText(text); }`)

// The pressed key name for a keyboard event ("Enter", "Escape", "ArrowDown"…).
let eventKey: Dom.event => string = %raw(`(e) => (e && e.key) || ""`)

// Focus an element by id (deferred a tick so freshly-rendered nodes exist).
let focusById: string => unit = %raw(`(id) => setTimeout(() => { const el = document.getElementById(id); if (el) el.focus(); }, 0)`)

// Register a global Escape handler; returns a disposer.
let onEscape: (unit => unit) => (unit => unit) = %raw(`(cb) => { const h = (e) => { if (e.key === 'Escape') cb(); }; window.addEventListener('keydown', h); return () => window.removeEventListener('keydown', h); }`)

// Register a global ⌘K / Ctrl+K handler; returns a disposer.
let onCmdK: (unit => unit) => (unit => unit) = %raw(`(cb) => { const h = (e) => { if ((e.metaKey || e.ctrlKey) && (e.key === 'k' || e.key === 'K')) { e.preventDefault(); cb(); } }; window.addEventListener('keydown', h); return () => window.removeEventListener('keydown', h); }`)

// Buttons — softer, more modern radius (rounded-lg). Split into layout core,
// size, and color so the Button component can compose variant × size.
let btnCore = "inline-flex items-center justify-center rounded-lg font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-neutral-900 focus-visible:ring-offset-2 focus-visible:ring-offset-white disabled:opacity-40 disabled:pointer-events-none"
let btnLg = "gap-2 px-5 py-2.5 text-base"
let btnMd = "gap-2 px-4 py-2 text-sm"
let btnSm = "gap-1 px-2.5 py-1 text-xs"
let btnPrimaryColors = "bg-neutral-900 text-white hover:bg-neutral-700"
let btnSecondaryColors = "border border-neutral-300 bg-white text-neutral-900 hover:bg-neutral-100"
let btnGhostColors = "text-neutral-700 hover:bg-neutral-100"
let btnDestructiveColors = "bg-neutral-900 text-white ring-1 ring-inset ring-neutral-900 hover:bg-neutral-700"
// Convenience (medium) presets.
let btnPrimary = btnCore ++ " " ++ btnMd ++ " " ++ btnPrimaryColors
let btnSecondary = btnCore ++ " " ++ btnMd ++ " " ++ btnSecondaryColors
let btnGhost = btnCore ++ " " ++ btnMd ++ " " ++ btnGhostColors
let btnDestructive = btnCore ++ " " ++ btnMd ++ " " ++ btnDestructiveColors

// Surfaces
let card = "rounded-2xl border border-neutral-200 bg-white"
let inputBase = "w-full rounded-lg border border-neutral-300 bg-white px-3 py-2 text-sm text-neutral-900 placeholder:text-neutral-400 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-neutral-900 focus-visible:ring-offset-0"
let label = "block text-sm font-medium text-neutral-800"
let muted = "text-neutral-500"

// Layer badge classes (still monochrome — differ by fill weight only)
let layerBadge = layer =>
  switch layer {
  | "element" => "bg-neutral-900 text-white"
  | "component" => "bg-neutral-200 text-neutral-800"
  | "block" => "bg-neutral-100 text-neutral-700 ring-1 ring-inset ring-neutral-300"
  | "page" => "border border-neutral-300 text-neutral-700"
  | _ => "border border-dashed border-neutral-300 text-neutral-500"
  }
