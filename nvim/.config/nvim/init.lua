require("options")
require("boot")
require("keymaps")
require("autocmds")

local servers = {
  "dummy",
  "lua_ls",
  "gopls",
  "harper_ls",
  "nixd",
  "rime_ls",
  "zls",
  -- "marksman",
}

---@type "cmp" | "blink" | "mini"
vim.g.my_cmp = "blink"

---@type "snacks.picker" | "mini.pick" | "telescope" | "fzf-lua"
vim.g.my_picker = "snacks.picker"

vim.g.my_color = "tokyonight-storm"

---@type "render-markdown" | "markview"
vim.g.markdown_renderer = "render-markdown"

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

vim.cmd.colorscheme(vim.g.my_color)

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, name in ipairs(servers) do
  local config = require("lsp." .. name)
  config.capabilities = capabilities
  vim.lsp.config[name] = config
  pcall(vim.lsp.enable, name)
end

require("experiments")
