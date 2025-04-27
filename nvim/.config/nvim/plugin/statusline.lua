---@type table<string, fun():...>
local cmp = {}

local concat = table.concat

local statusline = {
  '%{%v:lua._diy_statusline("mode")%}',
  '%{%v:lua._diy_statusline("git")%}',
  '%{%v:lua._diy_statusline("diagnostic")%}',
  "%t %r %m",
  "%<",
  "%=",
  '%{%v:lua._diy_statusline("doing")%}',
  '%{%v:lua._diy_statusline("wc")%}',
  '%{%v:lua._diy_statusline("lsp")%}',
  '%{%v:lua._diy_statusline("ft")%}',
  '%{%v:lua._diy_statusline("percentage")%}',
  '%{%v:lua._diy_statusline("position")%}',
  -- '%{%v:lua._diy_statusline("time")%}',
}

--- from lualine.nvim
local mode2name = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local mode2hl = {
  N = "DiyStatuslineModeNormal",
  I = "DiyStatuslineModeInsert",
  V = "DiyStatuslineModeVisual",
  R = "DiyStatuslineModeReplace",
  C = "DiyStatuslineModeCommand",
}

setmetatable(cmp, {
  __index = function()
    return "DiyStatuslineModeOther"
  end,
})

--- highlight pattern
-- This has three parts:
-- 1. the highlight group
-- 2. text content
-- 3. special sequence to restore highlight: %*
-- Example pattern: %#SomeHighlight#some-text%*
local hi_pattern = "%%#%s#%s%%*"

local function padding(str)
  return " " .. vim.trim(str) .. " "
end

function _G._diy_statusline(name)
  local t = { cmp[name]() }
  local buf = {}
  for i = 1, #t, 2 do
    local text, hi = t[i], t[i + 1]
    buf[#buf + 1] = hi_pattern:format(hi, padding(text))
  end
  return concat(buf)
end

function cmp.mode()
  local mode_code = vim.api.nvim_get_mode().mode
  local char = mode2name[mode_code]:sub(1, 1)
  return char, "@comment.hint"
end

function cmp.git()
  local branch = vim.system({ "git", "branch", "--show-current" }, { text = true }):wait().stdout
  return branch, "DiyStatuslineDevinfo"
end

--
-- function cmp.time()
--    return time, "@comment.hint"
-- end

function cmp.diagnostic()
  local ignore = {
    ["c"] = true, -- command mode
    ["t"] = true, -- terminal mode
  }

  local mode = vim.api.nvim_get_mode().mode

  if ignore[mode] then
    return "λ", "DiagnosticOk"
  end

  local levels = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(0, { severity = levels.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = levels.WARN })

  if warnings > 0 and errors > 0 then
    return ("E:%d"):format(errors), "DiagnosticError", (" W:%d"):format(warnings), "DiagnosticWarn"
  elseif warnings > 0 then
    return ("W:%d"):format(warnings), "DiagnosticWarn"
  elseif errors > 0 then
    return ("E:%d"):format(errors), "DiagnosticError"
  else
    return "λ", "DiagnosticOk"
  end
end

function cmp.position()
  return "%3l:%-2c", select(2, cmp.mode())
end

function cmp.percentage()
  return "%2p%%", "DiyStatuslineDevinfo"
end

function cmp.ft()
  local ok, MiniIcons = pcall(require, "mini.icons")
  if ok then
    local icon, hi = MiniIcons.get("extension", vim.bo.filetype)
    return icon, hi
  else
    return vim.bo.filetype, "Title"
  end
end

---Show attached LSP clients in `[name1, name2]` format.
---Long server names will be modified. For example, `lua-language-server` will be shorten to `lua-ls`
---Returns an empty string if there aren't any attached LSP clients.
function cmp.lsp()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return ""
  end
  local names = vim
    .iter(attached_clients)
    :map(function(client)
      local name = client.name:gsub("language.server", "ls")
      return name
    end)
    :totable()
  return "[" .. concat(names, ", ") .. "]"
end

function cmp.doing()
  local ok, doing = pcall(require, "doing")
  if ok then
    return doing.status(), "@markup.strong"
  end
end

function cmp.harpoon()
  local ok, harpoon_files = pcall(require, "harpoon_files")
  if ok then
    return harpoon_files.lualine_component()
  end
end

function cmp.wc()
  --   return require("wordcounter").count_cur_buf_words()
  return vim.g.obsidian_statusline
end

-- local time
-- local uv = vim.uv
-- local timer = uv.new_timer()
-- if timer then
--   timer:start(0, 1000, function()
--     vim.schedule(function()
--       vim.o.statusline = concat(statusline)
--     end)
--   end)
-- end
-- vim.o.statusline = concat(statusline)
