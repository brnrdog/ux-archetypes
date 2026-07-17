// Live theme settings. The whole site is driven by the design tokens compiled to
// CSS custom properties (see tokens.generated.css), so re-theming at runtime is
// just overriding those variables on :root. Presets and per-token edits share one
// path→value override store, persisted in localStorage and re-applied on load.

// --- Raw DOM / storage helpers -------------------------------------------------
let setVar: (string, string) => unit = %raw(`(k, v) => document.documentElement.style.setProperty(k, v)`)
let removeVar: string => unit = %raw(`(k) => document.documentElement.style.removeProperty(k)`)
let store: (string, string) => unit = %raw(`(k, v) => { try { localStorage.setItem(k, v) } catch (e) {} }`)
let read: string => string = %raw(`(k) => { try { return localStorage.getItem(k) || "" } catch (e) { return "" } }`)
let reload: unit => unit = %raw(`() => location.reload()`)
let readOr = (k, d) => {
  let v = read(k)
  v == "" ? d : v
}

// --- Token override store (path → value) ---------------------------------------
// Shared by the preset picker and the Design Tokens editor. Editing overrides the
// token's Tailwind theme var (cascades site-wide) and its --ux-* mirror.
let getOverrides: unit => Dict.t<string> = %raw(`() => { try { return JSON.parse(localStorage.getItem("ux.tokenOverrides") || "{}") } catch (e) { return {} } }`)
let saveOverrides: Dict.t<string> => unit = %raw(`(o) => { try { localStorage.setItem("ux.tokenOverrides", JSON.stringify(o)) } catch (e) {} }`)

let tokenByPath = path => {
  let found = ref(None)
  TokensData.all->Array.forEach(g =>
    g.tokens->Array.forEach(t =>
      if t.path == path {
        found := Some(t)
      }
    )
  )
  found.contents
}

let applyVars = (t: TokensData.token, value) => {
  setVar(t.uxVar, value)
  if t.themeVar != "" {
    setVar(t.themeVar, value)
  }
}

let applyToken = (t: TokensData.token, value) => {
  applyVars(t, value)
  let o = getOverrides()
  o->Dict.set(t.path, value)
  saveOverrides(o)
}

let applyByPath = (path, value) =>
  switch tokenByPath(path) {
  | Some(t) => applyToken(t, value)
  | None => ()
  }

let loadTokenOverrides = () => {
  let o = getOverrides()
  o
  ->Dict.toArray
  ->Array.forEach(((path, v)) =>
    switch tokenByPath(path) {
    | Some(t) => applyVars(t, v)
    | None => ()
    }
  )
}

// Remove every current override's inline vars and clear the store.
let clearOverrides = () => {
  let o = getOverrides()
  o
  ->Dict.keysToArray
  ->Array.forEach(path =>
    switch tokenByPath(path) {
    | Some(t) =>
      removeVar(t.uxVar)
      if t.themeVar != "" {
        removeVar(t.themeVar)
      }
    | None => ()
    }
  )
  saveOverrides(Dict.make())
}

// --- Presets -------------------------------------------------------------------
// A preset is a named bundle of token overrides. Tinting the neutral ramp
// cascades through the semantic roles (which alias it) so the whole site — chrome
// and components — re-themes cohesively; a couple also override a semantic role
// directly. Applying one replaces any current overrides.
// The themes themselves live in the framework (tokens/themes.json) and are
// generated into ThemesData — this module just applies them.

// --- State ---------------------------------------------------------------------
let open_ = Signal.make(false)
let presetSel = Signal.make(readOr("ux.preset", "monochrome"))

let applyPreset = (t: ThemesData.theme) => {
  clearOverrides()
  t.tokens->Array.forEach(((path, v)) => applyByPath(path, v))
  Signal.set(presetSel, t.id)
  store("ux.preset", t.id)
}

// Reset everything (presets + per-token edits) back to the framework defaults.
let resetTokens = () => {
  clearOverrides()
  Signal.set(presetSel, "monochrome")
  store("ux.preset", "monochrome")
}
let resetTokensAndReload = () => {
  resetTokens()
  reload()
}

// --- UI ------------------------------------------------------------------------
module Trigger = {
  @jsx.component
  let make = () =>
    <IconButton label="Theme settings" onClick={_ => Signal.update(open_, v => !v)}>
      <span class="text-base"> <View.Text> "⚙" </View.Text> </span>
    </IconButton>
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
      <div class="fixed right-3 top-16 z-40 w-72 rounded-2xl border border-border bg-surface p-4 shadow-2xl">
        <div class="flex items-center justify-between">
          <h2 class="text-sm font-semibold text-ink"> <View.Text> "Theme presets" </View.Text> </h2>
          <span class="text-xs text-muted"> <View.Text> "live tokens" </View.Text> </span>
        </div>

        <div class="mt-3 grid grid-cols-3 gap-2">
          <View.For
            each={Prop.static(ThemesData.all)}
            render={p => {
              let cls = Computed.make(() =>
                "flex flex-col items-center gap-1.5 rounded-xl border p-2 transition-colors " ++ (
                  Signal.get(presetSel) == p.id
                    ? "border-neutral-900 bg-action-subtle"
                    : "border-border hover:bg-action-subtle"
                )
              )
              <button class={Prop.signal(cls)} onClick={_ => applyPreset(p)}>
                {Array.length(p.swatches) == 1
                  ? <span
                      class="size-6 rounded-full ring-1 ring-black/10"
                      style={"background-color: " ++ Array.getUnsafe(p.swatches, 0)}
                    />
                  : <span class="flex h-6 overflow-hidden rounded-full ring-1 ring-black/10">
                      <View.For
                        each={Prop.static(p.swatches)}
                        render={c => <span class="w-1.5" style={"background-color: " ++ c} />}
                      />
                    </span>}
                <span class="text-[11px] font-medium text-ink"> <View.Text> {p.label} </View.Text> </span>
              </button>
            }}
          />
        </div>

        <button
          class="mt-4 block text-xs text-muted underline decoration-neutral-300 underline-offset-2 hover:text-ink"
          onClick={_ => {
            Signal.set(open_, false)
            Router.push("/tokens", ())
          }}>
          <View.Text> "Edit individual tokens →" </View.Text>
        </button>

        <div class="mt-4 flex items-center justify-between border-t border-border pt-3">
          <Button variant=#ghost size=#sm onClick={_ => resetTokens()}>
            <View.Text> "Reset" </View.Text>
          </Button>
          <span class="flex items-center gap-1 text-xs text-muted">
            <Kbd> <View.Text> "esc" </View.Text> </Kbd>
            <View.Text> "to close" </View.Text>
          </span>
        </div>
      </div>
    </View.Show>
  }
}
