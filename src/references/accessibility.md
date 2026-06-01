# Accessibility Checklist

A practical checklist for HTML documents, based on the Digital Agency Design
System (DADS) and WCAG 2.2 AA.

**Numeric specs (contrast ratios, font sizes, spacing, etc.) are not written
here.** They are concentrated in the header comment of `style-guide.css`.
Swap the style guide and the numeric requirements move with it.

Run through the list from the top after writing. Each item takes seconds.

## Required (fatal if missed)

### A-1. Language attribute

```html
<html lang="en">
```

Without this, a screen reader cannot read the page in the correct language.

### A-2. Character encoding

```html
<meta charset="UTF-8">
```

Place it **first** inside `<head>`.

### A-3. Viewport

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

Without this, the page is unreadable on mobile. **Never set
`user-scalable=no`** (it disables pinch-to-zoom).

### A-4. Title

```html
<title>A concrete title that reflects the content</title>
```

Avoid placeholders like "Document," "Untitled," or "Page."

### A-5. Heading hierarchy

- One `<h1>` per page
- Don't skip levels (`<h2>` → `<h4>` is wrong)
- The headings alone should reveal the document structure

### A-6. Image `alt`

```html
<img src="..." alt="Short text that conveys the meaning">
<img src="..." alt="">  <!-- decorative image -->
```

Decision: does removing the image break the meaning?

- Yes → put the meaning in `alt`
- No (decorative) → set `alt=""` (the empty string, **always specified**)

Omitting the `alt` attribute entirely causes the screen reader to read the
file name aloud.

### A-7. Accessible name for SVG

Meaningful SVG:

```html
<svg role="img" aria-labelledby="title1 desc1">
  <title id="title1">Authentication flow</title>
  <desc id="desc1">Client through the gateway to the identity provider</desc>
  ...
</svg>
```

Decorative SVG:

```html
<svg aria-hidden="true">...</svg>
```

---

## Strongly recommended (directly affects readability)

### B-1. Link text

- "Click here," "here," "details" alone are wrong
- The link text alone should communicate the destination
- Mark external links, new tabs, PDFs, etc., explicitly

```html
<!-- Bad -->
<a href="...">Click here</a> for details

<!-- Good -->
See the <a href="...">Authentication API reference</a>.
```

Link **color and contrast** are guaranteed by `style-guide.css` via
`--role-link` / `--role-link-visited`. Don't rely on color alone — pair
it with an **underline** (`text-decoration: underline`).

### B-2. Keyboard operation

- Every interactive element (links, buttons, `<details>`, forms) is
  reachable by **Tab** in order
- The focus indicator is visible (implemented in `style-guide.css` via
  `a:focus-visible` etc.)
- Avoid `tabindex` unless necessary. If used, only `0` or `-1`

### B-3. Contrast ratio

Concrete numbers are in the "Normative summary" header comment of
`style-guide.css`: text 4.5:1 (AA) / 7:1 (AAA), non-text 3:1 (AA) /
4.5:1 (AAA). The default color variables are chosen to satisfy AA.

**Always verify when changing colors.** Tools:

- Browser extension axe DevTools / WAVE for automated checks
- WebAIM Contrast Checker (<https://webaim.org/resources/contrastchecker/>)
- Chrome DevTools → "Inspect" → "Accessibility" tab

### B-4. Don't convey information by color alone (WCAG 1.4.1)

```html
<!-- Bad: state shown only by color -->
<td style="background:red">Failed</td>

<!-- Good: text or icon alongside -->
<td>🔴 Failed</td>
<td><span aria-hidden="true">🔴</span> Failed</td>
```

This trap appears most often in status tables (🟢🟡🔴). Use **emoji +
text**.

### B-5. Focus order

Elements inside `<main>` should have a **visual order that matches the Tab
order**. Verify CSS isn't reordering them aggressively.

### B-6. Target size (WCAG 2.5.8)

The minimum effective target size for interactive controls is 24 × 24
CSS px (see "Normative summary" in `style-guide.css`). Inline links are
exempt. `style-guide.css` enforces the minimum only on `.skip-link`;
verify explicitly per element when creating icon buttons, status chips,
or similar custom controls.

---

## Recommended (better when possible)

### C-1. Landmarks

Use `<header>` `<nav>` `<main>` `<footer>`. Screen readers can jump between
landmarks. When the same landmark appears multiple times, distinguish them
with `aria-label`.

### C-2. Skip link

For long documents, include "Skip to main content" at the top.

```html
<body>
  <a class="skip-link" href="#main">Skip to main content</a>
  ...
  <main id="main">...</main>
</body>
```

Use `style-guide.css`'s `.skip-link` for the standard implementation where
the link first appears on Tab.

### C-3. Table of contents and anchors

For long content, add a TOC. Assign an `id` to each section and jump from
the TOC.

```html
<nav aria-label="Table of contents">
  <ol>
    <li><a href="#intro">Overview</a></li>
    <li><a href="#design">Design</a></li>
  </ol>
</nav>
...
<section id="intro" aria-labelledby="intro-h">
  <h2 id="intro-h">Overview</h2>
  ...
</section>
```

### C-4. Table caption and scope

```html
<table>
  <caption>...</caption>
  <thead><tr><th scope="col">...</th></tr></thead>
  ...
</table>
```

### C-5. Mixed languages

When proper nouns or quoted text in another language are embedded, mark the
spans with `lang="..."`.

```html
<p>This stands for <span lang="en">Service Level Objective</span>.</p>
```

Overuse hurts readability. Apply at the quotation or paragraph level.

### C-6. Motion sensitivity

Animations and autoplay are off by default. `style-guide.css` already
respects `prefers-reduced-motion: reduce`. When adding animation, disable
it under the same media query.

### C-7. Dark mode

`style-guide.css` is `prefers-color-scheme: dark`-aware. When adding custom
colors, define their dark counterparts too.

### C-8. Print

`style-guide.css` sets `@media print` styles (no background color, link
URL shown alongside, etc.).

---

## Automated checks

Let machines verify what they can.

- **HTML validator**: <https://validator.w3.org/> (syntax mistakes, missing
  required attributes)
- **axe DevTools** (browser extension): WCAG violations
- **Lighthouse**: built into Chrome DevTools — accessibility score and
  findings
- **WAVE**: <https://wave.webaim.org/> (contrast, heading hierarchy)

Open the file locally and run axe or Lighthouse once. Most of the items
above can be checked mechanically.

---

## What DADS emphasizes

DADS is built around these priorities. Keep them in mind when authoring
HTML documents:

- **Color combinations and contrast ratios**: B-3 (numeric values in
  `style-guide.css`)
- **Font size**: body text 16 CSS px and up (`--font-size-16` in
  `style-guide.css`)
- **Keyboard operation, focus indicator**: B-2
- **Target size for links and buttons**: B-6
- **Handling of moving objects**: C-6
- **Structure that survives size changes and content growth**: responsive,
  avoid fixed widths

Reference: <https://design.digital.go.jp/dads/guidance/accessibility/>

---

## Check procedure (30-second version)

The minimum when there is no time:

1. **`<html lang="...">`** present
2. **`<title>`** is concrete
3. **One `<h1>`**, heading hierarchy doesn't skip
4. **Images and SVG** have `alt` / `aria-label`
5. **Link text** stands on its own
6. Open in a browser and **Tab** through the elements
7. Scan with axe or Lighthouse

That alone clears most AA-level issues.
