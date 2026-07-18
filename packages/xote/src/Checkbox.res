// Checkbox — a controlled tick box bound to a signal, with an optional label and
// description. Implements the `checkbox` spec.
@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~disabled: bool=false,
  ~required: bool=false,
  ~label: string="",
  ~description: string="",
  ~onChange: option<Dom.event => unit>=?,
) => {
  let handle = e => {
    Signal.set(checked, Ui.checked(e))
    switch onChange {
    | Some(f) => f(e)
    | None => ()
    }
  }
  <label class="flex items-start gap-3">
    <input
      type_="checkbox"
      checked={Prop.signal(checked)}
      disabled
      required
      class="mt-0.5 size-4 accent-neutral-900 disabled:opacity-40"
      onChange={handle}
    />
    {label == "" && description == ""
      ? View.null()
      : <span>
          {label == ""
            ? View.null()
            : <span class="block text-sm font-medium text-neutral-800"> <View.Text> label </View.Text> </span>}
          {description == ""
            ? View.null()
            : <span class="block text-xs text-neutral-500"> <View.Text> description </View.Text> </span>}
        </span>}
  </label>
}
