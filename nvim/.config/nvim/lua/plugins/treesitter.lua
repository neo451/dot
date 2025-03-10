return {
   "nvim-treesitter/nvim-treesitter-textobjects",
   {
      "nvim-treesitter/nvim-treesitter",
      main = "nvim-treesitter.configs",
      opts = {
         ensure_installed = "all",
         ignore_install = { "org" },
         higfhlight = {
            enable = true,
         },
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
                  ["@function.outer"] = "v", -- linewise
               },
               include_surrounding_whitespace = false,
            },
         },
      },
   },
}
