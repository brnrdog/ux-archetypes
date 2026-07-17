// Select — a control that opens a list for choosing one option. Controlled via
// the `value` signal; `disabled` blocks interaction (both contract props). The
// open state is internal. Dismisses on outside click (Backdrop / `dismissible`
// trait).
@jsx.component
let make = (~value: Signal.t<string>, ~options: array<string>, ~disabled: bool=false) => {
  let open_ = Signal.make(false)
  let label = Computed.make(() => Signal.get(value))
  <div class="relative w-56">
    <button
      disabled
      class={Ui.inputBase ++ " flex items-center justify-between disabled:opacity-40"}
      onClick={_ => Signal.update(open_, v => !v)}>
      <View.Text> {label} </View.Text>
      <span class="text-neutral-400"> <View.Text> "⌄" </View.Text> </span>
    </button>
    <View.Show when_={Prop.signal(open_)}>
      <Backdrop onClose={() => Signal.set(open_, false)} />
      <ul
        role="listbox"
        class="absolute z-20 mt-1 w-full rounded-md border border-neutral-200 bg-surface py-1 shadow-lg">
        <View.For
          each={Prop.static(options)}
          render={o => {
            let mark = Computed.make(() => Signal.get(value) == o ? "✓" : "")
            <li>
              <button
                role="option"
                class="flex w-full items-center justify-between px-3 py-1.5 text-left text-sm text-neutral-700 hover:bg-neutral-100"
                onClick={_ => {
                  Signal.set(value, o)
                  Signal.set(open_, false)
                }}>
                <View.Text> o </View.Text>
                <span class="text-neutral-900"> <View.Text> {mark} </View.Text> </span>
              </button>
            </li>
          }}
        />
      </ul>
    </View.Show>
  </div>
}
