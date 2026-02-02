# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**NMU Module Guide Template** is a Quarto template extension for creating module guides for Nelson Mandela University's Faculty of Science. The template compiles to Microsoft Word documents with university branding and zero manual formatting required.

Key characteristics:
- Designed for distribution via `quarto use template` command
- Two-filter Lua system: `cover-page.lua` (professional cover page) and `custom-styles.lua` (custom block styles)
- R code integration for dynamic content (tables, plots, statistical analysis)
- Pre-configured Word reference document with NMU custom styles (CustomBlock* styles)
- Optional professional cover page with NMU branding
- Licensed under GNU GPL v3

## Official NMU Color Palette

- **Primary Green**: `#006B34` (RGB 0, 107, 52)
- **Dark Blue**: `#18324B` (RGB 24, 50, 75)
- **Purple**: `#6C284F` (RGB 108, 40, 79)

## Essential Commands

### Rendering a Module Guide

The primary workflow is:

```bash
# Render the template to Word document
quarto render template.qmd

# Or render a specific custom .qmd file
quarto render [module-name].qmd
```

Output Word documents are saved to the same directory as the .qmd source file.

### Testing the Extension

When modifying the extension, test it locally:

```bash
# From the repository root, create a temporary test directory
mkdir test-module && cd test-module

# Use the local extension
quarto use template ../NMU-Module-Guide

# Render the template
quarto render template.qmd
```

## Code Architecture

### Directory Structure

- **`_extensions/sjvrensburg/module-guide/`** - The Quarto template extension
  - `_extension.yml` - Extension metadata and Quarto configuration
  - `cover-page.lua` - Lua filter for professional cover page generation
  - `custom-styles.lua` - Lua filter for custom Div block style mapping
  - `reference-doc.docx` - Word reference document containing NMU custom styles
  
- **`template.qmd`** - Starter template with all 11 NMU module guide sections

- **`compiling_a_module_guide/`** - Reference materials from NMU Faculty of Science (included in .gitignore)

### Key Technical Components

#### 1. Extension Configuration (`_extension.yml`)

- Requires Quarto v1.4+
- Registers two filters: `cover-page.lua` and `custom-styles.lua` (order matters - cover page first)
- Sets reference document: `reference-doc.docx`
- Enables table of contents and section numbering for docx output

#### 2. Cover Page Filter (`cover-page.lua`)

Creates a professional cover page with NMU branding when `cover_page: true` is set in YAML metadata.

**Cover page elements:**
- NMU institution header in dark blue (#18324B)
- Decorative lines in NMU green (#006B34)
- Faculty and institution names
- Module title and code (large, bold, dark blue)
- Module coordinator and department
- Automatic page break after cover

**Usage:**
```yaml
---
title: "Module Name"
module_code: "SCI101"
author: "Dr. Name"
department: "Department Name"
faculty: "Faculty of Science"
institution: "Nelson Mandela University"
cover_page: true
---
```

The filter injects OpenXML directly for precise formatting control and uses two Pandoc functions:
- `Meta(meta)` - Creates cover elements and stores them in `meta['cover-elements']`
- `Pandoc(doc)` - Prepends cover elements to document blocks

#### 3. Custom Styles Filter (`custom-styles.lua`)

Maps Pandoc Div classes to Word custom paragraph styles defined in `reference-doc.docx`:

```lua
-- Current mappings (CustomBlock* styles in reference-doc.docx)
["learning-outcome"] = "CustomBlockLearningOutcome"
["alert"] = "CustomBlockAlert"
["note"] = "CustomBlockNote"
["tip"] = "CustomBlockTip"
["warning"] = "CustomBlockWarning"
["important"] = "CustomBlockImportant"
["key-point"] = "CustomBlockKeyPoint"
["activity"] = "CustomBlockActivity"
["assessment"] = "CustomBlockActivity"  -- Uses Activity style
["reflection"] = "CustomBlockReflection"
```

The filter also:
- Prepends bold text prefixes to blocks (e.g., "Learning Outcome:")
- Sets the `custom-style` attribute for Word style application
- Handles blockquote styling via the `blockquote` class

**Important:** Returns the modified Div (not `nil`) to allow Word to apply the custom styles from the reference doc.

#### 4. Word Reference Document (`reference-doc.docx`)

Contains custom Word style definitions that map to Pandoc's output:

**Custom Block Styles:**
- `CustomBlockLearningOutcome`, `CustomBlockAlert`, `CustomBlockNote`, `CustomBlockTip`
- `CustomBlockWarning`, `CustomBlockImportant`, `CustomBlockKeyPoint`
- `CustomBlockActivity`, `CustomBlockReflection`

**Standard Pandoc Styles (mapped to NMU styles):**
- Heading 1 → "1 Main Heading" (Arial Bold 15pt, White background)
- Heading 2 → "2 Main Heading" (Arial Bold 15pt, Dark Blue)
- Heading 3 → "1 Sub-heading" (Arial Bold 12pt, Dark Blue)
- Heading 4 → "2 Sub-heading" (Arial Bold 12pt, NMU Green)
- Heading 5 → "3 Sub-heading" (Arial 11pt, Dark Blue)
- Heading 6 → "4 Sub-heading" (Arial Bold, White background)
- Normal → "Paragraph" (Arial 11pt, Black)
- Block Quote → "Quote" (Arial Italic 11pt, NMU Green, centered)

Modify via Word's Style Pane (Ctrl+Shift+Alt+S) to change document appearance.

#### 5. Template Content (`template.qmd`)

YAML header configures metadata:
- `title`, `module_code`, `author`, `department`, `faculty`, `institution`, `date`
- `cover_page: true` - Enables professional cover page
- `format.docx` settings: TOC, numbering, filter registration
- `execute` block: default R chunk behavior

The template includes 11 sections as required by NMU:
1. Introduction (welcome, educational approach, responsibilities)
2. Administrative Information (contact details, communication)
3. Module Information (description, NQF level, learning outcomes)
4. Professional Body Requirements (if applicable)
5. Teaching & Learning Details (schedule, activities)
6. Learning Resources (prescribed and recommended)
7. Assessment Guidelines (rubrics, weightings, policies)
8. Referencing Style
9. Turnitin Information
10. Support Services (library, wellness)
11. Glossary

Sections use custom Div blocks like `::: {.learning-outcome}` and embedded R code chunks for dynamic content.

## Modification Guidelines

### Adding New Custom Block Styles

1. In `_extension.yml`: Filter registration is automatic (all Lua filters in extension folder are loaded)
2. In `custom-styles.lua`:
   - Add entry to `style_map` table (maps class name to Word style)
   - Add entry to `prefixes` table if visual prefix is needed
3. In `reference-doc.docx`: Create the custom Word style with name matching `style_map` value
4. Document in README.md

Example:
```lua
-- In Div function style_map table
["discussion"] = "CustomBlockDiscussion"

-- In prefixes table
["discussion"] = "Discussion:"
```

**Important:** Style names in `style_map` must exactly match custom style names defined in `reference-doc.docx`.

### Modifying Word Styles

1. Open `_extensions/sjvrensburg/module-guide/reference-doc.docx` in Word
2. Access Home → Styles → Styles Pane (or press Ctrl+Shift+Alt+S)
3. Modify styles (CustomBlock* styles, Heading 1-6, Quote, Normal, etc.)
4. Save the document
5. Re-render any .qmd files that use the style

**Standard Pandoc Styles:** Heading 1-6, Normal, Quote, List Paragraph, etc.
**Custom Block Styles:** CustomBlockLearningOutcome, CustomBlockAlert, etc.

### Updating the Template

- Keep `template.qmd` as a starter - users will customize it for their modules
- Use `{{placeholder}}` patterns for content that instructors must replace
- Ensure all 11 NMU sections are present
- R code chunks should demonstrate common tasks (tables, plots, stats)

## Troubleshooting

### Styles Not Applying in Word Output

- Ensure `_extensions/sjvrensburg/module-guide/` folder exists in the project
- Check that `reference-doc.docx` is present in the extension folder
- Verify YAML format is set to `nmu-module-guide` or uses correct filter path
- Try `quarto render --clean` before re-rendering
- Check that Word style names in reference-doc.docx match Pandoc defaults

### R Code Not Executing

- Verify required R packages are installed (knitr, rmarkdown)
- Check that `echo: true` and `eval: true` are set in YAML (or chunk options)
- Look for error messages in console output
- Test with simple chunks first (e.g., `print(1 + 1)`)

### Custom Blocks Not Rendering

- Verify Div syntax: three colons, class name in braces, proper closing
- Check Lua filter is present in `_extensions/sjvrensburg/module-guide/` folder
- Confirm the class name exists in `style_map` in custom-styles.lua
- Verify the corresponding CustomBlock* style exists in reference-doc.docx
- Test with simple content first before complex formatting

## Distribution and Usage

The extension is designed for distribution via GitHub:

```bash
# Users install with
quarto use template sjvrensburg/NMU-Module-Guide

# Which creates a new directory with the extension ready
```

Maintain the structure with `_extensions/` at the repository root for compatibility.

## Development Notes

- This project uses Lua 5.1 (Pandoc's embedded Lua version)
- The filters operate on Pandoc's AST (abstract syntax tree)
- Word output requires careful coordination between Pandoc styles and reference-doc.docx
- R code execution depends on having R and required packages installed
- Version constraint: Quarto >= 1.4.0

## Available Custom Block Styles

The template supports the following custom Div blocks (syntax: `::: {.class-name}`):

| Class Name | Word Style | Prefix Text |
|------------|------------|-------------|
| `learning-outcome` | CustomBlockLearningOutcome | "Learning Outcome:" |
| `alert` | CustomBlockAlert | "Alert:" |
| `note` | CustomBlockNote | "Note:" |
| `tip` | CustomBlockTip | "Tip:" |
| `warning` | CustomBlockWarning | "Warning:" |
| `important` | CustomBlockImportant | "Important:" |
| `key-point` | CustomBlockKeyPoint | "Key Point:" |
| `activity` | CustomBlockActivity | "Activity:" |
| `assessment` | CustomBlockActivity | "Assessment:" |
| `reflection` | CustomBlockReflection | "Reflection:" |

Example usage:
````markdown
::: {.learning-outcome}
After completing this module, students will be able to:
- Outcome 1
- Outcome 2
:::
````

Note: Prefixes are added automatically by the filter - do not include them manually in content.

