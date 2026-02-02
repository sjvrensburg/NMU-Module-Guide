-- Custom Styles Filter for NMU Module Guide
-- Maps Div classes to Word custom paragraph styles
-- Updated to use official NMU template styles

function Div(div)
  -- Map custom block classes to Word custom paragraph styles
  -- These styles are defined in reference-doc.docx
  local style_map = {
    ["learning-outcome"] = "CustomBlockLearningOutcome",
    ["alert"] = "CustomBlockAlert",
    ["note"] = "CustomBlockNote",
    ["tip"] = "CustomBlockTip",
    ["warning"] = "CustomBlockWarning",
    ["important"] = "CustomBlockImportant",
    ["key-point"] = "CustomBlockKeyPoint",
    ["activity"] = "CustomBlockActivity",
    ["assessment"] = "CustomBlockActivity",  -- Use Activity style
    ["reflection"] = "CustomBlockReflection"
  }

  -- Text prefixes (bold, no emoji for Word compatibility)
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

  -- If we have a mapping for this class
  if class and style_map[class] then
    -- Set the custom style attribute for Word output
    div.attr.attributes["custom-style"] = style_map[class]

    -- Add bold text prefix if defined
    if prefixes[class] then
      -- Insert bold prefix at the beginning of content
      table.insert(div.content, 1, pandoc.Space())
      table.insert(div.content, 1, pandoc.Strong(pandoc.Str(prefixes[class])))
    end

    -- IMPORTANT: Return the modified div
    return div
  end

  -- Handle standard blockquote
  if div.classes:includes("blockquote") then
    div.attr.attributes["custom-style"] = "Quote"
    return div
  end

  -- Return unchanged if no match
  return div
end

-- Handle code blocks (kept for future use)
function CodeBlock(block)
  -- Reserved for future code styling
  return block
end
