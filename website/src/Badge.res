// Badge — a compact status/category label. Reused by card, table, and others.
@jsx.component
let make = (~variant: Contracts.Badge.variant=#solid, ~children: View.node) => {
  let tone = switch variant {
  | #solid => "bg-neutral-900 text-white"
  | #soft => "bg-neutral-200 text-neutral-800"
  | #outline => "border border-neutral-300 text-neutral-700"
  }
  <span class={"inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium " ++ tone}>
    {children}
  </span>
}
