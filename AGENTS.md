# Repository Guidelines

## Project Structure & Module Organization

This repository maintains the `readable-html` skill for multiple coding agents.
The source of truth is `src/`.

- `src/skill.md`: shared, agent-neutral skill body.
- `src/agents/<agent>/header.md`: agent-specific frontmatter.
- `src/references/`: bundled reference docs, CSS, and palettes.
- `agents/`: generated local-install skill directories; ignored by git.
- `dist/`: generated package archives; ignored by git.
- `scripts/`: build, packaging, install-link, and status helpers.

Do not edit generated files under `agents/` or `dist/`. Change `src/` and
regenerate outputs.

## Build, Test, and Development Commands

- `make build`: generate `agents/<agent>/readable-html/` outputs.
- `make install`: run `make build`, then create local symlinks for supported
  agents.
- `make package`: run `make build`, then create zip archives in `dist/<agent>/`.
- `make status`: show generated output, package, and symlink status.
- `make clean`: remove generated `agents/` and `dist/` directories.
- `make lint`: run Markdown lint for `README.md` and shell syntax checks.

Use `AGENT=codex` or `AGENT=claude-code` to target one agent, for example
`make package AGENT=codex`.

## Coding Style & Naming Conventions

Use POSIX-friendly Bash with `set -euo pipefail` for scripts. Keep generated
paths predictable: `agents/<agent>/readable-html` and
`dist/<agent>/readable-html.zip`. Markdown files should use ATX headings,
fenced code block languages, and concise sections. Prefer `.yaml` over `.yml`
for configuration examples.

## Testing Guidelines

There is no unit test suite. Verify changes with:

```bash
make clean
make build
make package
make lint
make status
```

When packaging changes, inspect at least one archive with
`unzip -l dist/codex/readable-html.zip`.

## Commit & Pull Request Guidelines

The current git history only contains `Initial commit`, so no established
commit convention exists. Use short, imperative commit subjects such as
`Add package script` or `Refine skill workflow`.

Pull requests should describe the source changes, generated behavior, and
verification commands run. Mention whether `agents/` or `dist/` were
regenerated locally; they should remain untracked.

## Agent-Specific Instructions

Agent-specific behavior belongs in `src/agents/<agent>/header.md`. Shared
workflow guidance belongs in `src/skill.md`. Add a new agent by creating its
header and confirming `make build AGENT=<agent>` works.
