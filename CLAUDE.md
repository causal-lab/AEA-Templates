# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Quarto format extension** for American Economic Association (AEA) journals. It wraps the official AEA LaTeX class (`AEA.cls`) and bibliography style (`aea.bst`) into a Quarto-native `aea-pdf` format. The GitHub repository is `causal-lab/AEA-Templates`.

## Commands

### Render the template to PDF
```bash
quarto render template.qmd --to aea-pdf
```

### Install the extension into an existing Quarto project
```bash
quarto add causal-lab/AEA-Templates
```

## Architecture

The extension lives entirely under `_extensions/aea/`:

- **`_extension.yml`** — Declares the `pdf` format contribution: document class, PDF engine (pdflatex), citation method (natbib), default class option (AER), figure dimensions, and lists format resources and template partials.
- **`AEA.cls`** / **`aea.bst`** — Upstream AEA LaTeX class and BibTeX style, bundled as format resources.
- **`setspace.sty`** / **`multicol.sty`** — Vendored LaTeX packages required by AEA.cls.
- **`partials/`** — Quarto template partials that bridge Quarto YAML metadata to AEA LaTeX commands:
  - `doc-class.tex` — Passes `leqno` to amsmath before loading the AEA document class (prevents option clashes).
  - `before-body.tex` — Maps YAML fields (`title`, `short-title`, `author`, `jel`, `keywords`, `abstract`, `pub-*`, `acknowledgements`) to corresponding AEA LaTeX macros, then calls `\maketitle`.
  - `title.tex` — Handles `draft-spacing` via `\draftSpacing{}`.

### Key design detail
Author formatting is assembled in `before-body.tex` using Quarto's `by-author` variable. The `\thanks{}` footnote concatenates each author's surname, first affiliation name, and email, separated by semicolons, with acknowledgements appended.

## CI

GitHub Actions workflow (`.github/workflows/test-format.yml`) runs on push/PR to `main`, weekly, and manual dispatch. It sets up R, installs `knitr`/`rmarkdown`, installs Quarto pre-release with TinyTeX, renders `template.qmd`, and uploads the PDF as artifact `AER-pdf`.

## Supported Journal Options

Set via `classoption` in YAML: `AER` (default), `PP`, `JEL`, `JEP`, `AEJ`. Append `draftmode` or `reviewmode` for draft/review formatting. PP journal requires `\usepackage{mathptmx}` in header.
