# 参照リソース

このスキルが構築の根拠としている外部ソースのカタログ。
リポジトリ直下に置き、ビルド時にバンドルしない（メンテナ向けのドキュメント）。
更新時の手順は `README.md` の「Update tracking」を参照。

各ソースについて次を記載:
- URL
- 確認バージョン (該当があれば)
- 最終確認日
- 反映ファイル
- 採用した内容の要約

---

## 1. DADS (デジタル庁デザインシステム)

スキルのスタイルガイドラインの主軸。

- メインサイト: <https://design.digital.go.jp/dads/>
- 確認バージョン: **v2.14.0**
- 最終確認日: **2026-06-01**
- 反映ファイル:
  - `references/palettes/palette-dads-blue.css` および dark 版
  - `references/palettes/palette-dads-green.css` および dark 版
  - `references/palettes/palette-dads-purple.css` および dark 版
  - `references/palettes/palette-dads-orange.css` および dark 版
  - `references/palettes/palette-mono.css` および dark 版
  - `references/palettes/palette-high-contrast.css`
  - `references/roles.css`
  - `references/style-guide.css`
  - `references/accessibility.md`
- 参照したサブページ:
  - カラー: <https://design.digital.go.jp/dads/foundations/color/>
  - カラーパレット: <https://design.digital.go.jp/dads/foundations/color/color-palette/>
  - タイポグラフィ: <https://design.digital.go.jp/dads/foundations/typography/>
  - 余白: <https://design.digital.go.jp/dads/foundations/spacing/>
  - リンクテキスト: <https://design.digital.go.jp/dads/foundations/link-text/>
  - 角の形状: <https://design.digital.go.jp/dads/foundations/corner-shapes/>
  - アクセシビリティ: <https://design.digital.go.jp/dads/guidance/accessibility/>
- 採用内容:
  - カラー体系 (Primitive Colors / Neutral Colors / Semantic Colors)
  - タイポグラフィスケール (Standard スタイルの font-size, line-height)
  - 余白スケール (8px 基準、×1/×2/×3/×5/×8)
  - リンクテキストの色とインタラクション仕様
  - 角の形状トークン (4/8/12px)
  - アクセシビリティ要件 (テキスト 4.5:1、非テキスト 3:1)

---

## 2. DADS Design Tokens (npm パッケージ)

DADS の公式デザイントークン (HEX値の権威ある情報源)。

- npm: <https://www.npmjs.com/package/@digital-go-jp/design-tokens>
- GitHub: <https://github.com/digital-go-jp/design-tokens>
- 確認バージョン: **v1.1.9** (Figma v2.10.1 対応)
- 最終確認日: **2026-06-01**
- 反映ファイル: `references/palettes/palette-dads-*.css`
- 採用内容:
  - `dist/tokens.css` の Primitive Tokens (blue/light-blue/cyan/green/lime/yellow/orange/red/magenta/purple の各12階調 + neutral) をそのまま転記
  - カラー値は機械生成された権威ある値で、目視で写すよりも正確

---

## 3. DADS HTML サンプルコンポーネント

DADS の公式 HTML 実装。コンポーネントスタイル (heading の data-chip / data-rule、notification banner の color-chip 等) の実装根拠。

- GitHub: <https://github.com/digital-go-jp/design-system-example-components-html>
- Storybook: <https://design.digital.go.jp/dads/html/>
- 確認バージョン: **main branch** (2026-06-01 時点)
- 最終確認日: **2026-06-01**
- 反映ファイル: `references/style-guide.css`, `references/roles.css`
- 参照した具体コンポーネント:
  - `src/global.css`: リンクとフォーカスの実装 (text-decoration-thickness、focus-visible の多重表示)
  - `src/components/heading/heading.css`: h2 の左カラーチップ (`data-chip`)、h1 の下ボーダー (`data-rule`)
  - `src/components/notification-banner/notification-banner.css`: コールアウトの color-chip スタイル (`box-shadow: inset` でカラーチップ + 細い枠線)
- 採用内容:
  - 上記コンポーネントの視覚装飾アプローチを `style-guide.css` の h1/h2、`aside[data-callout]`、`dl.qa` 等に反映

---

## 4. Dracula Theme

スキル全体の構造設計 (3層分離) の着想元。

- メインサイト: <https://draculatheme.com/>
- Specification: <https://draculatheme.com/spec>
- Contribute: <https://draculatheme.com/contribute>
- GitHub: <https://github.com/dracula/dracula-theme>
- 最終確認日: **2026-06-01**
- 反映ファイル:
  - スキル全体の構造設計 (palette / roles / style-guide の3層分離)
  - `references/palettes/palette-dracula.css` (Dracula 公式12色をパレットとして採用)
- 採用したアイデア:
  - **3層分離**: 「HEX値 → 役割名 → 適用箇所」の各層が独立。Dracula が400+アプリへの移植を可能にしている設計原理
  - Dracula 公式12色: Background / Current Line / Selection / Foreground / Comment / Red / Orange / Yellow / Green / Cyan / Purple / Pink
- 採用しなかった要素:
  - Dracula は元々ダーク前提のテーマ。Light 版の Alucard は本スキルでは未採用

### Dracula 公式12色のHEX値

| Token | HEX |
|-------|-----|
| Background | #282A36 |
| Current Line | #44475A |
| Selection | #44475A |
| Foreground | #F8F8F2 |
| Comment | #6272A4 |
| Red | #FF5555 |
| Orange | #FFB86C |
| Yellow | #F1FA8C |
| Green | #50FA7B |
| Cyan | #8BE9FD |
| Purple | #BD93F9 |
| Pink | #FF79C6 |

---

## 5. HTML効果性 (Anthropic Claude Code チーム)

スキルが扱う構造パターン (Spec / PR Writeup / Explainer / Report 等) のユースケース整理の根拠。

- Blog: <https://claude.com/blog/using-claude-code-the-unreasonable-effectiveness-of-html>
- Demos: <https://thariqs.github.io/html-effectiveness/>
- GitHub gallery: <https://github.com/anthropics/html-effectiveness>
- 公開日: 2026-05-20
- 著者: Thariq Shihipar (Claude Code チーム)
- 最終確認日: **2026-06-01**
- 反映ファイル: `SKILL.md`, `references/patterns.md`
- 採用範囲:
  - 「読むHTML」ユースケース: Spec / Implementation Plan / PR Writeup / Code Explainer / Concept Explainer / Status Report / Postmortem / Architecture Doc / Comparison / Exploration
  - 「HTMLの情報密度」(表/SVG/コード/details/summary) の活用
  - 「単一HTMLファイルでの共有のしやすさ」
- スコープ外として明示:
  - Custom Editing Interfaces (Triage board / Feature flag editor / Prompt tuner) — 別スキル領域
  - Prototyping (Animation sandbox / Clickable flow) — 別スキル領域
  - Decks (Slide deck) — 別スキル領域

---

## 6. WCAG 2.2 (Web Content Accessibility Guidelines)

アクセシビリティ要件の権威。

- 日本語訳: <https://waic.jp/translations/WCAG22/>
- 原文: <https://www.w3.org/TR/WCAG22/>
- 最終確認日: **2026-06-01**
- 反映ファイル: `references/accessibility.md`, `references/style-guide.css`
- 採用した達成基準:
  - **1.4.3 コントラスト (最低限) AA**: テキスト 4.5:1
  - **1.4.11 非テキストのコントラスト AA**: 非テキスト 3:1
  - **1.4.1 色の使用 A**: 色だけで情報を伝えない
  - **2.4.7 フォーカスの可視化 AA**: フォーカスインジケータ
  - **2.5.8 ターゲットサイズ (最低限) AA**: 24×24 CSS px
  - **2.3.3 アニメーション (相互作用から) AAA**: prefers-reduced-motion
- AAA を狙う場面向け: `palette-high-contrast.css` がテキスト 7:1 を満たすよう構成

---

## 変更履歴

| 日付 | 内容 |
|------|------|
| 2026-06-01 | 初版作成。上記すべての参照リソースを反映 |
