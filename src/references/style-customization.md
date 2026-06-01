# Style Customization

This skill uses a three-layer styling structure. Inspired by the Dracula Theme
"Specification" approach, the HEX values, role mappings, and applied styles
are kept independent and swappable.

```text
references/
├── palettes/                    Layer 1: raw HEX values only
│   ├── palette-dads-blue.css
│   ├── palette-dads-blue-dark.css
│   ├── palette-dads-green.css
│   ├── palette-dads-green-dark.css
│   ├── palette-dads-purple.css
│   ├── palette-dads-purple-dark.css
│   ├── palette-dads-orange.css
│   ├── palette-dads-orange-dark.css
│   ├── palette-dracula.css
│   ├── palette-mono.css
│   ├── palette-mono-dark.css
│   └── palette-high-contrast.css
├── roles.css                    Layer 2: role-to-palette mapping
└── style-guide.css              Layer 3: styling applied to HTML elements
```

## Changing the color scheme

Swap the Layer 1 palette.

```css
/* references/palettes/palette-corporate-pink.css */
:root {
  --palette-key-1000: #c41e6b;
  /* ...other palette tokens */
}
```

Create a new `palette-*.css` and select it during HTML generation. `roles.css`
and `style-guide.css` do not need to change.

## Changing the role mapping

Edit Layer 2, `roles.css`.

```css
/* references/roles.css */
:root {
  --role-accent: var(--palette-border-subtle);
  /* ...other roles unchanged */
}
```

`palette-*.css` and `style-guide.css` do not need to change.

## Changing layout or applied styles

Edit Layer 3, `style-guide.css`, directly. Color definitions are not touched.

## Constraints

- `style-guide.css` must not reference `--palette-*` directly.
- Colors must always go through `--role-*`.
- A new palette file should be created by copying the variable list from
  `palette-dads-blue.css` and changing only the values.
- The palette variable set must not grow or shrink. `roles.css` depends on it.
- When adding a new `--role-*` variable for use in `style-guide.css`, confirm
  that every `palette-*.css` provides the corresponding `--palette-*`.

The skill body, `patterns.md`, `semantic-html.md`, and `accessibility.md` do
not depend on specific HEX values or specific style rules, so they do not
need to change when styles are swapped.
