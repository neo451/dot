for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
   config.install_info.url =
      config.install_info.url:gsub("https://github.com/", "https://mirror.ghproxy.com/https://github.com/")
end

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
   ensure_installed = { "c", "haskell", "lua", "ocaml", "zig" },
   auto_install = true,
   highlight = { enable = true },
   indent = { enable = true },
})

require("nvim-treesitter.configs").setup({
   textobjects = {
      swap = {
         enable = true,
         swap_next = {
            ["<leader>]"] = "@parameter.inner",
         },
         swap_previous = {
            ["<leader>["] = "@parameter.inner",
         },
      },
      select = {
         enable = true,
         lookahead = true,
         keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
         },
         selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
         },
      },
   },
})
