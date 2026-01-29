# NMU Module Guide Template

A Quarto template extension for creating Nelson Mandela University (Faculty of Science) module guides that compile to properly formatted Microsoft Word documents with zero manual formatting required.

## Features

- **University Branding**: Pre-configured with NMU Science styles (Avenir headings, Arial body text)
- **Zero Manual Formatting**: Output requires no post-processing in Word
- **R Code Integration**: Execute and display R code chunks with formatted output
- **Custom Block Styles**: Pre-defined styles for alerts, notes, tips, and learning outcomes
- **Complete Module Structure**: All 11 standard university sections included
- **Template Extension**: Installable via `quarto use template` for easy reuse

## Quick Start

### Installation

#### Option 1: Using Quarto CLI (Recommended)

```bash
# Create a new module guide from this template
quarto use template sjvrensburg/NMU-Module-Guide
```

This will create a new directory with the template and all necessary files.

#### Option 2: Using R Console

```r
# From the R console or RStudio
system("quarto use template sjvrensburg/NMU-Module-Guide")
```

#### Option 3: Manual Installation

1. Clone or download this repository:
   ```bash
   git clone https://github.com/sjvrensburg/NMU-Module-Guide.git
   cd NMU-Module-Guide
   ```

2. The `_extensions` folder is already in place
3. Use `template.qmd` as your starting point
4. Rename and customize as needed

### Creating a Module Guide

After installation:

1. **Edit the YAML header** in `template.qmd`:
   ```yaml
   ---
   title: "MODULE CODE: Module Name"
   author: "Your Name"
   department: "Your Department"
   ---
   ```

2. **Replace placeholder text**:
   - Search for `{{placeholder}}` patterns
   - Replace with your module-specific content

3. **Render to Word**:
   ```bash
   quarto render template.qmd
   ```

   Or in R:
   ```r
   quarto::quarto_render("template.qmd")
   ```

4. **Open in Word**:
   - The output will be in `_output/template.docx`
   - All styles are correctly applied
   - No manual formatting required!

## Custom Block Styles

The template includes custom Div blocks for special content:

### Learning Outcomes

````markdown
::: {.learning-outcome}
After reading this section, you will be able to:
- Outcome 1
- Outcome 2
:::
````

Renders as a highlighted quote-style block with "Learning Outcome:" prefix.

### Alerts and Warnings

````markdown
::: {.alert}
**Important:** This is an alert box for critical information.
:::

::: {.warning}
**Warning:** This is a warning box.
:::
````

### Notes and Tips

````markdown
::: {.note}
**Note:** This is a note box for additional information.
:::

::: {.tip}
**Tip:** This is a tip box for helpful suggestions.
:::
````

### Important Information

````markdown
::: {.important}
**Important:** Key information that students should pay attention to.
:::
````

### Activity Boxes

````markdown
::: {.activity}
**Activity:** Complete this task by the next class.
:::
````

### Reflection Prompts

````markdown
::: {.reflection}
**Reflection:** Consider the following questions...
:::
````

### Key Points

````markdown
::: {.key-point}
**Key Point:** This is the main takeaway.
:::
````

## R Code Examples

### Basic Tables (knitr::kable)

````markdown
```{r}
module_info <- data.frame(
  Attribute = c("Module Code", "Credits", "NQF Level"),
  Value = c("SCI101", "12", "5")
)

knitr::kable(module_info, caption = "Module Information")
```
````

### Advanced Tables (flextable)

````markdown
```{r}
library(flextable)
flextable(head(mtcars)) %>%
  theme_booktabs() %>%
  autofit()
```
````

### Plots

````markdown
```{r}
library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Weight vs MPG")
```
````

### Statistical Tests

````markdown
```{r}
t.test(mpg ~ am, data = mtcars)
```
````

## Style Mapping

The template maps Pandoc's standard styles to NMU's custom styles:

| Pandoc Style | NMU Style | Font |
|--------------|-----------|------|
| Heading 1 | 1 Main Heading | Avenir Black |
| Heading 2 | 2 Main Heading | Avenir Black |
| Heading 3 | 1 Sub-heading | Avenir Black |
| Heading 4 | 2 Sub-heading | Avenir Black |
| Heading 5 | 3 Sub-heading | Avenir Black |
| Heading 6 | 4 Sub-heading | Avenir Black |
| Normal | Paragraph | Arial |
| List Paragraph | Bullet-point List | Arial |
| Block Quote | Quote | Arial |

## Template Structure

The template includes all required NMU module guide sections:

1. **Introduction** - Welcome, educational approach, student responsibilities
2. **Administrative Information** - Communication channels, contact details
3. **Module Information** - Description, NQF level, credits, learning outcomes
4. **Professional Body Requirements** (if applicable)
5. **Teaching & Learning Details** - Learning activities, weekly schedule
6. **Learning Resources** - Prescribed and recommended materials
7. **Assessment Guidelines** - Assessment plan, policies, rubrics
8. **Referencing Style** - Citation requirements
9. **Turnitin Information** - Plagiarism checking
10. **Support Services** - Library, Emthonjeni Wellness
11. **Glossary** - Instruction words explanation

## Project Structure

```
NMU-Module-Guide/
├── _extensions/
│   └── nmu/
│       └── module-guide/
│           ├── _extension.yml    # Extension configuration
│           ├── reference-doc.docx # Style mapping document
│           └── custom-styles.lua  # Lua filter for custom blocks
├── template.qmd                  # Starter template
├── README.md                     # This file
└── references.bib                # Sample bibliography
```

## Customization

### Modifying Styles

To change the document styling:

1. Open `_extensions/nmu/module-guide/reference-doc.docx` in Word
2. Modify paragraph styles as needed
3. Save changes
4. Re-render your Quarto document

**Caution:** The reference document contains style mappings. If you modify it, ensure Pandoc styles match your desired output.

### Creating Module-Specific Templates

For different module types, create new `.qmd` files based on `template.qmd`:

- `practical-module.qmd` - Lab/practical focus
- `theory-module.qmd` - Theory-heavy content
- `project-module.qmd` - Project-based learning

### Adding Custom Shortcodes

Edit `_extensions/nmu/module-guide/_extension.yml` to add new shortcodes:

```yaml
shortcodes:
  my-custom-style:
    class: my-custom-style
```

Then update `custom-styles.lua` to handle the new class.

## Troubleshooting

### Styles Not Applying

1. Ensure `_extensions/nmu/module-guide/` exists in your project
2. Check that `reference-doc.docx` is present
3. Verify the format in YAML is `nmu-module-guide`
4. Try: `quarto render --clean` then render again

### R Code Not Executing

1. Verify R packages are installed
2. Check chunk options: `echo: true`, `eval: true`
3. Look for error messages in the console

### Custom Blocks Not Working

1. Ensure `custom-styles.lua` is in the extension folder
2. Check the filter is listed in `_extension.yml`
3. Verify Div syntax is correct (three colons, proper class)

## Requirements

- **Quarto** (1.4+)
- **R** (4.0+) with the following packages:
  - quarto
  - knitr
  - rmarkdown
  - flextable (optional, for advanced tables)
  - kableExtra (optional, for table styling)
  - ggplot2 (optional, for plots)
  - dplyr (optional, for data manipulation)

### Installing R Packages

```r
install.packages(c(
  "quarto", "knitr", "rmarkdown", "flextable",
  "kableExtra", "ggplot2", "dplyr", "tidyr"
))
```

## Support

For issues or questions:

1. Check Quarto documentation: https://quarto.org
2. Check this repository's Issues: https://github.com/sjvrensburg/NMU-Module-Guide/issues
3. Contact: [Your Department's IT Support]

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This template is based on the Nelson Mandela University Faculty of Science module guide template. Use and modify as needed for university purposes.

## Credits

- **Author:** Stefan J. van Rensburg <stefan.vanrensburg@mandela.ac.za>
- **Institution:** Nelson Mandela University
- **Faculty:** Faculty of Science

## Version History

- **v1.0.0** (2025-01) - Initial release
  - Quarto extension structure
  - Complete template with all university sections
  - Custom block styles via Lua filter
  - R integration examples
  - Style mapping from NMU template

---

**Nelson Mandela University**

Faculty of Science

www.mandela.ac.za
