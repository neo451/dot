vim.cmd([[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
]])

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

pcall(function()
  require("vim._extui").enable({
    msg = {
      pos = "box",
    },
  })
end)

-- require("rime") -- additional rime stuff

require("_obsidian").enable(true)
