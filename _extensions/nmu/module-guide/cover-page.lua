-- Professional Cover Page Generator for NMU Module Guides
-- Creates a branded cover page with NMU logo and official colors

local function create_cover_page(meta)
  -- Extract metadata
  local title = pandoc.utils.stringify(meta.title or "Module Guide")
  local author = pandoc.utils.stringify(meta.author or "")
  local department = pandoc.utils.stringify(meta.department or "")
  local faculty = pandoc.utils.stringify(meta.faculty or "Faculty of Science")
  local institution = pandoc.utils.stringify(meta.institution or "Nelson Mandela University")
  local date = pandoc.utils.stringify(meta.date or "")
  local module_code = pandoc.utils.stringify(meta.module_code or "")
  
  -- Create cover page blocks
  local cover = {}
  
  -- Add some vertical space at top
  table.insert(cover, pandoc.RawBlock('openxml', 
    '<w:p><w:pPr><w:spacing w:before="1440"/></w:pPr></w:p>'))
  
  -- NMU Branding Header (text-based design using official colors)
  -- Large "NELSON MANDELA UNIVERSITY" in dark blue
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="120"/></w:pPr>' ..
    '<w:r><w:rPr><w:sz w:val="40"/><w:color w:val="18324B"/><w:b/></w:rPr>' ..
    '<w:t>NELSON MANDELA UNIVERSITY</w:t></w:r></w:p>'))
  
  -- Decorative line in NMU green
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:jc w:val="center"/><w:pBdr>' ..
    '<w:top w:val="single" w:sz="24" w:space="1" w:color="006B34"/>' ..
    '</w:pBdr><w:spacing w:after="360"/></w:pPr></w:p>'))
  
  -- Space after logo
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:spacing w:after="720"/></w:pPr></w:p>'))
  
  -- Faculty name (in NMU green)
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="240"/></w:pPr>' ..
    '<w:r><w:rPr><w:sz w:val="28"/><w:color w:val="006B34"/><w:b/></w:rPr>' ..
    '<w:t>' .. faculty .. '</w:t></w:r></w:p>'))
  
  -- Institution name
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="1440"/></w:pPr>' ..
    '<w:r><w:rPr><w:sz w:val="32"/><w:b/></w:rPr>' ..
    '<w:t>' .. institution .. '</w:t></w:r></w:p>'))
  
  -- Horizontal line
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:pBdr><w:top w:val="single" w:sz="12" w:space="1" w:color="006B34"/></w:pBdr>' ..
    '<w:spacing w:after="720"/></w:pPr></w:p>'))
  
  -- Module title (large, bold, dark blue)
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="480"/></w:pPr>' ..
    '<w:r><w:rPr><w:sz w:val="48"/><w:color w:val="18324B"/><w:b/></w:rPr>' ..
    '<w:t>' .. title .. '</w:t></w:r></w:p>'))
  
  -- Module code (if provided)
  if module_code ~= "" then
    table.insert(cover, pandoc.RawBlock('openxml',
      '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="720"/></w:pPr>' ..
      '<w:r><w:rPr><w:sz w:val="32"/><w:color w:val="006B34"/><w:b/></w:rPr>' ..
      '<w:t>' .. module_code .. '</w:t></w:r></w:p>'))
  end
  
  -- Another horizontal line
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:pBdr><w:top w:val="single" w:sz="12" w:space="1" w:color="006B34"/></w:pBdr>' ..
    '<w:spacing w:after="1440"/></w:pPr></w:p>'))
  
  -- Module Coordinator
  if author ~= "" then
    table.insert(cover, pandoc.RawBlock('openxml',
      '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="240"/></w:pPr>' ..
      '<w:r><w:rPr><w:sz w:val="24"/></w:rPr>' ..
      '<w:t>Module Coordinator:</w:t></w:r></w:p>'))
    
    table.insert(cover, pandoc.RawBlock('openxml',
      '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="480"/></w:pPr>' ..
      '<w:r><w:rPr><w:sz w:val="28"/><w:b/></w:rPr>' ..
      '<w:t>' .. author .. '</w:t></w:r></w:p>'))
  end
  
  -- Department
  if department ~= "" then
    table.insert(cover, pandoc.RawBlock('openxml',
      '<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="720"/></w:pPr>' ..
      '<w:r><w:rPr><w:sz w:val="24"/><w:i/></w:rPr>' ..
      '<w:t>' .. department .. '</w:t></w:r></w:p>'))
  end
  
  -- Date (at bottom)
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:pPr><w:spacing w:before="2880"/></w:pPr></w:p>'))
  
  if date ~= "" then
    table.insert(cover, pandoc.RawBlock('openxml',
      '<w:p><w:pPr><w:jc w:val="center"/></w:pPr>' ..
      '<w:r><w:rPr><w:sz w:val="24"/></w:rPr>' ..
      '<w:t>' .. date .. '</w:t></w:r></w:p>'))
  end
  
  -- Page break after cover
  table.insert(cover, pandoc.RawBlock('openxml',
    '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'))
  
  return cover
end

function Meta(meta)
  -- Check if cover page is enabled (default: false)
  if meta.cover_page and meta.cover_page ~= false then
    meta['cover-elements'] = create_cover_page(meta)
  end
  return meta
end

function Pandoc(doc)
  -- Insert cover elements at the beginning if they exist
  if doc.meta['cover-elements'] then
    local cover = doc.meta['cover-elements']
    local new_blocks = {}
    
    -- Add cover elements first
    for _, elem in ipairs(cover) do
      table.insert(new_blocks, elem)
    end
    
    -- Then add all existing document blocks
    for _, block in ipairs(doc.blocks) do
      table.insert(new_blocks, block)
    end
    
    doc.blocks = new_blocks
  end
  
  return doc
end
