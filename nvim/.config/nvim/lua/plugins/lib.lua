return {
  { "echasnovski/mini.notify", lazy = true },
  { "j-hui/fidget.nvim", lazy = true },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    -- cond = vim.g.my_picker == "telescope",
  },
  {
    "echasnovski/mini.pick",
    lazy = true,
    cond = vim.g.my_picker == "mini.pick",
  },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    -- cond = vim.g.my_picker == "fzf-lua",
  },
}
