-- require("my_error")

local src = [[
Error detected while processing /home/n451/Dot/nvim/.config/nvim/lua/_lqf.lua:
E5113: Error while calling lua chunk: .../n451/.local/share/nvim/lazy/error.nvim/lua/my_error.lua:1: hi
stack traceback:
	[C]: in function 'error'
	.../n451/.local/share/nvim/lazy/error.nvim/lua/my_error.lua:1: in main chunk
	[C]: in function 'require'
	/home/n451/Dot/nvim/.config/nvim/lua/_lqf.lua:1: in main chunk
]]

-- TODO: deduplicate
-- TODO: match a nice text desc, look to next line for function name

local pattern = "([/%w%.%-_][/%w%.%-_]*):(%d+): (.+)"

local function is_dot(path)
  return vim.startswith(path, "...")
end

local function absolute(path)
  local base = vim.fs.basename(path):sub(1, -5)
  local mods = vim.loader.find(base)
  if #mods ~= 0 then
    return mods[1].modpath
  else
    return path
  end
end
local c_err = [[[C]: in function 'error']]

local c_error_pattern = "%[C%]: in function '(%s+)'"

print(c_err:match(c_error_pattern))

---@return vim.quickfix.entry[]
---@return string
local function err2qf(err_string)
  local lines = vim.split(err_string, "\n")
  local items = {}

  ---@type vim.quickfix.entry
  for line in vim.iter(lines) do
    local filename, lnum, text = line:match(pattern)
    if filename then
      if is_dot(filename) then
        filename = absolute(filename)
      end

      items[#items + 1] = {
        filename = filename,
        lnum = tonumber(lnum),
        text = text,
      }
    end
  end

  -- local current
  --
  -- for i, item in ipairs(items) do
  --   if item == current then
  --     table.remove(items, i - 1)
  --     item.text = current.text .. " " .. item.text
  --   end
  --
  --   current = item
  -- end

  return items, lines[1]
end

vim.print(err2qf(src))

local function open_qf(title, items)
  vim.fn.setqflist({}, "r", {
    title = title,
    items = items,
  })
  vim.cmd.copen()
end

local function open()
  local items, title = err2qf()
  open_qf(title, items)
end

-- open()
