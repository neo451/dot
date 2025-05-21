local uv = vim.uv

local function is_file(path)
  local stat = uv.fs_stat(path)
  assert(stat, "Path error: " .. path)
  return stat.type == "file"
end

local function format_line(name, t)
  if t == "file" then
    return name
  elseif t == "directory" then
    return name .. "/"
  end
  -- TODO: symlinks
end

---Get base name from text
---@param line string
---@return string
local function parse_line(line)
  line = line or vim.api.nvim_get_current_line()
  line = vim.trim(line)
  if vim.endswith(line, "/") then
    return line:sub(1, -2)
  end
  -- TODO: symlinks
  return line
end

---look at lines above and return every parent line that indent level changes
---@param lines string[]
---@param current integer indent level of the cursor line
---@return table
local function find_parent(lines, current)
  local parents = {}
  if current == 0 then
    return parents
  end
  for i = #lines, 1, -1 do
    local line = lines[i]
    local indent = count_indent(line)
    if indent < current then
      current = indent
      table.insert(parents, 1, parse_line(line))
    end
    if indent == 0 then
      break
    end
  end
  return parents
end

return {
  is_file = is_file,
  format_line = format_line,
  parse_line = parse_line,
  find_parent = find_parent,
}
