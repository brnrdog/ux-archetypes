// ToggleGroup — a segmented single-select control bound to a signal. Each option
// is an (id, label) pair. Implements the `toggle-group` spec (single select).
@jsx.component
let make = (~value: Signal.t<string>, ~options: array<(string, string)>, ~disabled: bool=false) =>
  <div
    class={"inline-flex overflow-hidden rounded-md border border-neutral-300" ++ (
      disabled ? " pointer-events-none opacity-50" : ""
    )}>
    <View.For
      each={Prop.static(options)}
      render={item => {
        let (id, label) = item
        let cls = Computed.make(() =>
          "border-l border-neutral-300 px-4 py-2 text-sm transition-colors first:border-l-0 " ++ (
            Signal.get(value) == id
              ? "bg-neutral-900 text-neutral-0"
              : "bg-surface text-neutral-700 hover:bg-neutral-100"
          )
        )
        <button type_="button" class={Prop.signal(cls)} onClick={_ => Signal.set(value, id)}>
          <View.Text> label </View.Text>
        </button>
      }}
    />
  </div>
