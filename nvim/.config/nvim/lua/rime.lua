local M = {}

local function contains_unacceptable_character(content)
  if content == nil then
    return true
  end
  local ignored_head_number = false
  for i = 1, #content do
    local b = string.byte(content, i)
    if b >= 48 and b <= 57 or b == 32 or b == 46 then
      -- number dot and space
      if ignored_head_number then
        return true
      end
    elseif b <= 127 then
      return true
    else
      ignored_head_number = true
    end
  end
  return false
end

local function is_rime_item(item)
  if item == nil or item.source_name ~= "LSP" then
    return false
  end
  local client = vim.lsp.get_client_by_id(item.client_id)
  return client ~= nil and client.name == "rime_ls"
end

-- Check if item is acceptable, you can define rules by yourself
local function rime_item_acceptable(item)
  return not contains_unacceptable_character(item.label) or item.label:match("%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d%")
end

-- Get the first n rime items' index in the completion list
local function get_n_rime_item_index(n, items)
  if items == nil then
    items = require("blink.cmp.completion.list").items
  end
  local result = {}
  if items == nil or #items == 0 then
    return result
  end
  for i, item in ipairs(items) do
    if is_rime_item(item) and rime_item_acceptable(item) then
      result[#result + 1] = i
      if #result == n then
        break
      end
    end
  end
  return result
end

require("blink.cmp.completion.list").show_emitter:on(function(event)
  local col = vim.fn.col(".") - 1
  -- if you don't want use number to select, change the match pattern by yourself
  if event.context.line:sub(col, col):match("%d") == nil then
    return
  end
  local rime_item_index = get_n_rime_item_index(2, event.items)
  if #rime_item_index ~= 1 then
    return
  end
  vim.schedule(function()
    require("blink.cmp").accept({ index = rime_item_index[1] })
  end)
end)

-- toggle rime
vim.b.rime_enabled = false
local toggle_rime = function()
  local client = vim.lsp.get_clients({ name = "rime_ls" })[1]
  assert(client, "rime_ls not found")

  client:exec_cmd({
    title = "toggle_rime",
    command = "rime-ls.toggle-rime",
  }, {}, function(_, result)
    vim.print(result)
  end)

  -- vim.lsp.buf_request(0, "workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
  --   if ctx.client_id == client_id then
  --     vim.b.rime_enabled = result
  --   end
  -- end)
end

vim.keymap.set("n", "<leader>rr", toggle_rime)

-- update lualine
local function rime_status()
  if vim.b.rime_enabled then
    return "ㄓ"
  else
    return ""
  end
end

return {
  status = rime_status,
  get_n_rime_item_index = get_n_rime_item_index,
  is_rime_item = is_rime_item,
}
