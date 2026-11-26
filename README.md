# isaacbfsanders.com

Personal site, built with [Astro](https://astro.build) and deployed to GitHub Pages
by `.github/workflows/deploy.yml` on every push to `master`.

## Local development

### With Nix (recommended)

The flake provides Node and everything else; nothing needs to be installed globally.

```sh
nix run .#dev    # live-reloading dev server at http://localhost:4321
nix build        # production build, symlinked at ./result
nix run          # build, then serve it at http://localhost:4321 (set PORT to change)
nix develop      # shell with Node on PATH, for running npm commands
```

After changing `package-lock.json`, update `npmDepsHash` in `flake.nix`: set it to
`lib.fakeHash`, run `nix build`, and copy the hash from the error.

### Without Nix

Requires Node 22.23.4 or newer.

```sh
npm install
npm run dev      # http://localhost:4321
npm run build    # outputs to dist/
```

## Content

- `src/content/posts/`: the current blog, served at `/blog/<filename>/`.
- `src/content/archive/`: posts from 2011–2013 (high school and college), served at
  `/archive/YYYY/MM/DD/slug/`. Their old Jekyll links under `/blog/YYYY/MM/DD/slug`
  redirect here (see `astro.config.mjs`).

A new post is a Markdown file in `src/content/posts/`:

```md
---
title: My Post
date: 2026-11-25
description: Optional summary for search engines.
draft: true   # shown by `npm run dev`, left out of the build
---
```
