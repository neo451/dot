require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "go",
    "nix",
    "xml",
    "html",
    "markdown",
    "vimdoc",
    "lua",
    "luadoc",
    "gitcommit",
    "yaml",
    "regex",
    "bash",
    "json",
    "jsonc",
    "hyprlang",
    "norg",
    "zig",
    "toml",
    "http",
    "vhs",
    "csv",
  },
  ignore_install = { "org" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
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
}
