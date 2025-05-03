require("boot")
require("options")
require("keymaps")
require("autocmds")

local servers = {
  "dummy",
  "lua_ls",
  "gopls",
  "harper_ls",
  "nixd",
  "rime_ls",
  "marksman",
  "zls",
}

---@alias cmp "cmp" | "blink" | "mini"
---@alias pickers "snacks.picker" | "mini.pick" | "telescope" | "fzf-lua"

---@type cmp
vim.g.my_cmp = "blink"
-- vim.g.my_cmp = "cmp"

---@type pickers
vim.g.my_picker = "snacks.picker"

---@type "render-markdown" | "markview"
vim.g.markdown_renderer = "render-markdown"

vim.cmd([[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
]])

require("lazy").setup({
  git = {
    url_format = "git@github.com:%s.git",
  },
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { vim.g.my_color, "habamax" } },
  checker = { enabled = true },
})

-- vim.g.my_color = "tokyonight-storm"
vim.g.my_color = "duskfox"
vim.cmd.colorscheme(vim.g.my_color)

-- local has_blink = pcall(require, "blink.cmp")
-- local capabilities = has_blink and require("blink.cmp").get_lsp_capabilities()
--   or vim.lsp.protocol.make_client_capabilities()

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, name in ipairs(servers) do
  local config = require("lsp." .. name)
  config.capabilities = capabilities
  vim.lsp.config[name] = config
  pcall(vim.lsp.enable, name)
end

require("rime") -- additional rime stuff

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

require("statusline").enable(true)

pcall(function()
  require("vim._extui").enable({
    msg = {
      pos = "box",
    },
  })
end)
