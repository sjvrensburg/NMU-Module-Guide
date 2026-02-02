-- Cover Page Generator for NMU Module Guides
-- Inserts a formatted title page at the beginning of the document

-- This filter adds a cover page before the main content
-- Enable/disable via YAML: cover_page: true

function Meta(meta)
  -- Check if cover page is enabled
  if not meta.cover_page or meta.cover_page == false then
    return meta
  end
  
  -- Extract metadata for cover page
  local title = pandoc.utils.stringify(meta.title or "Module Guide")
  local author = pandoc.utils.stringify(meta.author or "")
  local department = pandoc.utils.stringify(meta.department or "")
  local faculty = pandoc.utils.stringify(meta.faculty or "Faculty of Science")
  local institution = pandoc.utils.stringify(meta.institution or "Nelson Mandela University")
  local date = pandoc.utils.stringify(meta.date or "")
  
  -- Create cover page elements
  local cover_elements = {
    -- Institution name
    pandoc.Para(pandoc.Strong(pandoc.Str(institution))),
    pandoc.Para(pandoc.Str(faculty)),
    pandoc.RawBlock('openxml', '<w:p><w:pPr><w:spacing w:after="1440"/></w:pPr></w:p>'),
    
    -- Module title (large)
    pandoc.Para(pandoc.Strong(pandoc.Str(title))),
    pandoc.RawBlock('openxml', '<w:p><w:pPr><w:spacing w:after="720"/></w:pPr></w:p>'),
    
    -- Author/Coordinator
    pandoc.Para(pandoc.Str("Module Coordinator: " .. author)),
    
    -- Department
    pandoc.Para(pandoc.Str(department)),
    pandoc.RawBlock('openxml', '<w:p><w:pPr><w:spacing w:after="1440"/></w:pPr></w:p>'),
    
    -- Date
    pandoc.Para(pandoc.Str(date)),
    
    -- Page break after cover
    pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
  }
  
  -- Store cover elements in metadata for later insertion
  meta['cover-elements'] = cover_elements
  
  return meta
end

function Pandoc(doc)
  -- Check if we have cover elements to insert
  if doc.meta['cover-elements'] then
    local cover = doc.meta['cover-elements']
    
    -- Insert cover elements at the beginning
    local new_blocks = {}
    for _, elem in ipairs(cover) do
      table.insert(new_blocks, elem)
    end
    
    -- Add all existing blocks after cover
    for _, block in ipairs(doc.blocks) do
      table.insert(new_blocks, block)
    end
    
    doc.blocks = new_blocks
  end
  
  return doc
end
