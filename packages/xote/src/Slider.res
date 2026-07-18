// Slider — a controlled range input bound to an int signal. Implements the
// `slider` spec.
@jsx.component
let make = (
  ~value: Signal.t<int>,
  ~min: int=0,
  ~max: int=100,
  ~step: int=1,
  ~disabled: bool=false,
  ~onChange: option<Dom.event => unit>=?,
) => {
  let handle = e => {
    Signal.set(value, Ui.inputValue(e)->Int.fromString->Option.getOr(0))
    switch onChange {
    | Some(f) => f(e)
    | None => ()
    }
  }
  <input
    type_="range"
    min={Int.toString(min)}
    max={Int.toString(max)}
    step={Int.toString(step)}
    value={Prop.signal(Computed.make(() => Signal.get(value)->Int.toString))}
    disabled
    class="w-full accent-neutral-900 disabled:opacity-40"
    onInput={handle}
  />
}
