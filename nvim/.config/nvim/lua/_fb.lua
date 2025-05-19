local uv = vim.uv
local M = {}

local function is_file(path)
  print("checking if file for", path)
  local stat = uv.fs_stat(path).type
  return stat and stat == "file"
end

local function format_line(name, t)
  if t == "file" then
    return name
  elseif t == "directory" then
    return name .. "/"
  end
end

local state = {
  buf = vim.api.nvim_create_buf(false, true),
  cache = {},
}

vim.bo[state.buf].filetype = "lemon"

---@class lemon.anchor
---@field level integer
---@field row integer

local indent_size = 2

---@param path string
---@param anchor lemon.anchor?
local function edit_directory(path, anchor)
  anchor = anchor or {
    level = 0,
    row = 1,
  }
  local buf = state.buf
  vim.bo[buf].filetype = "lemon"
  if anchor.level == 0 then
    vim.b[buf].current_dir = path
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
  end
  local c = anchor.row

  if c == 1 then
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, { "../" })
    vim.api.nvim_set_current_buf(buf)
  end

  for name, t in vim.fs.dir(path) do
    local line = format_line(name, t)
    vim.api.nvim_buf_set_lines(buf, c, c, false, { string.rep(" ", anchor.level) .. line })
    c = c + 1
  end

  vim.keymap.set("n", "<cr>", M.open_cursor)
  vim.keymap.set("n", "<tab>", function()
    local file = vim.fn.expand("<cfile>")
    local full_path = vim.fs.joinpath(vim.b[buf].current_dir, file)
    if is_file(full_path) then
      return
    end
    if not state.cache[full_path] then
      state.cache[full_path] = {
        expanded = false,
      }
    end
    local node = state.cache[full_path]
    -- if node.expanded then
    --   node.expanded = false
    -- else
    --   node.expanded = true
    -- end

    if not node.expanded then
      local anchor = {
        level = anchor.level + 1,
        row = vim.api.nvim_win_get_cursor(0)[1],
      }
      vim.print(full_path, anchor)
      edit_directory(full_path, anchor)
      node.expanded = true
    end
  end)
end

local function open(path)
  path = vim.fs.normalize(path)
  print(path)
  return is_file(path) and vim.cmd.edit(path) or edit_directory(path)
end

function M.open_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local parent = vim.b[buf].current_dir
  local path = vim.fs.joinpath(parent, vim.fn.expand("<cfile>"))
  open(path)
end

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

return M
