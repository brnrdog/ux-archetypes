// Textarea — a multi-line text field. Left visually uncontrolled so typing stays
// smooth; writes its text to the given signal on input. Implements the
// `textarea` spec.
@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~placeholder: string="",
  ~rows: int=3,
  ~required: bool=false,
  ~id: option<string>=?,
  ~extraClass: string="",
  ~onInput: option<Dom.event => unit>=?,
) => {
  let handle = e => {
    Signal.set(value, Ui.inputValue(e))
    switch onInput {
    | Some(f) => f(e)
    | None => ()
    }
  }
  <textarea
    ?id
    rows
    required
    placeholder
    class={Ui.inputBase ++ " resize-y" ++ (extraClass == "" ? "" : " " ++ extraClass)}
    onInput={handle}
  />
}
