local log = require("log")

---@type integer
local namespace = vim.api.nvim_create_namespace("ui")

local state = {
  buf = vim.api.nvim_create_buf(false, true),
  win = nil,
}

---@param lines string[]
local function open(lines)
  state.win = state.win or vim.api.nvim_open_win(state.buf, false, {
    split = "below",
  })

  vim.schedule(function()
    vim.api.nvim_buf_set_lines(state.buf, -1, -1, false, lines)
  end)
end

--- Turns attribute ID to highlight group.
---@param attr integer
---@return string
local attr_to_hl = function(attr)
  return vim.fn.synIDattr(vim.fn.synIDtrans(attr), "name")
end

--- Processes UI contents.
---@param content [ integer, string ][]
---@return string[]
---@return ui.cmdline.decorations
local process_content = function(content)
  ---|fS

  local lines = {}
  local extmarks = {}

  local X = 0

  --- Handles a part of {content}.
  ---@param part [ integer, string ]
  local function handle_part(part)
    if #extmarks == 0 then
      table.insert(extmarks, {})
      table.insert(lines, part[2])
    else
      lines[#lines] = lines[#lines] .. part[2]
    end

    table.insert(extmarks[#extmarks], {
      X,
      X + #part[2],
      attr_to_hl(part[3] or part[1]),
    })
    X = X + #part[2]
  end

  --- Handles a part of {content} containing
  --- newlines.
  ---@param part [ integer, string ]
  local function handle_newline(part)
    ---|fS

    local _lines = vim.split(part[2], "\n", {})

    for l, line in ipairs(_lines) do
      if l == 1 and #lines > 0 then
        lines[#lines] = lines[#lines] .. line
        table.insert(extmarks[#extmarks], { X, X + #line, attr_to_hl(part[3] or part[1]) })

        X = X + #line
      else
        table.insert(lines, line)
        table.insert(extmarks, {
          { 0, #line, attr_to_hl(part[3] or part[1]) },
        })

        X = #line
      end
    end

    ---|fE
  end

  for _, entry in ipairs(content) do
    if string.match(entry[2], "\n") then
      handle_newline(entry)
    else
      handle_part(entry)
    end
  end

  return lines, extmarks

  ---|fE
end

local noop = function(...)
  -- no operation
end

local arg2lines = function(t)
  local res = vim.iter(t[1]):fold({}, function(acc, msg)
    local msg_type = msg[1]
    local lines = msg[2]
    vim.list_extend(acc, lines)
    return acc
  end)

  res = vim
    .iter(res)
    :map(function(line)
      return line[2]
    end)
    :totable()

  for i, line in ipairs(res) do
    if line:find("\n") then
      local new_lines = vim.split(line, "\n")
      res[i] = new_lines
    end
  end

  res = vim.tbl_flatten(res)

  return res
end

local mes = {}

local __add = function(kind, content)
  mes[#mes + 1] = {
    kind = kind,
    content = content,
  }
end

---@param kind ui.message.kind
---@param content ui.message.fragment[]
---@param replace_last boolean
local msg_show = function(kind, content, replace_last)
  ---|fS

  if kind == "confirm" then
    -- log.assert(
    --   "ui/message.lua → __confirm",
    --   pcall(message.__confirm, {
    --     kind = kind,
    --     content = content,
    --   })
    -- )
  elseif kind == "search_count" then
    --- Do not handle search count as messages.
    return
  elseif kind == "return_prompt" then
    --- Hit `<ESC>` on hit-enter prompts.
    --- or else we get stuck.
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", false)
  -- elseif replace_last and vim.tbl_isempty(message.visible) == false then
  --   -- message.__replace(kind, content)
  else
    __add(kind, content)
  end

  ---|fE
end
--
-- local map = {
--   msg_show = msg_show,
--   -- msg_clear = noop,
--   -- msg_showmode = noop,
--   -- msg_showcmd = noop,
--   -- msg_ruler = noop,
--   -- msg_history_clear = noop,
--   msg_history_show = function(...)
--     local lines = arg2lines({ ... })
--     -- local lines = process_content(({ ... })[1])
--     open(lines)
--   end,
-- }
--
-- vim.ui_attach(namespace, {
--   ext_cmdline = true,
--   ext_messages = true,
--   ext_popupmenu = true,
-- }, function(event, ...)
--   local handler = map[event] or noop
--   handler(...)
-- end)
--
-- vim.cmd.mes()
