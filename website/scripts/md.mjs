// Shared, dependency-free markdown -> HTML for the constrained subset the specs
// use: h2 headings, paragraphs, single-level bullet lists (with wrapped
// continuation lines and bold lead-ins), and inline bold/italic/code/links.

export function escapeHtml(s) {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

export function inline(s) {
  const codes = [];
  // Stash code spans behind a distinctive sentinel (@@C<n>@@) so later emphasis
  // and escaping don't touch their contents, and no ordinary prose collides.
  s = s.replace(/`([^`]+)`/g, (_, c) => {
    codes.push(c);
    return "@@C" + (codes.length - 1) + "@@";
  });
  s = escapeHtml(s);
  s = s.replace(
    /\[(.+?)\]\((.+?)\)/g,
    (_, t, u) => `<a href="${u}" target="_blank" rel="noreferrer">${t}</a>`,
  );
  s = s.replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>");
  s = s.replace(/\*([^*]+)\*/g, "<em>$1</em>");
  s = s.replace(/_([^_]+)_/g, "<em>$1</em>");
  s = s.replace(/@@C(\d+)@@/g, (_, i) => `<code>${escapeHtml(codes[Number(i)])}</code>`);
  return s;
}

export function mdToHtml(body) {
  // Drop the leading `# Title` line -- pages render the title themselves.
  const withoutH1 = body.replace(/^\s*#\s+.*(\n|$)/, "");
  const out = [];
  let para = [];
  let items = [];
  const flushPara = () => {
    if (para.length) out.push(`<p>${inline(para.join(" "))}</p>`);
    para = [];
  };
  const flushList = () => {
    if (items.length)
      out.push(
        "<ul>" + items.map((it) => `<li>${inline(it)}</li>`).join("") + "</ul>",
      );
    items = [];
  };
  const flush = () => {
    flushPara();
    flushList();
  };
  for (const rawLine of withoutH1.split("\n")) {
    const line = rawLine.replace(/\s+$/, "");
    if (line.trim() === "" || line.trim().startsWith("<!--")) {
      flush();
    } else if (/^##\s+/.test(line)) {
      flush();
      out.push(`<h2>${inline(line.replace(/^##\s+/, "").trim())}</h2>`);
    } else if (/^\s*-\s+/.test(line)) {
      flushPara();
      items.push(line.replace(/^\s*-\s+/, ""));
    } else if (items.length && /^\s+/.test(rawLine)) {
      items[items.length - 1] += " " + line.trim();
    } else {
      flushList();
      para.push(line.trim());
    }
  }
  flush();
  return out.join("\n");
}
