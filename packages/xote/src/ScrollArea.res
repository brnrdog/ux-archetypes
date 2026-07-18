// ScrollArea — a container that scrolls its overflowing content. Implements the
// `scroll-area` spec.
@jsx.component
let make = (
  ~orientation: Contracts.ScrollArea.orientation=#vertical,
  ~extraClass: string="",
  ~children: View.node,
) => {
  let overflow = switch orientation {
  | #vertical => "overflow-y-auto"
  | #horizontal => "overflow-x-auto"
  | #both => "overflow-auto"
  }
  <div class={overflow ++ (extraClass == "" ? "" : " " ++ extraClass)}> {children} </div>
}
