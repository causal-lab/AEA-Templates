-- AEA-style section numbering: Roman numerals (I, II, III) for sections,
-- uppercase letters (A, B, C) for subsections.
-- Prepends labels directly into header content so TOC also reflects them.

local section_count = 0
local subsection_count = 0

local function to_roman(n)
  local numerals = {
    {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
    {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
    {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}
  }
  local result = ""
  for _, pair in ipairs(numerals) do
    while n >= pair[1] do
      result = result .. pair[2]
      n = n - pair[1]
    end
  end
  return result
end

local function to_alpha(n)
  return string.char(64 + n)
end

function Header(el)
  if el.level == 1 then
    section_count = section_count + 1
    subsection_count = 0
    table.insert(el.content, 1, pandoc.Str(to_roman(section_count) .. ". "))
  elseif el.level == 2 then
    subsection_count = subsection_count + 1
    table.insert(el.content, 1, pandoc.Str(to_alpha(subsection_count) .. ". "))
  end
  return el
end
