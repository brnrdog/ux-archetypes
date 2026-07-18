// AspectRatio — constrains its content to a fixed width:height proportion.
// Implements the `aspect-ratio` spec.
@jsx.component
let make = (~ratio: string="16/9", ~extraClass: string="", ~children: View.node) =>
  <div class={"overflow-hidden" ++ (extraClass == "" ? "" : " " ++ extraClass)} style={"aspect-ratio: " ++ ratio}>
    {children}
  </div>
