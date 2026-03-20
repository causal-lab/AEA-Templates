# American Economic Association (AEA)

This Quarto format will help you create documents for journals published by the American Economic Association. It uses the official AEA LaTeX class (`AEA.cls`) and bibliography style (`aea.bst`). For more about the AEA's LaTeX guidelines, see <https://www.aeaweb.org/journals/templates>.

## Creating a New Article

You can use this as a template to create an article for one of the AEA journals. To do this, use the following command:

```bash
quarto use template <gh-org>/potential-fishstick
```

This will install the extension and create an example qmd file and bibliography that you can use as a starting place for your article.

## Installation For Existing Document

You may also use this format with an existing Quarto project or document. From the quarto project or document directory, run the following command to install this format:

```bash
quarto add <gh-org>/potential-fishstick
```

## Usage

To use the format, you can use the format name `aea-pdf`. For example:

```bash
quarto render article.qmd --to aea-pdf
```

or in your document yaml

```yaml
format:
  aea-pdf:
    keep-tex: true
```

## Format Options

### Journal Selection

The AEA format supports all AEA journals via the `classoption` key. The default is `AER`.

| Option | Journal                           |
|--------|-----------------------------------|
| `AER`  | American Economic Review          |
| `PP`   | Papers and Proceedings            |
| `JEL`  | Journal of Economic Literature    |
| `JEP`  | Journal of Economic Perspectives  |
| `AEJ`  | American Economic Journal         |

```yaml
format:
  aea-pdf:
    classoption: [AER]
```

### Draft and Review Modes

Add `draftmode` or `reviewmode` to `classoption` to enable draft or review formatting. Use `draft-spacing` to control line spacing in draft mode (1.5 corresponds to double spacing).

```yaml
format:
  aea-pdf:
    classoption: [AER, draftmode]
    draft-spacing: 1.5
```

### Metadata Fields

The following YAML fields map to AEA-specific LaTeX commands:

| Field               | Description                                           |
|---------------------|-------------------------------------------------------|
| `short-title`       | Running head title (`\shortTitle{}`)                  |
| `pub-month`         | Publication month                                     |
| `pub-year`          | Publication year                                      |
| `pub-volume`        | Publication volume                                    |
| `pub-issue`         | Publication issue                                     |
| `jel`               | JEL classification codes (e.g. `"D72, D78"`)         |
| `keywords`          | List of keywords                                      |
| `acknowledgements`  | Acknowledgement text (appears in author footnote)     |
| `abstract`          | Article abstract                                      |

### Authors and Affiliations

Authors and affiliations follow the standard Quarto schema. They are automatically formatted into the AEA style: author names with a `\thanks` footnote containing each author's surname, affiliation, and email.

```yaml
author:
  - name: Jane Doe
    affiliations:
      - name: University One
    email: doe@example.com
  - name: John Smith
    affiliations:
      - name: University Two
    email: smith@example.com
acknowledgements: "We thank the editor and two anonymous referees."
```

This produces:

> *By* JANE DOE AND JOHN SMITH\*
>
> \* Doe: University One (doe@example.com); Smith: University Two (smith@example.com). We thank the editor and two anonymous referees.

### Papers and Proceedings (PP)

The PP journal requires the `mathptmx` package for accurate page counts and does not use an abstract:

```yaml
format:
  aea-pdf:
    classoption: [PP]
    include-in-header:
      text: |
        \usepackage{mathptmx}
abstract: false
```

## Example

A minimal complete example:

```yaml
---
title: "The Effect of X on Y"
short-title: "Effect of X on Y"
format:
  aea-pdf:
    keep-tex: true
author:
  - name: Jane Doe
    affiliations:
      - name: MIT
        department: Department of Economics
    email: doe@mit.edu
acknowledgements: "We thank the NSF for funding."
jel: "D72, D78"
keywords:
  - Causal inference
  - Policy evaluation
abstract: |
  This paper studies the effect of X on Y using a novel identification
  strategy. We find that X increases Y by 10 percent.
bibliography: references.bib
---

This paper studies the effect of X on Y.

# Empirical Strategy

We use an instrumental variables approach.

# Results

Our main results are presented in @tbl-main.
```
