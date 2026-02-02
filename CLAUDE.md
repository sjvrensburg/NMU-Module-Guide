# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**NMU Module Guide Template** is a Quarto template extension for creating module guides for Nelson Mandela University's Faculty of Science. The template compiles to Microsoft Word documents with university branding and zero manual formatting required.

Key characteristics:
- Designed for distribution via `quarto use template` command
- Lua-based filter system for custom block styles
- R code integration for dynamic content (tables, plots, statistical analysis)
- Pre-configured Word reference document with NMU styles (Avenir headings, Arial body)
- Licensed under GNU GPL v3

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

- **`_extensions/nmu/module-guide/`** - The Quarto template extension
  - `_extension.yml` - Extension metadata and Quarto configuration
  - `custom-styles.lua` - Lua filter for custom Div block rendering
  - `reference-doc.docx` - Word reference document containing style mappings
  
- **`template.qmd`** - Starter template with all 11 NMU module guide sections

- **`compiling_a_module_guide/`** - Reference materials from NMU Faculty of Science (included in .gitignore)

### Key Technical Components

#### 1. Extension Configuration (`_extension.yml`)

- Requires Quarto v1.4+
- Registers the filter: `custom-styles.lua`
- Sets reference document: `reference-doc.docx`
- Enables table of contents and section numbering for docx output

#### 2. Lua Filter (`custom-styles.lua`)

Maps Pandoc Div classes to Word custom styles:

```lua
-- Example mappings
learning-outcome → "Quote"
alert → "Quote"
note → "Paragraph"
warning → "Quote"
important → "Quote"
```

The filter also:
- Prepends emoji/text prefixes to blocks (e.g., "Learning Outcome: ")
- Sets the `custom-style` attribute for Word style application
- Handles blockquote styling

**Important:** Returns `nil` at the end of Div() to prevent Pandoc from generating default output. This allows Word to apply the reference-doc styles.

#### 3. Word Reference Document (`reference-doc.docx`)

- Contains style definitions that Pandoc uses to format output
- Style names must match Pandoc's standard styles (Heading 1-6, Normal, Quote, etc.)
- Modify via Word's Style Pane to change document appearance
- Changes persist when re-rendering existing .qmd files

#### 4. Template Content (`template.qmd`)

YAML header configures metadata:
- `title`, `author`, `department`, `faculty`, `institution`, `date`
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

1. In `_extension.yml`: Add style to filter registration (already done)
2. In `custom-styles.lua`:
   - Add entry to `style_map` table (maps class name to Word style)
   - Add entry to `prefixes` table if visual prefix is needed
3. In `reference-doc.docx`: Ensure the Word style exists
4. Document in README.md

Example:
```lua
-- In Div function style_map table
["discussion"] = "Quote"

-- In prefixes table
["discussion"] = "💬 Discussion: "
```

### Modifying Word Styles

1. Open `_extensions/nmu/module-guide/reference-doc.docx` in Word
2. Access Home → Styles → Styles Pane (or press Ctrl+Shift+Alt+P)
3. Modify styles (Heading 1, Heading 2, Quote, Normal, etc.)
4. Save the document
5. Re-render any .qmd files that use the style

The style names in the docx must match what Pandoc outputs (Heading 1, Normal, Quote, etc.).

### Updating the Template

- Keep `template.qmd` as a starter - users will customize it for their modules
- Use `{{placeholder}}` patterns for content that instructors must replace
- Ensure all 11 NMU sections are present
- R code chunks should demonstrate common tasks (tables, plots, stats)

## Troubleshooting

### Styles Not Applying in Word Output

- Ensure `_extensions/nmu/module-guide/` folder exists in the project
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
- Check Lua filter is listed in `_extension.yml`
- Confirm the class name exists in `style_map` in custom-styles.lua
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
- The filter operates on Pandoc's AST (abstract syntax tree)
- Word output requires careful coordination between Pandoc styles and reference-doc.docx
- R code execution depends on having R and required packages installed
- Version constraint: Quarto >= 1.4.0

