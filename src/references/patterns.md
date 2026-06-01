# Pattern Catalog

Structural templates per output type. Every pattern assumes "the gist is
graspable at the top" and "the reader can jump."

## Quick reference

| Pattern | Primary purpose | Central elements |
|---------|-----------------|------------------|
| Spec / Implementation Plan | Implementation handoff | Outline + diagrams + code excerpts + risk table |
| PR Writeup | Reviewer guidance | Diff summary + per-file tour + focus points |
| Code Explainer | Mechanism explanation | TL;DR + flow diagram + code excerpts + FAQ |
| Concept Explainer | Concept learning | Intuitive description + comparison table + glossary |
| Status Report | Periodic update | Progress list + numbers + issues and next actions |
| Postmortem | After-the-fact review | Timeline + root cause + improvement items |
| Architecture Doc | Design communication | Big picture + components + design decisions |
| Comparison | Option evaluation | Parallel columns + comparison table + recommendation |
| Exploration | Divergent proposals | Parallel cards + trade-off labels |

---

## 1. Spec / Implementation Plan

A document that gets the reader "ready to write code tomorrow."

### Structure

```
<h1>Feature name: Implementation plan</h1>

<section aria-labelledby="summary">
  <h2 id="summary">TL;DR</h2>
  - What is being built (1-2 sentences)
  - Why it is being built (1 sentence)
  - In scope and out of scope (bullets)
</section>

<nav aria-label="Table of contents">
  TOC (links to each section)
</nav>

<section><h2>Background and purpose</h2></section>
<section><h2>Requirements</h2>
  <h3>Functional</h3>
  <h3>Non-functional</h3>
</section>
<section><h2>Architecture</h2>
  <figure>Configuration diagram in SVG</figure>
</section>
<section><h2>Data model</h2>
  <table>Entities and fields</table>
</section>
<section><h2>API / interface</h2>
  <pre><code>Example request/response</code></pre>
</section>
<section><h2>Screen flow / UX</h2>
  <figure>Flow in SVG</figure>
</section>
<section><h2>Implementation steps</h2>
  <ol>Milestones</ol>
</section>
<section><h2>Risks and open items</h2>
  <table>Risk / impact / mitigation</table>
</section>
```

### Tips

- Use `<ol>` for milestones — order has meaning
- A risk table should have at least four columns: item / impact /
  mitigation / owner
- API examples must be **near-real JSON / code** (don't escape into
  pseudocode)

---

## 2. PR Writeup / Code Review

A document that guides reviewers on "where to look and how to read."

### Structure

```
<h1>PR: Feature name</h1>

<section><h2>TL;DR</h2>
  - What changes in this PR (1-3 lines)
  - Is there a risky change? (Yes/No and where)
</section>

<section><h2>Background and motivation</h2></section>
<section><h2>Before / After</h2>
  <div class="side-by-side">  <!-- Grid two-column -->
    <figure><figcaption>Before</figcaption><pre>...</pre></figure>
    <figure><figcaption>After</figcaption><pre>...</pre></figure>
  </div>
</section>

<section><h2>Per-file tour</h2>
  <details><summary>src/auth/handler.ts</summary>
    <p>Intent of the change and what the reviewer should look at</p>
    <pre><code>Relevant diff excerpt</code></pre>
  </details>
  <details>...</details>
</section>

<section><h2>Review focus</h2>
  <ul>
    <li>Specific spots and the reason</li>
  </ul>
</section>

<section><h2>Tests</h2></section>
<section><h2>Open / follow-up</h2></section>
```

### Tips

- Wrapping each file in `<details>` lets the reviewer **open only what
  interests them**
- Color the diff (added=green, removed=red) with `.diff-add` / `.diff-del`
  from `references/style-guide.css`
- A "focus" section helps the reviewer concentrate

---

## 3. Code Explainer

Explain **how** a specific feature or module works.

### Structure

```
<h1>How X works</h1>

<section><h2>TL;DR</h2>
  3-5 lines of summary at the "Y is called, goes through Z, ends as W" level
</section>

<section><h2>End-to-end flow</h2>
  <figure>
    <svg>Sequence diagram or data flow diagram</svg>
    <figcaption>...</figcaption>
  </figure>
</section>

<section><h2>Key steps</h2>
  <ol>
    <li><h3>1. Accept the request</h3>
      <p>Overview</p>
      <pre><code>Relevant code excerpt</code></pre>
      <p>Important point here</p>
    </li>
    <li><h3>2. ...</h3></li>
  </ol>
</section>

<section><h2>Common misconceptions / Gotchas</h2>
  <dl class="qa">
    <dt>Q. ...</dt><dd>A. ...</dd>
  </dl>
</section>

<section><h2>Related links</h2></section>
```

### Tips

- **Always draw the flow in SVG.** Ten times faster to grasp than a bullet
  list
- Code excerpts are the **relevant few lines only**. Context goes in prose
- Gotchas belong in `<dl class="qa">` (definition list + Q/A decoration).
  A "Q" chip on each `<dt>` makes questions visually pop

---

## 4. Concept Explainer

Explain an abstract concept (Consistent Hashing, Rate Limiting, etc.).

### Structure

```
<h1>What is X</h1>

<section><h2>In one sentence</h2>
  <p>Definition in ~30 words</p>
</section>

<section><h2>Why it matters</h2>
  <p>What breaks without X</p>
</section>

<section><h2>Intuitive analogy</h2>
  <p>Map it to something everyday. A diagram helps</p>
</section>

<section><h2>How it works</h2>
  <figure>Diagram</figure>
  <p>Description of the operation</p>
</section>

<section><h2>Difference from similar concepts</h2>
  <table>
    <thead><tr><th>Aspect</th><th>X</th><th>Y</th></tr></thead>
    <tbody>...</tbody>
  </table>
</section>

<section><h2>Glossary</h2>
  <dl>...</dl>
</section>
```

### Tips

- **Put "Why it matters" before "How it works."** Don't explain mechanism
  without motivation
- In the comparison table, put the concept the reader **already knows on
  the left** and the new concept on the right

---

## 5. Status Report

Weekly / monthly / sprint updates. Scannability above all.

### Structure

```
<h1>YYYY-MM-DD weekly report</h1>

<section><h2>Highlights</h2>
  <ul>
    <li>✅ Completed items (3-5)</li>
  </ul>
</section>

<section><h2>Progress</h2>
  <table>
    <thead><tr><th>Item</th><th>Status</th><th>Due</th><th>Notes</th></tr></thead>
    <tbody>
      <tr><td>...</td><td>🟢 On Track</td>...</tr>
      <tr><td>...</td><td>🟡 At Risk</td>...</tr>
      <tr><td>...</td><td>🔴 Blocked</td>...</tr>
    </tbody>
  </table>
</section>

<section><h2>Numbers</h2>
  <figure>Simple bar chart or trend line in SVG</figure>
</section>

<section><h2>Issues</h2></section>
<section><h2>Next week</h2></section>
```

### Tips

- Color-coded status (🟢🟡🔴) should always carry **both emoji and text**
  (color-vision accessibility)
- Don't overdesign charts. **Bar length or point position** alone should
  convey the meaning
- For weekly cadence, the chart can be omitted (reserve for monthly /
  quarterly)

---

## 6. Postmortem / Incident Report

After-the-fact review. Timeline and root cause are the core.

### Structure

```
<h1>Incident: Title (YYYY-MM-DD)</h1>

<section><h2>Summary</h2>
  <dl>
    <dt>Occurred</dt><dd>...</dd>
    <dt>Recovered</dt><dd>...</dd>
    <dt>Impact</dt><dd>...</dd>
    <dt>Severity</dt><dd>SEV-N</dd>
  </dl>
</section>

<section><h2>Timeline</h2>
  <ol class="timeline">
    <li><time>14:23</time> Monitoring alert fired</li>
    <li><time>14:25</time> On-call engaged</li>
    ...
  </ol>
</section>

<section><h2>Scope of impact</h2></section>

<section><h2>Root cause</h2>
  <p>Facts only — avoid blame</p>
</section>

<section><h2>What went well</h2>
  <ul></ul>
</section>

<section><h2>What did not go well</h2>
  <ul></ul>
</section>

<section><h2>Action items</h2>
  <table>
    <thead><tr><th>Item</th><th>Owner</th><th>Due</th><th>Status</th></tr></thead>
    ...
  </table>
</section>
```

### Tips

- `<ol>` + `<time>` for the timeline is semantically correct
- Writing "what went well" first keeps the retrospective healthy
- Every action item needs **an owner and a due date**

---

## 7. Architecture Doc

Convey the big picture and the design decisions.

### Structure

```
<h1>System name — architecture</h1>

<section><h2>Big picture</h2>
  <figure>Configuration diagram in SVG</figure>
</section>

<section><h2>Components</h2>
  <section><h3>Component A</h3>
    <p>Role and responsibility</p>
    <p>Dependencies</p>
  </section>
  <section><h3>Component B</h3></section>
</section>

<section><h2>Key flows</h2>
  <figure>Sequence diagram in SVG</figure>
</section>

<section><h2>Design decisions</h2>
  <section><h3>Decision: adopt X</h3>
    <dl>
      <dt>Options</dt><dd>X, Y, Z</dd>
      <dt>Rationale</dt><dd>...</dd>
      <dt>Trade-offs</dt><dd>...</dd>
    </dl>
  </section>
</section>

<section><h2>Operations</h2>
  <p>Monitoring, scaling, behavior under failure</p>
</section>
```

### Tips

- Design decisions can borrow ADR structure (Context → Decision →
  Consequences)
- **Don't mix** a network diagram with a logical structure diagram

---

## 8. Comparison / Side-by-side

Compare multiple options side by side.

### Structure

```
<h1>X vs Y vs Z</h1>

<section><h2>Conclusion</h2>
  <p>Which is recommended and why</p>
</section>

<section><h2>Side by side</h2>
  <div class="side-by-side">  <!-- Grid equal-width columns -->
    <article><h3>X</h3>
      <p>Overview</p>
      <h4>Pros</h4><ul></ul>
      <h4>Cons</h4><ul></ul>
    </article>
    <article><h3>Y</h3>...</article>
    <article><h3>Z</h3>...</article>
  </div>
</section>

<section><h2>Comparison table</h2>
  <table>
    <thead><tr><th scope="col">Aspect</th><th>X</th><th>Y</th><th>Z</th></tr></thead>
    <tbody>...</tbody>
  </table>
</section>

<section><h2>Recommendation</h2></section>
```

### Tips

- Provide **both** columns and a table. Columns convey detail; the table
  conveys the summary
- Lead with the conclusion. Never make the verdict reachable only at the
  end

---

## 9. Exploration / Brainstorm

Present multiple options divergently and let the reader choose.

### Structure

```
<h1>Direction for X — N options</h1>

<section><h2>Premise</h2>
  <p>What is being solved, and what the constraints are</p>
</section>

<section><h2>Options</h2>
  <div class="card-grid">  <!-- Grid parallel cards -->
    <article>
      <h3>Option A: one-line label</h3>
      <p class="tradeoff">Trade-off: "fast but fragile" etc.</p>
      <p>Overview</p>
      <h4>Pros</h4><ul></ul>
      <h4>Cons</h4><ul></ul>
    </article>
    <article>Option B...</article>
  </div>
</section>

<section><h2>How to choose</h2>
  <p>Which option to pick depending on priorities</p>
</section>
```

### Tips

- Give every option **a one-line label** ("Conservative option," "Bold
  option")
- Put the trade-off **first** (helps the reader decide)
- Don't recommend, or recommend lightly — it is still exploration; let the
  reader choose

---

## Common anti-patterns

- Jumping straight into the body. **TL;DR / summary / conclusion** always
  goes at the top
- Section names like "Overview," "Details," "Other." Use names that
  **describe the content**
- Tables and lists used interchangeably. **A table compares parallel items
  by aspect; a list enumerates**
- No diagrams at all. **One diagram per document** is the floor
- No way to jump. Provide **a TOC or anchor links to headings**
