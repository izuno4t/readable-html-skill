# Guide to Writing Semantically Correct HTML

Pick HTML elements by **meaning**, not by appearance. Correct semantics
align accessibility, SEO, future style changes, and screen reader output
naturally.

## Document skeleton

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Concrete Title — Subtitle</title>
  <style>/* contents of style-guide.css */</style>
</head>
<body>
  <header>
    <h1>Document title</h1>
    <p class="lede">Short summary (1-2 sentences)</p>
  </header>

  <nav aria-label="Table of contents">
    <ol>...</ol>
  </nav>

  <main>
    <section aria-labelledby="s1">
      <h2 id="s1">Section title</h2>
      ...
    </section>
  </main>

  <footer>
    <p>Created: YYYY-MM-DD / Author</p>
  </footer>
</body>
</html>
```

### Notes

- Set `<html lang="...">` **always**. Screen readers need it to switch
  language.
- Make `<title>` concrete. Avoid "Document" or "Spec" on their own.
- Use `<header>` `<nav>` `<main>` `<footer>` to create landmarks.
- `<main>` appears **only once** per document.

---

## Heading hierarchy

### Rules

1. **One `<h1>` per document** (the page title)
2. **Don't skip levels** (`<h4>` immediately after `<h2>` is wrong)
3. **Don't pick by appearance** (using `<h4>` because you want smaller text
   violates the semantics)

### Correct example

```html
<h1>API Design</h1>
<h2>Authentication</h2>
  <h3>JWT token issuance</h3>
  <h3>Refresh</h3>
<h2>Endpoints</h2>
  <h3>Users</h3>
    <h4>GET /users/:id</h4>
    <h4>POST /users</h4>
```

### "Looks like a heading but isn't"

- Card labels → `<h3>` etc. is correct (headings inside a landmark are part
  of the outline)
- Dialog titles → `<h2>` etc. is fine
- Plain emphasis → use `<strong>`, not a heading

---

## Landmark elements

Screen readers can **jump between landmarks**. These are the skeleton of
a page.

| Element | Use | Multiple allowed |
|---------|-----|------------------|
| `<header>` | Header area (title etc.) | Allowed inside each `<section>` |
| `<nav>` | Navigation, TOC | Multiple OK |
| `<main>` | Primary content | **Only one** |
| `<aside>` | Aside / sidebar | Multiple OK |
| `<footer>` | Footer / footnotes | Allowed inside each section |
| `<section>` | Themed group | Multiple OK |
| `<article>` | Self-contained content | Multiple OK |

### `<section>` vs `<article>`

- `<section>`: a logical group inside the document (chapter, section)
- `<article>`: self-contained on its own (blog post, card, comment)

When unsure, use `<section>`.

### Multiple landmarks of the same kind need `aria-label`

```html
<nav aria-label="Table of contents">...</nav>
<nav aria-label="Breadcrumb">...</nav>
```

---

## Lists

| Element | Use |
|---------|-----|
| `<ul>` | Items without significant order |
| `<ol>` | Order matters (steps, priority, timeline) |
| `<dl>` | Name/value pairs (glossary, metadata) |

### `<dl>` example

```html
<dl>
  <dt>Occurred at</dt>
  <dd>2026-05-30 14:23</dd>
  <dt>Impact</dt>
  <dd>All users unable to sign in</dd>
</dl>
```

More useful than it looks. Great for incident summaries, FAQs, glossaries,
and attribute lists.

---

## Tables

Use a table only when expressing data in rows and columns. **Never use a
table for layout.**

### Minimum structure

```html
<table>
  <caption>Releases per product, FY2026 Q1</caption>
  <thead>
    <tr>
      <th scope="col">Product</th>
      <th scope="col">Releases</th>
      <th scope="col">Δ vs. previous quarter</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">A</th>
      <td>12</td>
      <td>+20%</td>
    </tr>
  </tbody>
</table>
```

### Notes

- Use `<caption>` to describe the table's purpose (read aloud by screen
  readers)
- Add `scope="col"` or `scope="row"` to each `<th>`
- Keep cell spans (`colspan` / `rowspan`) to a minimum (they hurt
  readability)

---

## Figures

### `<figure>` and `<figcaption>`

```html
<figure>
  <svg>...</svg>
  <figcaption>Figure 1: Authentication flow (client → gateway → identity provider)</figcaption>
</figure>
```

- Always caption a figure
- Numbering (Figure 1, Figure 2…) lets the body reference it

### Why SVG

- Scales without quality loss
- Searchable as text
- Stylable with CSS
- Parts can become `<a>` links
- LLMs can author it directly (much easier than PNG)

### SVG accessibility

```html
<svg role="img" aria-labelledby="diag1-title diag1-desc">
  <title id="diag1-title">Authentication flow</title>
  <desc id="diag1-desc">Client requests a token from the identity provider via the gateway</desc>
  ...
</svg>
```

Decorative SVG: add `aria-hidden="true"`.

---

## Code blocks

```html
<pre><code class="language-typescript">
function authenticate(token: string) {
  // ...
}
</code></pre>
```

### Notes

- Inline code is `<code>` alone
- Block code nests `<code>` inside `<pre>`
- Add a language class (`language-xxx`) for syntax highlighting
- Wrap long code in `<details>`

```html
<details>
  <summary>Show full implementation (50 lines)</summary>
  <pre><code>...</code></pre>
</details>
```

### Showing a diff

```html
<pre><code class="language-diff">
 function auth() {
-  return token;
+  return validateAndReturn(token);
 }
</code></pre>
```

Apply `.diff-add` `.diff-del` for colors. `style-guide.css` provides them.

---

## Links

```html
<a href="#section-2">2. Authentication flow</a>
<a href="https://example.com/spec.pdf">Protocol spec (PDF)</a>
```

### Notes

- Link text should **stand on its own** ("here," "click" are not enough)
- State external links, new tabs, and file types explicitly
- Anchor links (`#id`) jump within the document

---

## Collapsibles

`<details>` / `<summary>` provides JavaScript-free collapsibles.

```html
<details>
  <summary>Show details</summary>
  <p>...</p>
</details>

<details open>
  <summary>Open by default</summary>
  ...
</details>
```

### When to use

- Per-file diffs in a PR review
- FAQ
- Optional technical details
- Logs or long code

---

## Emphasis

| Element | Meaning |
|---------|---------|
| `<strong>` | Importance |
| `<em>` | Emphasis / stress |
| `<mark>` | Highlight (search results, referenced spans) |
| `<b>` | Appearance only (no meaning) |
| `<i>` | Appearance only (no meaning) |

Use `<strong>` / `<em>` for meaningful emphasis.

### Callouts (note, warning, supplement)

To visually separate "important," "be careful," or "supplement" content
from the body, do not reach for a `<div>` with custom backgrounds. Use
`<aside data-callout="...">` for the semantics and the style-guide-aware
coloring.

```html
<aside data-callout="info">
  <strong class="callout-title">Note</strong>
  ...
</aside>

<aside data-callout="warning">
  <strong class="callout-title">Caution</strong>
  ...
</aside>

<aside data-callout="error">
  <strong class="callout-title">Critical</strong>
  ...
</aside>

<aside data-callout="success">
  <strong class="callout-title">Success</strong>
  ...
</aside>

<aside data-callout="question">
  <strong class="callout-title">Q.</strong>
  ...
</aside>
```

`<aside>` carries the meaning "supplementary information independent of the
main flow," making it a natural fit for callouts. For several consecutive
callouts, a `.callout` class on `<div>` is acceptable (you lose the
`<aside>` semantics in that case).

### Q&A (Gotchas, FAQ)

For multiple question/answer pairs, use `<dl class="qa">`. Each `<dt>`
shows a "Q" chip.

```html
<dl class="qa">
  <dt>Q. Does the bucket start empty?</dt>
  <dd>A. No, it is initialized full via defaultdict(lambda: capacity).</dd>
  <dt>Q. ...</dt>
  <dd>A. ...</dd>
</dl>
```

---

## Quotations

```html
<blockquote cite="https://example.com/source">
  <p>Quoted text</p>
  <footer>— Author, <cite>Source</cite></footer>
</blockquote>
```

Short inline quotes go in `<q>`.

---

## Time

```html
<time datetime="2026-05-30T14:23:00+09:00">2026-05-30 14:23</time>
```

Handy for postmortem timelines.

---

## Address / contact

```html
<address>
  Author: Taro Yamada (<a href="mailto:yamada@example.com">yamada@example.com</a>)
</address>
```

`<address>` is for contact information only. Do not use it for general
postal addresses.

---

## Quick anti-pattern reference

| Common mistake | Use instead |
|----------------|-------------|
| `<div onclick="...">` | `<button>` |
| `<span class="title">` | `<h2>` etc. |
| `<b>Important</b>` (meaningful) | `<strong>Important</strong>` |
| `<br><br>` for paragraph breaks | `<p>` |
| Tables for layout | CSS Grid / Flexbox |
| `<div class="list">` + `<div>` | `<ul>` + `<li>` |
| Oversized `<p>` standing in for a heading | `<h2>` `<h3>` |
| Decorative emoji wrapped in `<span>` | Add `aria-hidden="true"` |

---

## One-line check

After writing, glance at the HTML and answer:

- **Does the heading list reveal the structure?**
- **Are all uses of `<div>` truly impossible to replace with something else?**
- **Does every image and SVG have a caption or `alt`?**
- **Does the link text stand on its own?**

All yes → the semantics are roughly right.
