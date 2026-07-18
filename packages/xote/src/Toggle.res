// Toggle — a two-state button bound to a signal. Implements the `toggle` spec.
@jsx.component
let make = (~pressed: Signal.t<bool>, ~disabled: bool=false, ~children: View.node) => {
  let cls = Computed.make(() =>
    "inline-flex size-10 items-center justify-center rounded-md text-sm font-semibold transition-colors " ++ (
      Signal.get(pressed)
        ? "bg-neutral-900 text-neutral-0"
        : "border border-neutral-300 bg-surface text-neutral-700 hover:bg-neutral-100"
    )
  )
  <button type_="button" disabled class={Prop.signal(cls)} onClick={_ => Signal.update(pressed, v => !v)}>
    {children}
  </button>
}
