local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "git@github.com:folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")
require("autocmds")

local servers = {
  "lua_ls",
  "gopls",
  "harper_ls",
  "nixd",
  "rime_ls",
  "marksman",
}

vim.g.my_color = "tokyonight-storm"

require("lazy").setup({
  git = {
    url_format = "git@github.com:%s.git",
  },
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { vim.g.my_color, "habamax" } },
  checker = { enabled = true },
  readme = { enabled = false },
})

local has_blink = pcall(require, "blink.cmp")
local capabilities = has_blink and require("blink.cmp").get_lsp_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

for _, name in ipairs(servers) do
  local config = require("lsp." .. name)
  config.capabilities = capabilities
  vim.lsp.config[name] = config
  pcall(vim.lsp.enable, name)
end

vim.cmd.colorscheme(vim.g.my_color)

require("rime") -- additional rime stuff
