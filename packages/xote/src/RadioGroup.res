// RadioGroup — mutually exclusive options bound to a signal. Each option is a
// (value, label, description) triple. Implements the `radio-group` spec.
@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~options: array<(string, string, string)>,
  ~legend: string="",
  ~orientation: Contracts.RadioGroup.orientation=#vertical,
  ~disabled: bool=false,
  ~extraClass: string="",
) => {
  let listCls = switch orientation {
  | #vertical => "space-y-2"
  | #horizontal => "flex flex-wrap gap-2"
  }
  <fieldset
    class={extraClass ++ (disabled ? " pointer-events-none opacity-50" : "")} role="radiogroup">
    {legend == ""
      ? View.null()
      : <legend class="mb-1 text-sm font-medium text-neutral-800"> <View.Text> legend </View.Text> </legend>}
    <div class={listCls}>
      <View.For
        each={Prop.static(options)}
        render={item => {
          let (id, title, desc) = item
          let rowCls = Computed.make(() =>
            "flex cursor-pointer items-start gap-3 rounded-md border p-3 transition-colors " ++ (
              Signal.get(value) == id
                ? "border-neutral-900 bg-neutral-50"
                : "border-neutral-200 hover:border-neutral-300"
            )
          )
          let ring = Computed.make(() =>
            "mt-0.5 flex size-4 items-center justify-center rounded-full border " ++ (
              Signal.get(value) == id ? "border-neutral-900" : "border-neutral-300"
            )
          )
          let dot = Computed.make(() =>
            "size-2 rounded-full " ++ (Signal.get(value) == id ? "bg-neutral-900" : "bg-transparent")
          )
          <label class={Prop.signal(rowCls)} onClick={_ => Signal.set(value, id)}>
            <span class={Prop.signal(ring)}> <span class={Prop.signal(dot)} /> </span>
            <span>
              <span class="block text-sm font-medium text-neutral-800"> <View.Text> title </View.Text> </span>
              {desc == ""
                ? View.null()
                : <span class="block text-xs text-neutral-500"> <View.Text> desc </View.Text> </span>}
            </span>
          </label>
        }}
      />
    </div>
  </fieldset>
}
