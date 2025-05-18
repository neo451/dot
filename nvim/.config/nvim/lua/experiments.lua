vim.cmd([[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
]])

-- vim.api.nvim_create_autocmd("LspAttach", {
--   pattern = "*.md",
--   callback = function(ev)
--     local client_id = ev.data.client_id
--
--     local client = vim.lsp.get_client_by_id(client_id)
--
--     if client and client.name == "harper_ls" then
--       local ob = require("obsidian").get_client()
--       local note = ob:current_note(ev.buf)
--       if note and note.metadata and note.metadata.spell == false then
--         client:stop()
--       end
--     end
--   end,
-- })

vim.api.nvim_create_user_command("Lsp", "checkhealth vim.lsp", {})

require("search").setup({})

require("statusline").setup({
  left = {
    "mode",
    "git",
    "diagnostic",
  },
  right = {
    "obsidian",
    "lsp",
    "ft",
    -- "percentage",
    -- "position",
  },
})

require("statusline").enable(false)

require("babel").enable(true)

pcall(function()
  require("vim._extui").enable({
    msg = {
      pos = "box",
    },
  })
end)

-- require("rime") -- additional rime stuff

require("_obsidian").enable(true)

-- require("quickfix")
