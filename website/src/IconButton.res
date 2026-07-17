// IconButton — a compact, icon-only action with a required accessible name.
// Reused by toolbar, list, and other dense contexts.
@jsx.component
let make = (
  ~label: string,
  ~variant: Contracts.IconButton.variant=#ghost,
  ~onClick: option<Dom.event => unit>=?,
  ~children: View.node,
) => {
  let tone = switch variant {
  | #solid => "bg-neutral-900 text-white hover:bg-neutral-700"
  | #ghost => "text-neutral-700 hover:bg-neutral-100"
  }
  <button
    type_="button"
    ariaLabel=label
    class={"inline-flex size-9 items-center justify-center rounded-md text-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-neutral-900 focus-visible:ring-offset-2 " ++
    tone}
    ?onClick>
    {children}
  </button>
}
