-- Cover Page Generator for NMU Module Guide
-- Creates a professional cover page using metadata from the YAML header

function meta_to_string(value)
  if value == nil then
    return ""
  end
  if type(value) == "string" then
    return value
  end
  if type(value) == "table" then
    -- Handle Pandoc-style metadata (Inlines, Blocks, etc.)
    if value.content then
      return pandoc.utils.stringify(value.content)
    else
      return pandoc.utils.stringify(value)
    end
  end
  return tostring(value)
end

function Pandoc(doc)
  -- Extract metadata
  local meta = doc.meta
  local title = meta_to_string(meta.title or "")
  local module_code = meta_to_string(meta.module_code or "")
  local author = meta_to_string(meta.author or "")
  local date = meta_to_string(meta.date or "")
  local faculty = meta_to_string(meta.faculty or "Faculty of Science")
  local institution = meta_to_string(meta.institution or "Nelson Mandela University")

  -- Create cover page blocks
  local cover_blocks = {
    -- Add vertical space at top
    pandoc.Para({}),
    pandoc.Para({}),
    pandoc.Para({}),
    
    -- Logo/Institution name (centered)
    pandoc.Para({
      pandoc.Strong(pandoc.Str(institution))
    }),
    pandoc.Para({
      pandoc.Str(faculty)
    }),
    
    -- Vertical space
    pandoc.Para({}),
    pandoc.Para({}),
    pandoc.Para({}),
    pandoc.Para({}),
    
    -- Module information
    pandoc.Para({
      pandoc.Strong(pandoc.Str("Module Code: " .. module_code))
    }),
    
    -- Title
    pandoc.Heading(
      1,
      pandoc.Str(title)
    ),
    
    -- Vertical space
    pandoc.Para({}),
    pandoc.Para({}),
    
    -- Author and date
    pandoc.Para({
      pandoc.Str("By: " .. author)
    }),
    pandoc.Para({
      pandoc.Str(date)
    }),
  }

  -- Create page breaks and spacing after cover page
  -- Add multiple empty paragraphs for visual separation
  for i = 1, 5 do
    table.insert(cover_blocks, pandoc.Para({}))
  end
  table.insert(cover_blocks, pandoc.HorizontalRule())

  -- Prepend cover blocks to document content
  for i = #cover_blocks, 1, -1 do
    table.insert(doc.blocks, 1, cover_blocks[i])
  end

  return doc
end
