# NMU Module Guide Template - Official Specifications

**Source**: `1. Module Guide Template - Science.dotx`  
**Analysis Date**: 2026-02-02

## Color Palette

### Primary Colors
- **NMU Science Green**: `#006B34` (RGB 0, 107, 52)
  - Used in: Quote style, 2 Sub-heading style
- **Dark Blue**: `#18324B` (RGB 24, 50, 75)
  - Used in: Heading 2, Heading 3
- **Purple**: `#6C284F` (RGB 108, 40, 79)
  - Used in: Heading 4

### Theme Colors (Office Theme)
- **dk1 (Dark 1)**: `#000000` - Black
- **lt1 (Light 1)**: `#FFFFFF` - White
- **dk2 (Dark 2)**: `#0E2841` - Dark Blue (RGB 14, 40, 65)
- **lt2 (Light 2)**: `#E8E8E8` - Light Gray
- **accent1**: `#156082` - Blue (RGB 21, 96, 130)
- **accent2**: `#E97132` - Orange (RGB 233, 113, 50)
- **accent3**: `#196B24` - Green (RGB 25, 107, 36) *(Alternative green)*
- **accent4**: `#0F9ED5` - Cyan (RGB 15, 158, 213)
- **accent5**: `#A02B93` - Purple (RGB 160, 43, 147)
- **accent6**: `#4EA72E` - Light Green (RGB 78, 167, 46)
- **hlink**: `#467886` - Hyperlink Blue
- **folHlink**: `#96607D` - Followed Hyperlink Purple

## Typography

### Font Scheme (Office Theme)
- **Major Font (Headings)**: Aptos Display
- **Minor Font (Body)**: Aptos

### Document Defaults
- **Default Font**: Avenir Book, 11pt
- **Default Spacing After**: 160 twips (8pt)
- **Default Line Spacing**: 259 twips

### Actual Style Fonts
**NOTE**: The template overrides theme fonts with specific fonts in styles:

#### Body Text
- **Normal**: Arial, 11pt

#### Standard Heading Styles (for internal use)
- **Heading 1**: Avenir Black, 15pt, White (#FFFFFF)
- **Heading 2**: Avenir Black, 15pt, Dark Blue (#18324B)
- **Heading 3**: Avenir Black, 12pt, Dark Blue (#18324B)
- **Heading 4**: Avenir Black, 12pt, Purple (#6C284F)
- **Heading 5**: Avenir Heavy Bold, 11pt, Dark Blue (#18324B)
- **Heading 6-9**: Arial, various sizes, gray tones

#### NMU Custom Heading Styles (recommended for module guides)
- **1 Main Heading**: Arial Bold, 15pt, White on background (based on H1)
- **2 Main Heading**: Arial Bold, 15pt, Dark Blue (based on H2)
- **1 Sub-heading**: Arial Bold, 12pt, Dark Blue (based on H3)
- **2 Sub-heading**: Arial Bold, 12pt, **Green #006B34** (based on H4)
- **3 Sub-heading**: Arial, 11pt Bold, Dark Blue (based on H5)
- **4 Sub-heading**: Arial Bold, White text (based on 2 Sub-heading)

## Paragraph Styles - Complete Specifications

### Normal
- Font: Arial, 11pt
- Based on: Document defaults
- Usage: Body text paragraphs

### Quote
- Based on: Normal
- Font: Arial Italic
- Color: **#006B34** (NMU Green)
- Alignment: **Center**
- Space Before: 160 twips (8pt)
- Usage: Quotations, emphasis blocks

### Paragraph
- Based on: Normal
- Font: Arial, 11pt
- Usage: Standard body paragraphs (same as Normal)

### Bullet-point List
- Based on: Normal
- Indent Left: 680 twips (34pt)
- Hanging Indent: 340 twips (17pt)
- Usage: Bulleted lists

### Numbered List
- Based on: Paragraph
- Indent Left: 680 twips (34pt)
- Hanging Indent: 340 twips (17pt)
- Usage: Numbered lists

## Heading Hierarchy and Spacing

### 1 Main Heading (H1 equivalent)
- Font: Arial Bold, 15pt
- Color: White (#FFFFFF) on background
- Space Before: 360 twips (18pt)
- Space After: 80 twips (4pt)
- First Line Indent: 113 twips (5.65pt)
- Properties: Keep with next, Keep lines together
- Outline Level: 0

### 2 Main Heading (H2 equivalent)
- Font: Arial Bold, 15pt
- Color: Dark Blue (#18324B)
- Space Before: 160 twips (8pt)
- Space After: 80 twips (4pt)
- Properties: Keep with next, Keep lines together
- Outline Level: 1

### 1 Sub-heading (H3 equivalent)
- Font: Arial Bold, 12pt
- Color: Dark Blue (#18324B)
- Space Before: 160 twips (8pt)
- Space After: 80 twips (4pt)
- Properties: Keep with next, Keep lines together
- Outline Level: 2

### 2 Sub-heading (H4 equivalent)
- Font: Arial Bold, 12pt
- Color: **Green #006B34**
- Space Before: 80 twips (4pt)
- Space After: 40 twips (2pt)
- Properties: Keep with next, Keep lines together
- Outline Level: 3

### 3 Sub-heading (H5 equivalent)
- Font: Arial, 11pt (no bold by default, based on Heading 5 which uses Avenir Heavy)
- Color: Dark Blue (#18324B)
- Space Before: 80 twips (4pt)
- Space After: 40 twips (2pt)
- Indent Left: 170 twips (8.5pt)
- Properties: Keep with next, Keep lines together
- Outline Level: 4

### 4 Sub-heading (H6 equivalent)
- Based on: 2 Sub-heading
- Font: Arial Bold
- Color: White (#FFFFFF) on background
- First Line Indent: 113 twips (5.65pt)
- Properties: Keep with next, Keep lines together

## Implementation Notes

### Pandoc Style Mapping
Quarto/Pandoc uses standard heading levels (H1-H6) which map to Word's built-in heading styles. 
To use NMU's custom heading styles, we need to:

1. **Option A**: Override Heading 1-6 styles in reference-doc.docx to match NMU specs
2. **Option B**: Use Lua filter to remap to custom style names
3. **Option C**: Document both approaches in README

### Recommended Mapping for Quarto Template
```
Quarto Markdown → Pandoc Style → Word Style (reference-doc.docx)
===============================================================
# Heading        → Heading 1     → "1 Main Heading" (Arial Bold 15pt, White)
## Heading       → Heading 2     → "2 Main Heading" (Arial Bold 15pt, Blue)
### Heading      → Heading 3     → "1 Sub-heading" (Arial Bold 12pt, Blue)
#### Heading     → Heading 4     → "2 Sub-heading" (Arial Bold 12pt, Green)
##### Heading    → Heading 5     → "3 Sub-heading" (Arial 11pt, Blue)
###### Heading   → Heading 6     → "4 Sub-heading" (Arial Bold, White)
Normal text      → Normal        → "Paragraph" or "Normal" (Arial 11pt)
> Blockquote     → Quote         → "Quote" (Arial Italic, Green, Centered)
- List           → List Para.    → "Bullet-point List"
1. List          → List Para.    → "Numbered List"
```

### Custom Block Styles (To Be Created)
For custom blocks like `::: {.learning-outcome}`, we need to create new styles:

- **Custom Block - Learning Outcome**: Light green background, bold prefix
- **Custom Block - Alert**: Orange/yellow background, bold prefix
- **Custom Block - Note**: Light blue background
- **Custom Block - Tip**: Light green background
- **Custom Block - Warning**: Red/orange background
- **Custom Block - Important**: Purple/pink background  
- **Custom Block - Activity**: Cyan background
- **Custom Block - Reflection**: Light purple background
- **Custom Block - Key Point**: Gold/yellow background

All should use:
- Arial font
- Appropriate spacing (8pt before, 4pt after)
- Light color backgrounds (not text color)
- Bold prefixes in block color (not emoji)

## Extracted Assets

### Embedded Fonts
The template includes embedded fonts:
- `word/fonts/font1.odttf` - Likely Avenir variant
- `word/fonts/font2.odttf` - Likely Avenir variant  
- `word/fonts/font3.odttf` - Likely Avenir variant
- `word/fonts/font4.odttf` - Likely Avenir variant

### Images in Template
- `word/media/image1.png`
- `word/media/image2.png`

These are likely logos or cover page elements.

## References
- Office Open XML standard for color specifications
- 1 twip = 1/20 point = 1/1440 inch
- Theme colors allow for document-wide color scheme changes
- sRGB color space is used for all color definitions

