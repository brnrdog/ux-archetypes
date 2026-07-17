import { chromium } from "playwright-core";
import { readFileSync, existsSync } from "node:fs";
import { join, extname } from "node:path";
import { createServer } from "node:http";

const dist = new URL("../dist/", import.meta.url).pathname;
const ids = [
  ...readFileSync(new URL("../src/ArchetypesData.res", import.meta.url), "utf8").matchAll(
    /^\s*id: "([^"]+)",/gm,
  ),
].map((m) => m[1]);

const mime = { ".html": "text/html", ".js": "text/javascript", ".css": "text/css" };
const server = createServer((req, res) => {
  let p = decodeURIComponent(req.url.split("?")[0]);
  let file = join(dist, p);
  if (!existsSync(file) || p === "/") {
    // SPA fallback for /a/:id routes
    if (!extname(p)) file = join(dist, "index.html");
  }
  if (!existsSync(file)) file = join(dist, "index.html");
  res.writeHead(200, { "content-type": mime[extname(file)] || "application/octet-stream" });
  res.end(readFileSync(file));
});
await new Promise((r) => server.listen(0, r));
const base = `http://localhost:${server.address().port}`;

const browser = await chromium.launch();
const page = await browser.newPage();
const errors = [];
page.on("console", (m) => m.type() === "error" && errors.push(m.text()));
page.on("pageerror", (e) => errors.push(`pageerror: ${e.message}`));

let withSpec = 0;
let withH2 = 0;
let withList = 0;
let withCode = 0;
for (const id of ids) {
  await page.goto(`${base}/a/${id}`, { waitUntil: "networkidle" });
  await page.waitForTimeout(30);
  const prose = page.locator("#spec-body.ux-prose");
  if ((await prose.count()) && (await prose.innerHTML()).trim().length > 0) withSpec++;
  if (await prose.locator("h2").count()) withH2++;
  if (await prose.locator("ul").count()) withList++;
  if (await prose.locator("code").count()) withCode++;
}

// Navigation swaps the spec: go button -> input, verify text changes.
await page.goto(`${base}/a/button`, { waitUntil: "networkidle" });
await page.waitForTimeout(30);
const buttonSpec = await page.locator("#spec-body").innerHTML();
await page.goto(`${base}/a/input`, { waitUntil: "networkidle" });
await page.waitForTimeout(30);
const inputSpec = await page.locator("#spec-body").innerHTML();
const swapped = buttonSpec !== inputSpec && inputSpec.length > 0;

await browser.close();
server.close();
console.log(
  JSON.stringify(
    { routes: ids.length, withSpec, withH2, withList, withCode, swapped, errors: [...new Set(errors)] },
    null,
    2,
  ),
);
if (errors.length || withSpec !== ids.length || !swapped) process.exitCode = 1;
