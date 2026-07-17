// Switch — a controlled on/off toggle bound to a signal. Reused by settings-style
// examples.
@jsx.component
let make = (~on: Signal.t<bool>, ~label: string="") => {
  let track = Computed.make(() =>
    "relative inline-flex h-6 w-11 items-center rounded-full transition-colors " ++ (
      Signal.get(on) ? "bg-neutral-900" : "bg-neutral-300"
    )
  )
  let knob = Computed.make(() =>
    "inline-block size-5 transform rounded-full bg-surface shadow transition-transform " ++ (
      Signal.get(on) ? "translate-x-5" : "translate-x-0.5"
    )
  )
  <label class="flex items-center gap-3">
    <button type_="button" role="switch" class={Prop.signal(track)} onClick={_ => Signal.update(on, v => !v)}>
      <span class={Prop.signal(knob)} />
    </button>
    {label == ""
      ? View.null()
      : <span class="text-sm text-neutral-800"> <View.Text> {label} </View.Text> </span>}
  </label>
}
