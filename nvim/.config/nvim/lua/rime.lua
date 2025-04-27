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
--
-- if pcall(require, "blink.cmp") then
--    -- if last char is number, and the only completion item is provided by rime-ls, accept it
--    require("blink.cmp.completion.list").show_emitter:on(function(event)
--       if not vim.g.rime_enabled then
--          return
--       end
--       local col = vim.fn.col(".") - 1
--       -- if you don't want use number to select, change the match pattern by yourself
--       if event.context.line:sub(col, col):match("%d") == nil then
--          return
--       end
--       local rime_item_index = get_n_rime_item_index(2, event.items)
--       if #rime_item_index ~= 1 then
--          return
--       end
--       vim.schedule(function()
--          require("blink.cmp").accept({ index = rime_item_index[1] })
--       end)
--    end)
-- end

return {
  get_n_rime_item_index = get_n_rime_item_index,
  is_rime_item = is_rime_item,
}
