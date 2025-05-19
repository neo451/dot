return {
  {
    "stevearc/oil.nvim",
    opts = {
      skip_confirm_for_simple_edits = true,
      win_options = {
        signcolumn = "yes:2",
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    ft = { "oil" },
    config = true,
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    ft = { "oil" },
    opts = {},
  },
}
