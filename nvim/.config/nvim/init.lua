require("boot")
require("options")
require("keymaps")
require("autocmds")

---@type "cmp" | "blink" | "mini"
vim.g.my_cmp = "blink"

---@type "snacks.picker" | "mini.pick" | "telescope" | "fzf-lua"
vim.g.my_picker = "snacks.picker"

---@type "tokyonight-storm" | "duskfox" | "neopywal"
vim.g.my_color = "neopywal"

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

local servers = {
  "lua_ls",
  "gopls",
  "harper_ls",
  "nixd",
  "rime_ls",
  "zls",
  -- "dummy",
}

for _, name in ipairs(servers) do
  pcall(vim.lsp.enable, name)
end

require("experiments")
