# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo produces

A single agent skill, `readable-html`, packaged separately for each supported
coding agent (currently `claude-code` and `codex`). The build composes one
agent-specific header with a shared skill body and copies bundled references
into a per-agent output directory.

## Source-of-truth rule

`src/` holds skill content that ships to agents. Repo-root docs
(`README.md`, `AGENTS.md`, `references.md`, `CLAUDE.md`) are maintainer
material and are not bundled. `agents/` and `dist/` are **generated outputs
and are gitignored** — never edit them, and never commit them. Change
`src/` and regenerate.

## Build pipeline

For each agent, `scripts/build` produces `agents/<agent>/readable-html/` by:

1. Concatenating `src/agents/<agent>/header.md` + `src/skill.md` → `SKILL.md`
2. Copying `src/readable-html.yaml.example` and the whole `src/references/`
   tree (real copy, not symlink) into the output

`scripts/package` zips each output to `dist/<agent>/readable-html.zip`.
`scripts/link` symlinks the output into the agent's local skills directory
(`~/.claude/skills/readable-html` or `~/.codex/skills/readable-html`).

## Common commands

```bash
make build                    # generate agents/<agent>/readable-html/ for all agents
make build AGENT=codex        # one agent only
make package                  # build, then zip to dist/<agent>/readable-html.zip
make install                  # build, then create local symlinks
make uninstall                # remove local symlinks
make status                   # show build / package / link state per agent
make clean                    # rm -rf agents dist
make lint                     # markdownlint-cli2 + cspell + bash -n on scripts
```

`AGENT` defaults to `all`. `make install` and `make package` always run
`make build` first.

There is no unit test suite. Verify a change with:

```bash
make clean && make build && make package && make lint && make status
```

For packaging changes, also inspect an archive: `unzip -l dist/codex/readable-html.zip`.

## Adding a new agent

1. Create `src/agents/<name>/header.md` (the agent-specific frontmatter).
2. Add `<name>` to the hard-coded agent list in **both** `scripts/link` and
   `scripts/status` (each contains a `destination_for` case statement and a
   loop over `claude-code codex`). `scripts/build` and `scripts/package` pick
   up new agents automatically from `src/agents/`, but `link`/`status` do not.
3. Verify with `make build AGENT=<name>` and `make status`.

## File language convention

Mixed by design:

- `README.md`, `AGENTS.md`, shell scripts, this file → English
- `src/skill.md` and `src/agents/*/header.md` → Japanese (the skill ships to
  Japanese-speaking users; English trigger phrases are appended inside the
  same description string)
- `src/references/*.md` → Japanese

When editing, match the file's existing language.

## Script conventions

POSIX-friendly Bash with `set -euo pipefail`. Paths are derived from
`SCRIPT_DIR`/`ROOT_DIR` so scripts work regardless of `cwd`. Generated paths
are fixed: `agents/<agent>/readable-html` and `dist/<agent>/readable-html.zip`.
`make lint` runs `bash -n` on every script — keep them syntactically valid
even before runtime testing.

## Palette configuration (runtime behavior of the built skill)

The built skill resolves a palette name at use-time from, in order:
`<repo-root>/readable-html.yaml`, `~/.config/readable-html/readable-html.yaml`,
or default `dads-blue`. The skill must not prompt the user for a palette
during normal execution. Palette CSS files live in `src/references/palettes/`
and are inlined into the generated HTML alongside `roles.css` and
`style-guide.css` — the built skill never emits external `<link>` references.
