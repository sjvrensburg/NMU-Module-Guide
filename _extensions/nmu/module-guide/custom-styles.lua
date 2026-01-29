-- Custom Styles Filter for NMU Module Guide
-- Maps Div classes to Word custom styles

function Div(div)
  -- Map custom classes to Word styles
  local style_map = {
    ["learning-outcome"] = "Quote",
    ["alert"] = "Quote",
    ["note"] = "Paragraph",
    ["tip"] = "Paragraph",
    ["warning"] = "Quote",
    ["important"] = "Quote",
    ["key-point"] = "Quote",
    ["example-box"] = "Paragraph",
    ["activity"] = "Quote",
    ["assessment"] = "Quote",
    ["reflection"] = "Quote"
  }

  -- Get the first class if exists
  local class = div.classes[1]

  -- If we have a mapping for this class
  if class and style_map[class] then
    -- Set the custom style attribute
    div.attr.attributes["custom-style"] = style_map[class]

    -- Add a visual prefix for certain styles
    local prefixes = {
      ["learning-outcome"] = "Learning Outcome: ",
      ["alert"] = "⚠️ Alert: ",
      ["note"] = "📝 Note: ",
      ["tip"] = "💡 Tip: ",
      ["warning"] = "⚠️ Warning: ",
      ["important"] = "❗ Important: ",
      ["key-point"] = "🔑 Key Point: ",
      ["activity"] = "📋 Activity: ",
      ["assessment"] = "📊 Assessment: ",
      ["reflection"] = "🤔 Reflection: "
    }

    if prefixes[class] then
      -- Insert the prefix as the first element
      table.insert(div.content, 1, pandoc.Strong(pandoc.Str(prefixes[class])))
      table.insert(div.content, 2, pandoc.Space())
    end

    return div
  end

  -- Handle blockquote with specific attributes
  if div.classes:includes("blockquote") then
    div.attr.attributes["custom-style"] = "Quote"
    return div
  end

  return nil
end

-- Handle code blocks with special styling
function CodeBlock(block)
  if block.classes:includes("r-code") then
    block.attr = block.attr or {}
    block.attr.attributes = block.attr.attributes or {}
    block.attr.attributes["custom-style"] = "Source Code"
  end
  return nil
end
