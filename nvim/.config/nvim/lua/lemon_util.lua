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

return {
  is_file = is_file,
  format_line = format_line,
}
