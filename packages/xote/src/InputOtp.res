// InputOtp — a segmented one-time-code field bound to a signal. A single
// transparent input captures keystrokes; the cells mirror the entered digits.
// Implements the `input-otp` spec.
@jsx.component
let make = (~value: Signal.t<string>, ~length: int=6, ~disabled: bool=false) => {
  let slots = Array.fromInitializer(~length, i => i)
  <label class="relative inline-flex gap-2">
    <input
      class="absolute inset-0 z-10 cursor-pointer opacity-0 disabled:cursor-not-allowed"
      type_="text"
      maxLength={length}
      disabled
      onInput={e => {
        let digits =
          Ui.inputValue(e)
          ->String.replaceRegExp(%re("/[^0-9]/g"), "")
          ->String.slice(~start=0, ~end=length)
        Signal.set(value, digits)
      }}
    />
    <View.For
      each={Prop.static(slots)}
      render={i => {
        let cls = Computed.make(() => {
          let len = Signal.get(value)->String.length
          "flex size-11 items-center justify-center rounded-md border text-lg font-semibold text-neutral-900 " ++ (
            len == i ? "border-neutral-900 ring-1 ring-neutral-900" : "border-neutral-300"
          )
        })
        let ch = Computed.make(() => Signal.get(value)->String.charAt(i))
        <span class={Prop.signal(cls)}> <View.Text> {ch} </View.Text> </span>
      }}
    />
  </label>
}
