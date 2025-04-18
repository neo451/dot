---@diagnostic disable: missing-fields
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local configs = require("nvim-treesitter.parsers").get_parser_configs()
      for _, config in pairs(configs) do
        config.install_info.url = config.install_info.url:gsub("https://github.com/", "git@github.com:")
      end
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "go",
          "nix",
          "xml",
          "html",
          "markdown",
          "lua",
          "luadoc",
          -- "markdown_inline",
          "yaml",
          "regex",
          "bash",
          "json",
          "jsonc",
          "hyprlang",
        },
        ignore_install = { "org" },
        highlight = {
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
      })
    end,
  },
}
