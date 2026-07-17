// Maps a token path to the Tailwind v4 `@theme` variable that drives its
// utilities, or "" when no utility consumes it directly. Overriding this var at
// runtime re-themes the whole site. Shared by the CSS and data generators and
// mirrored by the live token editor.
// Semantic color roles → clean Tailwind color utilities (bg-action,
// text-on-action, bg-status-danger, bg-surface, border-border, text-ink, …).
const semantic = {
  "color.ink": "--color-ink",
  "color.paper": "--color-paper",
  "color.surface": "--color-surface",
  "color.muted": "--color-muted",
  "color.border": "--color-border",
  "color.accent": "--color-accent",
  "color.accentContrast": "--color-accent-contrast",
  "color.action.default": "--color-action",
  "color.action.hover": "--color-action-hover",
  "color.action.subtle": "--color-action-subtle",
  "color.action.onAction": "--color-on-action",
};

export function themeVarFor(path) {
  const parts = path.split(".");
  if (/^color\.neutral\.\d+/.test(path)) return `--color-neutral-${parts[2]}`;
  if (semantic[path]) return semantic[path];
  if (path.startsWith("color.status.")) return `--color-status-${parts[2]}`;
  if (path.startsWith("color.chart.")) return `--color-chart-${parts[2]}`;
  if (path.startsWith("radius.")) return `--radius-${parts[1]}`;
  if (path.startsWith("shadow.")) return `--shadow-${parts[1]}`;
  if (path === "font.family.sans") return "--font-sans";
  if (path === "font.family.mono") return "--font-mono";
  if (path.startsWith("font.weight.")) return `--font-weight-${parts[2]}`;
  if (path === "space.1") return "--spacing"; // base unit; scales all p-/m-/gap-
  return "";
}
