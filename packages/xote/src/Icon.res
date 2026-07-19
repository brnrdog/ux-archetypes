// Icon — renders a named glyph from the icon library (`Icons`) as an inline SVG.
// Color and weight are inherited from the surrounding text (stroke=currentColor),
// so an icon sits naturally beside a label. `size` maps to the optical size
// scale; pass `label` to give a meaningful icon an accessible name — omit it and
// the icon is treated as decorative and hidden from assistive tech.
let f = Float.toString

let shape = (p: Icons.prim): View.node =>
  switch p {
  | Path(d) => <path d />
  | Circle(cx, cy, r) => <circle cx={f(cx)} cy={f(cy)} r={f(r)} />
  | Line(x1, y1, x2, y2) => <line x1={f(x1)} y1={f(y1)} x2={f(x2)} y2={f(y2)} />
  | Polyline(points) => <polyline points />
  | Polygon(points) => <polygon points />
  | Rect(x, y, w, h, rx, ry) =>
    <rect x={f(x)} y={f(y)} width={f(w)} height={f(h)} rx={f(rx)} ry={f(ry)} />
  }

@jsx.component
let make = (
  ~name: string,
  ~size: Contracts.Icon.size=#md,
  ~label: string="",
  ~extraClass: string="",
) => {
  let dims = switch size {
  | #xs => "size-3"
  | #sm => "size-4"
  | #md => "size-5"
  | #lg => "size-6"
  | #xl => "size-8"
  }
  let meaningful = label != ""
  // Meaningful icons expose an img role + accessible name; decorative ones are
  // hidden so assistive tech doesn't announce them beside their label.
  let roleAttr = meaningful ? Some("img") : None
  let labelAttr = meaningful ? Some(label) : None
  let hiddenAttr = meaningful ? None : Some(true)
  let body = Icons.get(name)->Option.getOr([])
  <svg
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
    class={"inline-block shrink-0 " ++ dims ++ (extraClass == "" ? "" : " " ++ extraClass)}
    role=?roleAttr
    ariaLabel=?labelAttr
    ariaHidden=?hiddenAttr>
    <View.For each={Prop.static(body)} render={shape} />
  </svg>
}
