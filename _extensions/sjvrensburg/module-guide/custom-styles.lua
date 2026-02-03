-- Custom Styles Filter for NMU Module Guide
-- Maps Div classes to ODT paragraph styles
-- Designed to work with the NMU reference-doc.odt which defines CustomBlock styles

function Div(div)
  -- Map custom block classes to ODT style names
  -- These styles are defined in the reference-doc.odt file
  local style_map = {
    ["learning-outcome"] = "CustomBlockLearningOutcome",
    ["alert"] = "CustomBlockAlert",
    ["note"] = "CustomBlockNote",
    ["tip"] = "CustomBlockTip",
    ["warning"] = "CustomBlockWarning",
    ["important"] = "CustomBlockImportant",
    ["key-point"] = "CustomBlockKeyPoint",
    ["activity"] = "CustomBlockActivity",
    ["assessment"] = "CustomBlockActivity",
    ["reflection"] = "CustomBlockReflection"
  }

  -- Text prefixes for visual clarity
  local prefixes = {
    ["learning-outcome"] = "Learning Outcome:",
    ["alert"] = "Alert:",
    ["note"] = "Note:",
    ["tip"] = "Tip:",
    ["warning"] = "Warning:",
    ["important"] = "Important:",
    ["key-point"] = "Key Point:",
    ["activity"] = "Activity:",
    ["assessment"] = "Assessment:",
    ["reflection"] = "Reflection:"
  }

  -- Get the first class if it exists
  local class = div.classes[1]

  -- Only process if we have a mapping for this class
  if class and style_map[class] then
    -- For ODT output: Use the style attribute
    -- For DOCX output: Use custom-style attribute
    -- The reference document must define these styles
    
    -- Try to set ODT style (works with reference-doc.odt)
    if div.attr.attributes == nil then
      div.attr.attributes = {}
    end
    
    -- Set ODT style via the style attribute
    div.attr.attributes["style"] = style_map[class]
    
    -- Also set custom-style for DOCX compatibility
    div.attr.attributes["custom-style"] = style_map[class]

    -- Add bold text prefix at the beginning if defined
    if prefixes[class] then
      -- Create prefix as bold strong text
      local prefix_para = pandoc.Para({
        pandoc.Strong(pandoc.Str(prefixes[class]))
      })
      
      -- Insert prefix before the content
      table.insert(div.content, 1, prefix_para)
    end

    return div
  end

  -- Handle blockquote styling
  if div.classes:includes("blockquote") then
    if div.attr.attributes == nil then
      div.attr.attributes = {}
    end
    div.attr.attributes["style"] = "Quote"
    div.attr.attributes["custom-style"] = "Quote"
    return div
  end

  -- Return unchanged if no match
  return div
end

-- Preserve code blocks as-is
function CodeBlock(block)
  return block
end

-- Ensure we don't break table structure
function Table(t)
  -- Tables are left completely untouched
  return t
end
