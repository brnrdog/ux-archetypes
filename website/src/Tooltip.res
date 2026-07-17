// Tooltip — a brief label revealed on hover/focus of its trigger. `content` is
// the contract prop; the trigger is passed as children. Anchored above the
// trigger (see the `anchored` behavior trait).
@jsx.component
let make = (~content: string, ~children: View.node) => {
  let open_ = Signal.make(false)
  <span
    class="relative inline-block"
    onMouseEnter={_ => Signal.set(open_, true)}
    onMouseLeave={_ => Signal.set(open_, false)}
    onFocus={_ => Signal.set(open_, true)}
    onBlur={_ => Signal.set(open_, false)}>
    {children}
    <View.Show when_={Prop.signal(open_)}>
      <span
        role="tooltip"
        class="absolute -top-9 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-md bg-neutral-900 px-2 py-1 text-xs text-neutral-0">
        <View.Text> content </View.Text>
      </span>
    </View.Show>
  </span>
}
