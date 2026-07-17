// Dialog — a modal overlay focusing the user on a self-contained task. Controlled
// via the `open` signal (the contract prop); the header/body/footer are passed
// as children. Backdrop click dismisses (see the `dismissible` trait). Reuses
// Backdrop.
@jsx.component
let make = (
  ~open_: Signal.t<bool>,
  ~title: string,
  ~description: string="",
  ~children: View.node,
) =>
  <View.Show when_={Prop.signal(open_)}>
    <div class="absolute inset-0 z-10 flex items-center justify-center">
      <div class="absolute inset-0 bg-neutral-900/40" onClick={_ => Signal.set(open_, false)} />
      <div
        role="dialog"
        class="relative z-20 w-80 rounded-lg border border-neutral-200 bg-surface p-5 shadow-2xl">
        <h3 class="text-lg font-semibold text-neutral-900"> <View.Text> title </View.Text> </h3>
        <View.Show when_={Prop.static(description != "")}>
          <p class="mt-1 text-sm text-neutral-500"> <View.Text> description </View.Text> </p>
        </View.Show>
        {children}
      </div>
    </div>
  </View.Show>
