// @ts-check
import { readdirSync } from 'node:fs';
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// The archived posts used to live at /blog/:year/:month/:day/:title (Jekyll).
// Keep those links working by redirecting them to the archive.
const archiveRedirects = Object.fromEntries(
  readdirSync(new URL('./src/content/archive/', import.meta.url))
    .filter((file) => file.endsWith('.md'))
    .map((file) => {
      const [, y, m, d, slug] = file.match(/^(\d{4})-(\d{2})-(\d{2})-(.+)\.md$/) ?? [];
      return [`/blog/${y}/${m}/${d}/${slug}`, `/archive/${y}/${m}/${d}/${slug}/`];
    }),
);

export default defineConfig({
  site: 'https://isaacbfsanders.com',
  integrations: [sitemap()],
  redirects: archiveRedirects,
});
