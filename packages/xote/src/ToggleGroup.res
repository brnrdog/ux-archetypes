// ToggleGroup — a segmented control bound to a signal. Each option is an
// (id, label) pair. Implements the `toggle-group` spec: `type_` picks between
// single select (segmented control) and multiple select (independent toggles),
// so the bound value is an array of selected ids — one entry in single mode.
@jsx.component
let make = (
  ~value: Signal.t<array<string>>,
  ~options: array<(string, string)>,
  ~type_: Contracts.ToggleGroup.type_=#single,
  ~disabled: bool=false,
) => {
  let toggle = id =>
    switch type_ {
    | #single => Signal.set(value, [id])
    | #multiple =>
      Signal.update(value, v =>
        v->Array.includes(id) ? v->Array.filter(x => x != id) : Array.concat(v, [id])
      )
    }
  <div
    role="group"
    class={"inline-flex overflow-hidden rounded-md border border-neutral-300" ++ (
      disabled ? " pointer-events-none opacity-50" : ""
    )}>
    <View.For
      each={Prop.static(options)}
      render={item => {
        let (id, label) = item
        let cls = Computed.make(() =>
          "border-l border-neutral-300 px-4 py-2 text-sm transition-colors first:border-l-0 " ++ (
            Signal.get(value)->Array.includes(id)
              ? "bg-action text-on-action"
              : "bg-surface text-neutral-700 hover:bg-neutral-100"
          )
        )
        // aria-pressed isn't a typed JSX attribute, so each toggle drops to the
        // low-level element constructor to keep the announcement in sync.
        let pressed = Computed.make(() =>
          Signal.get(value)->Array.includes(id) ? "true" : "false"
        )
        View.element(
          "button",
          ~attrs=[
            View.attr("type", "button"),
            View.signalAttr("aria-pressed", pressed),
            View.signalAttr("class", cls),
          ],
          ~events=[("click", _ => toggle(id))],
          ~children=[<View.Text> label </View.Text>],
          (),
        )
      }}
    />
  </div>
}
