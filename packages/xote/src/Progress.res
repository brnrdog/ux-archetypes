// Progress — a determinate or indeterminate progress bar bound to an int signal.
// Implements the `progress` spec.
@jsx.component
let make = (
  ~value: Signal.t<int>,
  ~max: int=100,
  ~indeterminate: bool=false,
  ~extraClass: string="",
) => {
  let bar = Computed.make(() => {
    let pct = max <= 0 ? 0 : Signal.get(value) * 100 / max
    let clamped = pct < 0 ? 0 : pct > 100 ? 100 : pct
    "height:100%;width:" ++ Int.toString(clamped) ++ "%"
  })
  <div
    class={"h-2 w-full overflow-hidden rounded-full bg-neutral-200" ++ (
      extraClass == "" ? "" : " " ++ extraClass
    )}
    role="progressbar">
    {indeterminate
      ? <div class="h-full w-1/3 animate-pulse rounded-full bg-neutral-900" />
      : <div class="rounded-full bg-neutral-900 transition-all" style={Prop.signal(bar)} />}
  </div>
}
