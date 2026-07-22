// Checkbox — a controlled tick box bound to a signal, with an optional label and
// description. Implements the `checkbox` spec.

// Unique ids for indeterminate boxes — the DOM property is set post-render.
let seq = ref(0)

@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~indeterminate: bool=false,
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
  // `indeterminate` is a property-only DOM state (announced as "mixed"), so an
  // indeterminate box gets a generated id and the property is set after render.
  // The browser clears it on the first user toggle, as the spec expects.
  let id = if indeterminate {
    seq := seq.contents + 1
    let id = "xpecs-checkbox-" ++ Int.toString(seq.contents)
    Ui.setIndeterminateById(id, true)
    Some(id)
  } else {
    None
  }
  <label class="flex items-start gap-3">
    <input
      type_="checkbox"
      ?id
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
