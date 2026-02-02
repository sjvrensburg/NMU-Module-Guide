# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**NMU Module Guide Template** is a Quarto template extension for creating module guides for Nelson Mandela University's Faculty of Science. The template compiles to **LibreOffice ODT** documents with university branding and zero manual formatting required.

Key characteristics:
- Distributed via `quarto use template sjvrensburg/NMU-Module-Guide`
- **LibreOffice ODT format** with NMU custom styles
- R code integration for dynamic content (tables, plots, statistical analysis)
- ODT reference document with NMU color styling
- Licensed under GNU GPL v3

## Official NMU Color Palette

- **Primary Green**: `#006B34` (RGB 0, 107, 52)
- **Dark Blue**: `#18324B` (RGB 24, 50, 75)
- **Purple**: `#6C284F` (RGB 108, 40, 79)

## Essential Commands

### Rendering a Module Guide

```bash
# Render the template to ODT document
quarto render template.qmd

# Or render a specific custom .qmd file
quarto render [module-name].qmd
```

Output ODT documents are saved to the same directory as the .qmd source file.

### Testing the Extension

When modifying the extension, test locally:

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

```
NMU-Module-Guide/
├── _extensions/sjvrensburg/module-guide/
│   ├── _extension.yml       # Extension metadata and Quarto configuration
│   ├── reference-doc.odt    # ODT reference document with NMU styles
│   └── brand/               # Brand configuration directory
│       ├── _metadata.yml    # Brand metadata (colors, fonts)
│       └── logo.png         # NMU logo placeholder
├── template.qmd             # Starter template with 11 NMU sections
└── compiling_a_module_guide/ # Reference materials (gitignored)
```

### Key Technical Components

#### Extension Configuration (`_extension.yml`)

- Requires Quarto v1.4+
- Configures ODT output with TOC, section numbering
- Brand footer configuration for page footers
- **IMPORTANT**: `reference-doc` in `_extension.yml` does NOT work for ODT (Quarto limitation)

#### Critical: reference-doc Path for ODT

**Quarto does NOT support `reference-doc` in `_extension.yml` for ODT format.** This is a Quarto limitation - the setting works for DOCX but is ignored for ODT.

To use the NMU-styled reference document, the path MUST be specified in each `.qmd` file:

```yaml
format:
  odt:
    reference-doc: _extensions/sjvrensburg/module-guide/reference-doc.odt
```

The `template.qmd` in this repository already includes this configuration. Users creating new `.qmd` files must include this path to get NMU styling.

#### ODT Reference Document (`reference-doc.odt`)

Contains LibreOffice styles with NMU branding:
- **Heading 1**: White text on green (#006B34) background, 15pt bold
- **Heading 2**: Dark blue (#18324B) text, 15pt bold
- **Heading 3**: Dark blue (#18324B) text, 12pt bold
- **Heading 4**: Purple (#6C284F) text, 12pt bold
- **Heading 5**: Dark blue (#18324B) text, 11pt bold
- **Heading 6**: Gray (#595959) text, 11pt italic
- **Quote**: Green (#006B34) italic, centered
- **CustomBlock styles**: Colored bold text on light gray (#F5F5F5) backgrounds
  - LearningOutcome: Blue (#4A90E2)
  - Alert: Red (#D32F2F)
  - Note: Blue (#1976D2)
  - Tip: Green (#388E3C)
  - Warning: Orange (#F57C00)
  - Important: Purple (#7B1FA2)
  - KeyPoint: Teal (#0097A7)
  - Activity: Yellow (#F9A825)
  - Reflection: Purple (#5E35B1)

#### Brand Configuration (`brand/_metadata.yml`)

Defines NMU branding elements for Quarto's brand system:
- Logo file specification
- Official NMU color palette
- Typography settings (Liberation Sans fonts)

#### Brand Footer

Configured in `_extension.yml`:
```yaml
brand:
  left: "**{module_code}**"
  center: "**{date}**"
  right: "**Nelson Mandela University** - Faculty of Science"
```

#### Template Content (`template.qmd`)

YAML header includes:
- Metadata: `title`, `module_code`, `author`, `department`, `faculty`, `institution`, `date`
- **Required**: `reference-doc: _extensions/sjvrensburg/module-guide/reference-doc.odt` for NMU styling
- Format settings: TOC, numbering
- Execute block: default R chunk behavior

Includes all 11 NMU module guide sections with `{{placeholder}}` patterns for customization.

## Modification Guidelines

### Modifying ODT Styles

1. Open `_extensions/sjvrensburg/module-guide/reference-doc.odt` in LibreOffice
2. Press F11 for Styles panel
3. Modify the desired styles
4. Save
5. Re-render `.qmd` files

### Adding Custom Block Styles

1. Add style definition to `reference-doc.odt` via LibreOffice
2. Style name must match the class name used in `.qmd` (e.g., `CustomBlockMyStyle`)
3. Re-render documents

## Troubleshooting

### Styles Not Applied (Using Default LibreOffice Styles Instead)

- **Most common cause**: Missing `reference-doc` path in the `.qmd` file
- Solution: Ensure your `.qmd` includes:
  ```yaml
  format:
    odt:
      reference-doc: _extensions/sjvrensburg/module-guide/reference-doc.odt
  ```
- The `_extension.yml` `reference-doc` setting does NOT work for ODT (Quarto limitation)

### R Code Not Executing

- Verify R packages installed: `knitr`, `rmarkdown`, `quarto`
- Check `eval: true` in chunk options
- Look for error messages in console

## ODT vs DOCX

| Aspect | DOCX | ODT |
|--------|------|-----|
| Format | Proprietary | Open standard (ISO/IEC 26300) |
| Viewer | Microsoft Word | LibreOffice Writer (free) |
| reference-doc in extension | Works | **Does NOT work** |
| reference-doc in .qmd | Works | Works |
| Style mechanism | Custom XML namespace | Standard ODF styles |
