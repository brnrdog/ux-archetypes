// Link — the reusable navigation control. Reused by navbar, breadcrumb, footer,
// sign-in, and pagination.
@jsx.component
let make = (
  ~href: string="#",
  ~variant: Contracts.Link.variant=#default,
  ~newTab: bool=false,
  ~extraClass: string="",
  ~children: View.node,
) => {
  let base = switch variant {
  | #default => "text-neutral-900 underline decoration-neutral-300 underline-offset-4 hover:decoration-neutral-900"
  | #muted => "text-neutral-500 transition-colors hover:text-neutral-900"
  }
  let target = newTab ? Some("_blank") : None
  <a href ?target class={base ++ (extraClass == "" ? "" : " " ++ extraClass)}> {children} </a>
}
