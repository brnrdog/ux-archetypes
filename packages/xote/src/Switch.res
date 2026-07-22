// Switch — a controlled on/off toggle bound to a signal. Reused by settings-style
// examples. Implements the `switch` spec: `checked` drives the visual state and
// the aria-checked announcement, `disabled` blocks interaction.
@jsx.component
let make = (~checked: Signal.t<bool>, ~label: string="", ~disabled: bool=false) => {
  let track = Computed.make(() =>
    "relative inline-flex h-6 w-11 items-center rounded-full transition-colors " ++
    (Signal.get(checked) ? "bg-action" : "bg-neutral-300") ++ (disabled ? " opacity-40" : "")
  )
  let knob = Computed.make(() =>
    "inline-block size-5 transform rounded-full bg-surface shadow transition-transform " ++ (
      Signal.get(checked) ? "translate-x-5" : "translate-x-0.5"
    )
  )
  // aria-checked isn't a typed JSX attribute, so the control drops to the
  // low-level element constructor to keep the announcement in sync.
  let ariaChecked = Computed.make(() => Signal.get(checked) ? "true" : "false")
  let control = View.element(
    "button",
    ~attrs=[
      View.attr("type", "button"),
      View.attr("role", "switch"),
      View.attr("disabled", disabled ? "true" : "false"),
      View.signalAttr("aria-checked", ariaChecked),
      View.signalAttr("class", track),
    ],
    ~events=[("click", _ => disabled ? () : Signal.update(checked, v => !v))],
    ~children=[<span class={Prop.signal(knob)} />],
    (),
  )
  <label class={"flex items-center gap-3" ++ (disabled ? " cursor-not-allowed" : "")}>
    {control}
    {label == ""
      ? View.null()
      : <span class="text-sm text-neutral-800"> <View.Text> {label} </View.Text> </span>}
  </label>
}
