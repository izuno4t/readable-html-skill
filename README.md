# readable-html-skill

A skill for coding agents to craft highly readable and minimalistic HTML documents.

## About the skill

The `readable-html` skill helps a coding agent produce a single-file HTML
document that is highly readable: clear structure, semantically correct
elements, and the accessibility baseline by default. Styling is the
minimum needed to support readability — no design templates, no
branding.

In scope:

- One self-contained `.html` file as the deliverable.
- Content structure and semantics: heading hierarchy, tables, figures,
  code blocks, links, `details` / `summary`.
- A layout where the reader grasps the gist in five seconds and can jump
  directly to whatever they need.
- The accessibility baseline (DADS / WCAG 2.2 AA-equivalent).

Out of scope:

- Branded or decorative design templates. The skill applies only the
  minimum styling required for readability.
- Branding assets (company-specific colors, fonts, logos).
- Multi-page SPAs or web applications. Single-document outputs only.

Core principles:

1. **Content first, presentation later.** Outline before writing HTML;
   do not invent structure while typing tags.
2. **Meaning is grasped at first screen.** TL;DR, table of contents, and
   the heading sequence alone tell the reader what this document is and
   where to read.
3. **Do not give up on HTML's expressiveness.** Reach for tables, inline
   SVG, side-by-side comparisons, and `details` / `summary` instead of
   falling back to bullet lists or prose.
4. **Single-file principle.** CSS, SVG, and any script live inline so the
   document is one file. External stylesheets only when the user
   explicitly asks for the project's existing stylesheet.
5. **Accessibility cannot be retrofitted.** Semantically correct elements
   from the start do most of the work; bolting on ARIA later does not.

## Repository Layout

```text
readable-html-skill/
├── README.md
├── AGENTS.md
├── references.md                # Maintainer catalog of external sources
├── src/                         # Canonical skill sources (bundled into builds)
│   ├── skill.md                 # Agent-neutral skill body
│   ├── readable-html.yaml.example
│   ├── references/              # Bundled references copied into builds
│   └── agents/
│       ├── claude-code/header.md
│       └── codex/header.md
├── agents/                      # Generated local-install outputs, ignored
├── dist/                        # Generated package archives, ignored
├── scripts/
│   ├── build
│   ├── link
│   └── status
```

`src/` is the source of truth for skill content that ships to agents.
Repo-root docs (`README.md`, `AGENTS.md`, `references.md`) are maintainer
material and are not bundled. Generated files under `agents/` and `dist/`
are ignored and must not be edited or committed.

## Commands

```bash
# Build local-install outputs for all agents.
make build

# Build agents/ first, then create package archives.
make package

# Build and link local outputs into agent skill directories.
make install

# Build one agent.
make build AGENT=codex
```

Builds generate an agent-specific `SKILL.md` from:

```text
src/agents/<agent>/header.md
+ src/skill.md
```

`src/references/` and `src/readable-html.yaml.example` are copied (real
copy, not symlink) into each generated skill directory.

`make package` runs `make build` first, then creates package archives under
`dist/<agent>/`.

## Local Install Targets

```bash
make install
make uninstall
make status
```

The link targets are:

```text
~/.codex/skills/readable-html  -> agents/codex/readable-html
~/.claude/skills/readable-html -> agents/claude-code/readable-html
```

Run `make build` after changing files under `src/`. Run `make package` before
publishing package outputs.

## Palette Configuration

Use `readable-html.yaml` to select a palette.

```yaml
palette: dracula
```

Lookup order:

1. `<repo-root>/readable-html.yaml`
2. `~/.config/readable-html/readable-html.yaml`
3. Default: `dads-blue`

Supported values:

- `dads-blue` / `dads-blue-dark`
- `dads-green` / `dads-green-dark`
- `dads-purple` / `dads-purple-dark`
- `dads-orange` / `dads-orange-dark`
- `dracula`
- `mono` / `mono-dark`
- `high-contrast`

Do not ask users to choose a palette during normal skill execution. If no
configuration file exists, use `dads-blue`. Create or edit `readable-html.yaml`
only when the user explicitly asks to configure the palette.

## Update tracking

The skill is built on external authoritative sources. `references.md` is
the catalog: URL, confirmed version, last-confirmed date, files that
reflect each source, and the parts adopted. `references.md` lives at the
repo root and is **not** bundled into the built skill — it is maintainer
material.

Refresh procedure:

1. **DADS** — Check
   <https://design.digital.go.jp/dads/updates-dads/>. Reflect color
   changes in `src/references/palettes/palette-dads-*.css`, typography
   and component changes in `src/references/style-guide.css`. Update the
   DADS section of `references.md` with the new version and confirmation
   date.
2. **DADS Design Tokens** — Watch
   <https://github.com/digital-go-jp/design-tokens/releases>. On a new
   release, `npm pack @digital-go-jp/design-tokens`, diff the bundled
   `dist/tokens.css`, and update affected palette files.
3. **DADS HTML sample components** — Watch
   <https://github.com/digital-go-jp/design-system-example-components-html/commits/main>.
   Reflect relevant `heading` / `notification-banner` / `global` changes
   in `style-guide.css` and `roles.css`.
4. **HTML effectiveness article** — Watch for follow-up posts or new
   demos. New use-case categories may belong in
   `src/references/patterns.md`. Categories already declared out of scope
   (custom editors, prototypes, decks) remain out of scope by design.
5. **WCAG** — Stable in practice. Revisit on a major-version bump
   (2.2 → 2.3, etc.).

After updating any source, rebuild and verify:

```bash
make clean && make build && make package && make lint && make status
```
