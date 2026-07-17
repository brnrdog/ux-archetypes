// Live theme settings. The whole site is driven by the design tokens compiled
// to CSS custom properties (see tokens.generated.css), so re-theming at runtime
// is just overriding those `--color-*` / `--radius-*` / `--font-sans` variables
// on :root. Choices persist in localStorage and re-apply on load.

// --- Raw DOM / storage helpers -------------------------------------------------
let setVar: (string, string) => unit = %raw(`(k, v) => document.documentElement.style.setProperty(k, v)`)
let store: (string, string) => unit = %raw(`(k, v) => { try { localStorage.setItem(k, v) } catch (e) {} }`)
let removeStore: string => unit = %raw(`(k) => { try { localStorage.removeItem(k) } catch (e) {} }`)
let read: string => string = %raw(`(k) => { try { return localStorage.getItem(k) || "" } catch (e) { return "" } }`)
let readOr = (k, d) => {
  let v = read(k)
  v == "" ? d : v
}

// --- Presets -------------------------------------------------------------------
// Accent tints the dark end of the neutral ramp, so primary buttons, focus
// rings, active nav, solid badges, and headings pick up the hue while body text
// (a separate --ux-color-ink var) stays readable.
let accents = [
  ("monochrome", "Mono", "#262626"),
  ("indigo", "Indigo", "#3730a3"),
  ("emerald", "Emerald", "#065f46"),
  ("sky", "Sky", "#075985"),
  ("rose", "Rose", "#9f1239"),
  ("amber", "Amber", "#92400e"),
]
let accentVars = id =>
  switch id {
  | "indigo" => [("--color-neutral-700", "#4338ca"), ("--color-neutral-800", "#3730a3"), ("--color-neutral-900", "#312e81"), ("--color-neutral-950", "#1e1b4b")]
  | "emerald" => [("--color-neutral-700", "#047857"), ("--color-neutral-800", "#065f46"), ("--color-neutral-900", "#064e3b"), ("--color-neutral-950", "#022c22")]
  | "sky" => [("--color-neutral-700", "#0369a1"), ("--color-neutral-800", "#075985"), ("--color-neutral-900", "#0c4a6e"), ("--color-neutral-950", "#082f49")]
  | "rose" => [("--color-neutral-700", "#be123c"), ("--color-neutral-800", "#9f1239"), ("--color-neutral-900", "#881337"), ("--color-neutral-950", "#4c0519")]
  | "amber" => [("--color-neutral-700", "#b45309"), ("--color-neutral-800", "#92400e"), ("--color-neutral-900", "#78350f"), ("--color-neutral-950", "#451a03")]
  | _ => [("--color-neutral-700", "#404040"), ("--color-neutral-800", "#262626"), ("--color-neutral-900", "#171717"), ("--color-neutral-950", "#0a0a0a")]
  }

let radii = [("sharp", "Sharp"), ("default", "Default"), ("rounded", "Rounded")]
let radiusVars = id =>
  switch id {
  | "sharp" => [("--radius-sm", "0.125rem"), ("--radius-md", "0.1875rem"), ("--radius-lg", "0.25rem"), ("--radius-xl", "0.375rem"), ("--radius-2xl", "0.5rem"), ("--radius-3xl", "0.75rem")]
  | "rounded" => [("--radius-sm", "0.5rem"), ("--radius-md", "0.75rem"), ("--radius-lg", "1rem"), ("--radius-xl", "1.5rem"), ("--radius-2xl", "2rem"), ("--radius-3xl", "2.5rem")]
  | _ => [("--radius-sm", "0.375rem"), ("--radius-md", "0.5rem"), ("--radius-lg", "0.75rem"), ("--radius-xl", "1rem"), ("--radius-2xl", "1.25rem"), ("--radius-3xl", "1.75rem")]
  }

let fonts = [("inter", "Inter"), ("system", "System"), ("serif", "Serif"), ("mono", "Mono")]
let fontValue = id =>
  switch id {
  | "system" => `system-ui, -apple-system, "Segoe UI", Roboto, sans-serif`
  | "serif" => `Georgia, Cambria, "Times New Roman", serif`
  | "mono" => `ui-monospace, SFMono-Regular, Menlo, Consolas, monospace`
  | _ => `Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif`
  }

// --- State + apply -------------------------------------------------------------
let open_ = Signal.make(false)
let accentSel = Signal.make(readOr("ux.accent", "monochrome"))
let radiusSel = Signal.make(readOr("ux.radius", "default"))
let fontSel = Signal.make(readOr("ux.font", "inter"))

let applyPairs = pairs => pairs->Array.forEach(pair => {
  let (k, v) = pair
  setVar(k, v)
})

let setAccent = id => {
  Signal.set(accentSel, id)
  applyPairs(accentVars(id))
  store("ux.accent", id)
}
let setRadius = id => {
  Signal.set(radiusSel, id)
  applyPairs(radiusVars(id))
  store("ux.radius", id)
}
let setFont = id => {
  Signal.set(fontSel, id)
  setVar("--font-sans", fontValue(id))
  store("ux.font", id)
}

// Apply persisted choices (called once at startup).
let load = () => {
  applyPairs(accentVars(Signal.get(accentSel)))
  applyPairs(radiusVars(Signal.get(radiusSel)))
  setVar("--font-sans", fontValue(Signal.get(fontSel)))
}

let reset = () => {
  setAccent("monochrome")
  setRadius("default")
  setFont("inter")
  removeStore("ux.accent")
  removeStore("ux.radius")
  removeStore("ux.font")
}

// --- UI ------------------------------------------------------------------------
module Trigger = {
  @jsx.component
  let make = () =>
    <IconButton label="Theme settings" onClick={_ => Signal.update(open_, v => !v)}>
      <span class="text-base"> <View.Text> "⚙" </View.Text> </span>
    </IconButton>
}

// A labelled row of segmented text choices.
module Segmented = {
  @jsx.component
  let make = (~options: array<(string, string)>, ~selected: Signal.t<string>, ~onPick: string => unit) =>
    <div class="flex flex-wrap gap-1">
      <View.For
        each={Prop.static(options)}
        render={opt => {
          let (id, label) = opt
          let cls = Computed.make(() =>
            "rounded-md px-2.5 py-1 text-xs font-medium transition-colors " ++ (
              Signal.get(selected) == id
                ? "bg-neutral-900 text-white"
                : "border border-neutral-200 text-neutral-600 hover:bg-neutral-100"
            )
          )
          <button class={Prop.signal(cls)} onClick={_ => onPick(id)}>
            <View.Text> label </View.Text>
          </button>
        }}
      />
    </div>
}

module Panel = {
  @jsx.component
  let make = () => {
    // Close on Escape while open.
    Effect.run(() =>
      if Signal.get(open_) {
        Some(Ui.onEscape(() => Signal.set(open_, false)))
      } else {
        None
      }
    )
    <View.Show when_={Prop.signal(open_)}>
      <Backdrop onClose={() => Signal.set(open_, false)} />
      <div
        class="fixed right-3 top-16 z-40 w-72 rounded-2xl border border-neutral-200 bg-white p-4 shadow-2xl">
        <div class="flex items-center justify-between">
          <h2 class="text-sm font-semibold text-neutral-900"> <View.Text> "Theme" </View.Text> </h2>
          <span class="text-xs text-neutral-400"> <View.Text> "live tokens" </View.Text> </span>
        </div>

        <div class="mt-4 space-y-4">
          <div class="space-y-1.5">
            <span class="text-xs font-medium text-neutral-500"> <View.Text> "Accent" </View.Text> </span>
            <div class="flex flex-wrap gap-2">
              <View.For
                each={Prop.static(accents)}
                render={a => {
                  let (id, label, hex) = a
                  let ring = Computed.make(() =>
                    "size-7 rounded-full transition-transform hover:scale-110 " ++ (
                      Signal.get(accentSel) == id
                        ? "ring-2 ring-neutral-900 ring-offset-2"
                        : "ring-1 ring-neutral-200"
                    )
                  )
                  <button
                    title=label
                    ariaLabel=label
                    class={Prop.signal(ring)}
                    style={"background-color: " ++ hex}
                    onClick={_ => setAccent(id)}
                  />
                }}
              />
            </div>
          </div>

          <div class="space-y-1.5">
            <span class="text-xs font-medium text-neutral-500"> <View.Text> "Radius" </View.Text> </span>
            <Segmented options=radii selected=radiusSel onPick=setRadius />
          </div>

          <div class="space-y-1.5">
            <span class="text-xs font-medium text-neutral-500"> <View.Text> "Font" </View.Text> </span>
            <Segmented options=fonts selected=fontSel onPick=setFont />
          </div>
        </div>

        <button
          class="mt-4 block text-xs text-neutral-500 underline decoration-neutral-300 underline-offset-2 hover:text-neutral-900"
          onClick={_ => {
            Signal.set(open_, false)
            Router.push("/tokens", ())
          }}>
          <View.Text> "View all design tokens →" </View.Text>
        </button>

        <div class="mt-4 flex items-center justify-between border-t border-neutral-100 pt-3">
          <Button variant=#ghost size=#sm onClick={_ => reset()}>
            <View.Text> "Reset" </View.Text>
          </Button>
          <span class="flex items-center gap-1 text-xs text-neutral-400">
            <Kbd> <View.Text> "esc" </View.Text> </Kbd>
            <View.Text> "to close" </View.Text>
          </span>
        </div>
      </div>
    </View.Show>
  }
}
