-- TOC Generator for NMU Module Guide (ODT)
-- Manually creates a Table of Contents for ODT format since Pandoc doesn't auto-generate it

function Pandoc(doc)
  -- Collect all headings from the document
  local headings = {}
  
  function collect_headings(blocks)
    for _, block in ipairs(blocks) do
      if block.t == "Header" then
        table.insert(headings, {
          level = block.level,
          text = pandoc.utils.stringify(block.content),
          id = block.identifier or ""
        })
      elseif block.t == "Div" then
        collect_headings(block.content)
      elseif block.t == "BlockQuote" then
        collect_headings(block.content)
      end
    end
  end
  
  collect_headings(doc.blocks)
  
  -- Create TOC entries with a heading
  local toc_blocks = {}
  
  -- Add TOC title as a paragraph (Header might not render properly in ODT)
  table.insert(toc_blocks, pandoc.Para({
    pandoc.Strong(pandoc.Str("Table of Contents"))
  }))
  table.insert(toc_blocks, pandoc.Para({}))
  
  -- Add TOC entries for each heading
  for _, heading in ipairs(headings) do
    if heading.level <= 2 then  -- Only include H1 and H2 in TOC
      local indent = ""
      if heading.level == 2 then
        indent = "   "
      end
      
      local toc_line = pandoc.Para({
        pandoc.Str(indent .. heading.text)
      })
      table.insert(toc_blocks, toc_line)
    end
  end
  
  -- Add a page break after TOC
  table.insert(toc_blocks, pandoc.Para({}))
  table.insert(toc_blocks, pandoc.HorizontalRule())
  table.insert(toc_blocks, pandoc.Para({}))
  
  -- Prepend TOC to document blocks
  for i = #toc_blocks, 1, -1 do
    table.insert(doc.blocks, 1, toc_blocks[i])
  end
  
  return doc
end
