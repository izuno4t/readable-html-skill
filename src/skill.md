# readable-html

Skill for producing a readable, well-structured single-file HTML document.

## In scope

- One self-contained `.html` file (shareable, opens in any browser) as the deliverable
- Focus on content **structure** and **semantics** (heading hierarchy, tables, figures, code, links, details/summary, etc.)
- A layout where the reader grasps the gist in five seconds and can jump directly to whatever they need
- The accessibility baseline (DADS / WCAG 2.2 AA-equivalent)

## Out of scope

- **Decorative design templates** — only the minimum styling needed for readability
- **Branding** (company-specific colors, fonts, logos)
- **Multi-page SPAs or web applications** — single-document outputs only

## Input format is unconstrained

The input can be source code, Markdown, design docs, conversation, or any combination. Only two things matter:

1. **What to produce** (which output type)
2. **Who reads it** (the reader's context and purpose)

## Workflow

The first three steps shape the content; the remaining three implement and verify.

### Step 1: Decide the output type

Settle on which kind of document to make. When in doubt, pick the closest match from `references/patterns.md`. Common types:

- **Spec / Implementation Plan** — handoff to the implementer
- **PR Writeup / Code Review** — guide reviewers through a diff
- **Explainer** — one-time read of a concept or mechanism
- **Status Report** — periodic update (weekly, monthly, sprint)
- **Postmortem / Incident Report** — after-the-fact review
- **Architecture Doc** — design decisions and the big picture
- **Comparison** — side-by-side evaluation of options
- **Exploration / Brainstorm** — open-ended divergence with labels

When unsure, ask "how many times will the reader read this?" **Once → lean Explainer; repeatedly → lean Spec / Reference.**

### Step 2: Write the reader and purpose in one sentence

Example: "This document is for the frontend implementer so that they can **start coding tomorrow**, with the API design and screen flow handed over." Writing this fixes what to include and what to leave out.

### Step 3: Write the outline

Before writing HTML, list only the headings. Recommended structures by output type are in `references/patterns.md`. At the outline stage, check:

- Is there a **TL;DR / summary at the top** (gist in five seconds)?
- Does the heading hierarchy go `<h1>` → `<h2>` → `<h3>` **without skipping** levels?
- Are sections at the same level **parallel** in content?
- Can the reader **jump** via links or a table of contents?

### Step 4: Write the HTML

Refer to `references/semantic-html.md` to choose semantically correct elements. Common slips:

- Don't use `<b>` / `<strong>` as a substitute for headings (use `<h2>` `<h3>`)
- Don't overuse `<div>` for document structure (use `<section>` `<article>` `<aside>` `<nav>`)
- Use tables **for data only**, not for layout
- Write collapsible details plainly with `<details>` / `<summary>`
- Always pair figures with `<figure>` / `<figcaption>`

Use HTML's full expressiveness for the content at hand. Don't settle for a simpler alternative — pick the right element.

- Data → `<table>` (don't forget `<thead>` / `<tbody>` / `scope`)
- Diagrams → inline `<svg>` (lighter and editable, unlike raster)
- Code → `<pre><code class="language-xxx">` (wrap in `<details>` if long)
- Comparison → two columns (CSS Grid) side by side
- Asides → `<aside>` or `<details>`

### Step 5: Apply the style guideline

Read the palette name from the configuration file. Look up in this order, taking the first hit:

1. **Repo-level**: `<repo-root>/readable-html.yaml`
2. **User-level**: `~/.config/readable-html/readable-html.yaml`
3. **Neither**: default to `dads-blue`

If no configuration file exists, use `dads-blue` without asking the user.

With the chosen palette name as `<choice>`, inline the following into a single `<style>` tag, in this order:

1. The contents of `references/palettes/palette-<choice>.css`
2. The contents of `references/roles.css`
3. The contents of `references/style-guide.css`

To preserve the single-file principle, do not use external `<link>` references. The only exception is when the user explicitly opts into an existing external stylesheet.

### Step 6: Accessibility check

Run through the checklist in `references/accessibility.md`. Three of the easiest to miss:

- Include `<html lang="en">` (or `ja`, etc.) on `<html>`
- Image `alt` attributes (decorative images: `alt=""`)
- Verify keyboard operation of focusable elements

## Core principles

### 1. Content first, presentation later

Build the outline before you start writing. Don't invent structure while typing tags.

### 2. Meaning at first screen

The opening TL;DR, table of contents, and heading sequence alone should tell the reader what this document is and where to read. A layout that requires scrolling all the way down to find the gist is a failure.

### 3. Don't give up on HTML's expressiveness

Don't fall back to bullet lists when a table would do. Don't fall back to prose when a diagram would do. Pick a table for data, SVG for diagrams, two columns for comparisons.

### 4. Single-file principle

Inline CSS, SVG, and any script so the document is one `xxx.html` file complete on its own. Cognitive load when sharing drops by an order of magnitude. The only exception is when the user explicitly opts into the project's existing stylesheet.

### 5. Accessibility cannot be retrofitted

Choosing semantically correct HTML does 80% of accessibility for you. Picking the right element from the start is faster than bolting on ARIA later.

## Output specification

The deliverable is a single `.html` file that satisfies:

- Starts with `<!DOCTYPE html>`
- `<html lang="...">` declares the language
- Includes `<meta charset="UTF-8">` and a viewport meta
- `<title>` reflects the content
- A `<style>` provides the styling inline; `<link>` to an external
  stylesheet only when the user explicitly opts in
- No dependence on external JS by default (inline `<script>` only when
  necessary)
- Opens and reads directly in a browser

File names use kebab-case (e.g., `auth-flow-explainer.html`).

## Reference files

- `references/patterns.md` — structure patterns by output type
- `references/semantic-html.md` — guide to choosing semantically correct HTML
- `references/accessibility.md` — A11y checklist
- `references/style-customization.md` — rules for the styling layer; consulted only when style swapping is explicitly requested

Read each as you reach the relevant step. There is no need to read everything up front.
