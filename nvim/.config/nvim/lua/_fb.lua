local uv = vim.uv
local M = {}

local function is_file(path)
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
  buf = nil,
}

local function edit_directory(path)
  local buf = state.buf or vim.api.nvim_create_buf(false, true)
  state.buf = buf
  vim.bo[buf].filetype = "lemon"
  vim.b[buf].current_dir = path
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
  local c = 1
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, { "../" })

  for name, t in vim.fs.dir(path) do
    local line = format_line(name, t)
    vim.api.nvim_buf_set_lines(buf, c, c, false, { line })
    c = c + 1
  end

  vim.api.nvim_set_current_buf(buf)

  vim.keymap.set("n", "<cr>", M.open_cursor)
end

local function open(path)
  path = vim.fs.normalize(path)
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
    path = vim.fs.joinpath(vim.fn.expand("%"), "..")
  end
  open(path)
end

vim.keymap.set("n", "-", M.open)

return M
