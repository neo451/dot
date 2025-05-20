local M = {}
local util = require("lemon_util")

---@class lemon.config
---@field indent_size integer
---@field show_hidden boolean
local config = {
  indent_size = 2,
  show_hidden = false, -- TODO:
}

---@alias lemon.EntryType uv.aliases.fs_types

---@class (exact) lemon.Entry
---@field name string
---@field type lemon.EntryType
---@field id nil|integer Will be nil if it hasn't been persisted to disk yet
---@field parsed_name nil|string
---@field meta nil|table

local state = {
  buf = vim.api.nvim_create_buf(false, true),
  cache = {},
}

vim.bo[state.buf].filetype = "lemon"
vim.bo[state.buf].buftype = "acwrite"

local aug = vim.api.nvim_create_augroup("lemon", { clear = true })

vim.api.nvim_create_autocmd("BufWriteCmd", {
  group = aug,
  pattern = "lemon://*",
  nested = true,
  callback = function(params)
    vim.print(params)
    -- local last_keys = keybuf:as_str()
    -- local winid = vim.api.nvim_get_current_win()
    -- -- If the user issued a :wq or similar, we should quit after saving
    -- local quit_after_save = vim.endswith(last_keys, ":wq\r")
    --   or vim.endswith(last_keys, ":x\r")
    --   or vim.endswith(last_keys, "ZZ")
    -- local quit_all = vim.endswith(last_keys, ":wqa\r")
    --   or vim.endswith(last_keys, ":wqal\r")
    --   or vim.endswith(last_keys, ":wqall\r")
    local bufname = vim.api.nvim_buf_get_name(params.buf)
  end,
})

---@class lemon.anchor
---@field level integer
---@field row integer

local function count_indent(line)
  local c = 0
  for i = 1, #line do
    local char = string.sub(line, i, i)
    if char == " " then
      c = c + 1
    else
      break
    end
  end
  return c / config.indent_size
end

---@param buf integer
---@param anchor lemon.anchor
local function close_node(buf, anchor)
  local row = anchor.row
  local parent_indent = anchor.level
  local row_counter = row + 1
  for _ = 1, math.huge do
    local line = vim.api.nvim_buf_get_lines(buf, row_counter, row_counter + 1, false)[1]
    local indent_level = count_indent(line)
    if indent_level == parent_indent - 1 then
      break
    end
    row_counter = row_counter + 1
  end
  vim.api.nvim_buf_set_lines(buf, row, row_counter, true, {})
end

local function render_tree(buf, path, row, level)
  for name, t in vim.fs.dir(path) do
    local line = vim.text.indent(level * config.indent_size, util.format_line(name, t))
    vim.api.nvim_buf_set_lines(buf, row, row, false, { line })
    row = row + 1
  end
end

---@param path string
---@param anchor lemon.anchor?
local function edit_directory(path, anchor)
  anchor = anchor or { level = 0, row = 1 }
  local buf = state.buf
  if anchor.level == 0 then
    vim.b[buf].current_dir = path
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {}) -- clear buf
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, { "../" }) -- set parent line
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    vim.api.nvim_buf_set_name(buf, "lemon://" .. path)
  end

  render_tree(buf, path, anchor.row, anchor.level)

  vim.keymap.set("n", "<cr>", M.open_cursor, { buffer = buf })
  vim.keymap.set("n", "<tab>", M.expand_cursor, { buffer = buf })
end

---Edit file or edit directory
---@param path any
---@return nil
local function open(path)
  path = vim.fs.normalize(path)
  return util.is_file(path) and vim.cmd.edit(path) or edit_directory(path)
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

local function resolve_path(buf, row)
  local parents = { vim.b[buf].current_dir }
  local lines = vim.api.nvim_buf_get_lines(buf, 0, row, false)
  local level = count_indent(lines[#lines])
  vim.list_extend(parents, find_parent(lines, level))
  parents[#parents + 1] = vim.fn.expand("<cfile>")
  return vim.fs.joinpath(unpack(parents))
end

-- Spawn a new tree below cursor
function M.expand_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_get_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local path = resolve_path(buf, row)
  if util.is_file(path) then
    return
  end
  if not state.cache[path] then
    state.cache[path] = {
      expanded = false,
    }
  end
  local node = state.cache[path]
  local cursor_anchor = {
    level = count_indent(line) + 1,
    row = row,
  }
  if node.expanded then
    close_node(buf, cursor_anchor)
    node.expanded = false
  else
    edit_directory(path, cursor_anchor)
    node.expanded = true
  end
end

-- Spawn a new tree in new view
function M.open_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  open(resolve_path(buf, row))
end

-- Open the parent tree
function M.open()
  local buf = vim.api.nvim_get_current_buf()
  local path
  if vim.bo[buf].filetype == "lemon" then
    path = vim.fs.joinpath(vim.b[buf].current_dir, "..")
  else
    local file = vim.api.nvim_buf_get_name(buf)
    path = vim.fs.joinpath(file, "..")
  end
  open(path)
end

vim.keymap.set("n", "-", M.open)

M._find_parent = find_parent
M._count_indent = count_indent

return M
