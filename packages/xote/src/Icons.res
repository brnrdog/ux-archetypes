// Icons — a small, modern outline icon set in the Feather / Lucide visual
// language: every glyph is drawn on a 24×24 grid with no fill, 2px strokes, and
// round caps and joins, so it inherits the surrounding text color and optical
// weight. The geometry lives here as data (one entry per name); the `Icon`
// element turns a name into an inline SVG. Glyph paths adapted from Feather
// Icons (MIT).

// A single drawing primitive. Keeping circles, lines, and polylines as first-
// class shapes (rather than flattening everything to a path `d`) lets the glyphs
// stay faithful to the source set and easy to read.
type prim =
  | Path(string)
  | Circle(float, float, float) // cx, cy, r
  | Line(float, float, float, float) // x1, y1, x2, y2
  | Polyline(string) // points
  | Polygon(string) // points
  | Rect(float, float, float, float, float, float) // x, y, width, height, rx, ry

// name → geometry. Names follow the conventional icon vocabulary (kebab-case,
// concept-not-appearance) so they read the same across projects.
let registry: dict<array<prim>> = Dict.fromArray([
  // Confirm / dismiss
  ("check", [Polyline("20 6 9 17 4 12")]),
  ("x", [Line(18., 6., 6., 18.), Line(6., 6., 18., 18.)]),
  // Chevrons
  ("chevron-down", [Polyline("6 9 12 15 18 9")]),
  ("chevron-up", [Polyline("18 15 12 9 6 15")]),
  ("chevron-left", [Polyline("15 18 9 12 15 6")]),
  ("chevron-right", [Polyline("9 18 15 12 9 6")]),
  // Arrows
  ("arrow-right", [Line(5., 12., 19., 12.), Polyline("12 5 19 12 12 19")]),
  ("arrow-left", [Line(19., 12., 5., 12.), Polyline("12 19 5 12 12 5")]),
  ("arrow-up", [Line(12., 19., 12., 5.), Polyline("5 12 12 5 19 12")]),
  ("arrow-down", [Line(12., 5., 12., 19.), Polyline("19 12 12 19 5 12")]),
  // Add / remove
  ("plus", [Line(12., 5., 12., 19.), Line(5., 12., 19., 12.)]),
  ("minus", [Line(5., 12., 19., 12.)]),
  // Common actions
  ("search", [Circle(11., 11., 8.), Line(21., 21., 16.65, 16.65)]),
  (
    "trash",
    [
      Polyline("3 6 5 6 21 6"),
      Path("M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"),
      Line(10., 11., 10., 17.),
      Line(14., 11., 14., 17.),
    ],
  ),
  ("edit", [Path("M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z")]),
  (
    "copy",
    [
      Rect(9., 9., 13., 13., 2., 2.),
      Path("M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"),
    ],
  ),
  ("download", [Path("M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"), Polyline("7 10 12 15 17 10"), Line(12., 15., 12., 3.)]),
  ("upload", [Path("M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"), Polyline("17 8 12 3 7 8"), Line(12., 3., 12., 15.)]),
  ("external-link", [Path("M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"), Polyline("15 3 21 3 21 9"), Line(10., 14., 21., 3.)]),
  // Menus / overflow
  ("menu", [Line(3., 12., 21., 12.), Line(3., 6., 21., 6.), Line(3., 18., 21., 18.)]),
  ("more-horizontal", [Circle(12., 12., 1.), Circle(19., 12., 1.), Circle(5., 12., 1.)]),
  ("more-vertical", [Circle(12., 12., 1.), Circle(12., 5., 1.), Circle(12., 19., 1.)]),
  // Status
  ("info", [Circle(12., 12., 10.), Line(12., 16., 12., 12.), Line(12., 8., 12.01, 8.)]),
  ("alert-triangle", [Path("M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"), Line(12., 9., 12., 13.), Line(12., 17., 12.01, 17.)]),
  ("alert-circle", [Circle(12., 12., 10.), Line(12., 8., 12., 12.), Line(12., 16., 12.01, 16.)]),
  ("check-circle", [Path("M22 11.08V12a10 10 0 1 1-5.93-9.14"), Polyline("22 4 12 14.01 9 11.01")]),
  ("x-circle", [Circle(12., 12., 10.), Line(15., 9., 9., 15.), Line(9., 9., 15., 15.)]),
  // Objects
  ("user", [Path("M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"), Circle(12., 7., 4.)]),
  (
    "settings",
    [
      Circle(12., 12., 3.),
      Path(
        "M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z",
      ),
    ],
  ),
  ("bell", [Path("M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"), Path("M13.73 21a2 2 0 0 1-3.46 0")]),
  ("heart", [Path("M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z")]),
  ("star", [Polygon("12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2")]),
  ("home", [Path("M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"), Polyline("9 22 9 12 15 12 15 22")]),
  ("mail", [Path("M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"), Polyline("22 6 12 13 2 6")]),
  ("calendar", [Rect(3., 4., 18., 18., 2., 2.), Line(16., 2., 16., 6.), Line(8., 2., 8., 6.), Line(3., 10., 21., 10.)]),
  ("clock", [Circle(12., 12., 10.), Polyline("12 6 12 12 16 14")]),
  ("eye", [Path("M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"), Circle(12., 12., 3.)]),
  (
    "eye-off",
    [
      Path("M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"),
      Line(1., 1., 23., 23.),
    ],
  ),
  // Theme
  (
    "sun",
    [
      Circle(12., 12., 5.),
      Line(12., 1., 12., 3.),
      Line(12., 21., 12., 23.),
      Line(4.22, 4.22, 5.64, 5.64),
      Line(18.36, 18.36, 19.78, 19.78),
      Line(1., 12., 3., 12.),
      Line(21., 12., 23., 12.),
      Line(4.22, 19.78, 5.64, 18.36),
      Line(18.36, 5.64, 19.78, 4.22),
    ],
  ),
  ("moon", [Path("M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z")]),
])

// Every icon name in the set, sorted for a stable catalogue order.
let names: array<string> = registry->Dict.keysToArray->Array.toSorted(String.compare)

// Geometry for a name, or None when the name isn't in the set.
let get = (name: string): option<array<prim>> => registry->Dict.get(name)
