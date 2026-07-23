import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

// On GitHub Pages a project site is served from "/<repo>/", so the CI build
// sets BASE_PATH (e.g. "/prescriptive/"). Locally it defaults to "/".
const base = process.env.BASE_PATH || "/";

export default defineConfig({
  base,
  plugins: [tailwindcss()],
});
