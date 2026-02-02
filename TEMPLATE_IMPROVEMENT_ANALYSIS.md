# NMU Module Guide Template - Improvement Analysis

## Current Status & Issues

### 1. Color Scheme Issues
**Problem**: Template does not use correct NMU Science branding colors
- **Discovered Color**: `#00783e` / `#00773e` (NMU Science green)
- **Current Issue**: Custom blocks not rendering with proper colors in Word output
- **Location**: `_extensions/nmu/module-guide/reference-doc.docx` lacks proper color definitions

### 2. Custom Blocks Not Rendering Correctly
**Problem**: Lua filter in `custom-styles.lua` may have issues:
- Returns `nil` instead of returning the modified div
- Emoji/text prefixes may not be rendering in Word (Word doesn't support emoji in custom styles reliably)
- Block styles may not map correctly to Word's style model

**Affected Blocks**:
- Learning outcomes
- Alerts/Warnings
- Notes/Tips
- Activity boxes
- Reflection prompts

### 3. No Cover Page
**Problem**: Current template lacks professional cover page
- Word template in `compiling_a_module_guide/` has large cover images
- PPTX covers show NMU branding and design patterns
- Current template.qmd starts directly with content

## Extracted Assets

### From NMU-41-LEARNER GUIDE TEMPLATE.docx
- **image2.jpg** (2480x3508 px, 1524.7 KB): Full-page portrait cover
- **image1.jpeg** (1825x2581 px, 649.5 KB): Secondary cover/title page

These are potential cover page templates showing:
- NMU Science branding
- Professional layout
- Color scheme and styling

### From Faculty of Science guide cover.pptx (21 images)
Large design elements showing:
- NMU logo and branding
- Color scheme: Green (#00783e) as primary
- Various design templates
- Potential decorative elements

**Key images by size**:
- image2.png (2131x1378 px): Landscape design element
- image5.png (2264x1425 px): Landscape design element
- image76.png (1624x937 px): Contains NMU green color
- image77.png (1604x954 px): Black design element

### From Module guide development.pptx (107 images)
Development/instructional content showing:
- Step-by-step module guide creation
- Design principles and layouts
- Color applications
- Multiple design variations

## Improvement Plan

### Phase 1: Fix Custom Blocks (High Priority)
1. **Fix Lua Filter** (`_extensions/nmu/module-guide/custom-styles.lua`)
   - Remove emoji prefixes (unreliable in Word)
   - Use bold text prefixes instead
   - Return modified `div` object properly
   - Add CSS classes for styling instead of relying on Word custom styles
   
2. **Update Reference Document** (`_extensions/nmu/module-guide/reference-doc.docx`)
   - Create custom paragraph styles for each block type:
     - "Custom Block: Learning Outcome"
     - "Custom Block: Alert"
     - "Custom Block: Note"
     - "Custom Block: Tip"
     - "Custom Block: Warning"
     - "Custom Block: Important"
     - "Custom Block: Activity"
     - "Custom Block: Assessment"
     - "Custom Block: Reflection"
     - "Custom Block: Key Point"
   - Apply NMU Science green (#00783e) for backgrounds/borders
   - Define consistent spacing and typography

### Phase 2: Color Scheme Integration (Medium Priority)
1. **Add Theme Colors to reference-doc.docx**
   - Primary: NMU Science Green `#00783e`
   - Accent colors from branding materials
   - Update all heading and body text colors to match branding
   
2. **Create Color Variables** (in metadata or extension config)
   - Document the official color palette
   - Make colors configurable in future versions

### Phase 3: Create Professional Cover Page (High Priority)
1. **Analyze Extracted Cover Images**
   - Extract cover page design from `image2.jpg` (DOCX template)
   - Extract branding elements from PPTX cover designs
   
2. **Create Quarto-Based Cover Page**
   - Use Lua filter to insert cover page before main content
   - Include:
     - Module code and name
     - Institution name/logo
     - Faculty name (Faculty of Science)
     - NMU branding with green color scheme
     - Author/Coordinator name
     - Date
   - Span full page width
   - Professional design matching extracted templates

3. **Cover Page Options**
   - Full-page cover before TOC
   - Back matter with support services
   - Inside front/back covers with institutional info

### Phase 4: Documentation & Testing
1. Update README.md with:
   - Color palette documentation
   - Custom block rendering guidance
   - Cover page customization instructions
   
2. Test rendering:
   - All custom blocks in Word output
   - Cover page appearance
   - Color consistency across document
   - Verify "zero manual formatting" requirement still met

## Technical Decisions

### Lua Filter Approach
- Use Word's native paragraph styles (no custom-style workaround)
- Add border/shading through style definition, not via Lua
- Keep prefix text as **Bold Text:** instead of emoji
- Maintain clean HTML/Pandoc AST transformation

### Cover Page Strategy
- Create via separate Quarto shortcode or filter
- Make optional (can be disabled in YAML)
- Use landscape A4 page for cover, then portrait for content
- Include metadata in YAML for dynamic population

### Color Integration
- Store color palette in `_extension.yml` (metadata)
- Document in new `COLORS.md` file
- Reference existing Word reference-doc.docx colors
- Test Pandoc's color handling limitations

## Risks & Constraints

1. **Word Style Limitations**
   - Pandoc has limited support for custom Word styles
   - Emoji rendering unreliable in Word
   - May need to use only standard styles
   
2. **Page Layout**
   - Cover page with different orientation needs careful handling
   - Ensure section breaks work correctly
   
3. **Asset Licensing**
   - Confirm extracted logos/images can be reused
   - NMU branding likely licensed to institution only
   - May need to include license/attribution

## Files to Modify

- `_extensions/nmu/module-guide/custom-styles.lua` - Rewrite filter logic
- `_extensions/nmu/module-guide/reference-doc.docx` - Add color and styles
- `_extensions/nmu/module-guide/_extension.yml` - May add color metadata
- `template.qmd` - Add cover page (optional) and update examples
- `README.md` - Document improvements
- Create: `COLORS.md` - Color palette documentation
- Create: `COVER_PAGE.md` - Cover page customization guide

## Extracted Assets Location

All extracted images are in: `_assets_extracted/`
- `docx_template/` - Cover page images from Word template
- `pptx_cover/` - Cover design elements
- `pptx_dev/` - Development/instruction content

