return {
  -- TODO:
  {
    "vimwiki/vimwiki",
    cond = false,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    enabled = false,
  },

  {
    "nvim-orgmode/orgmode",
    -- event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    "zk-org/zk-nvim",
    cmd = "ZkIndex",
    config = function()
      require("zk").setup({})
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    cmd = "Telekasten",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-telekasten/calendar-vim",
    },
    opts = {
      home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
    },
  },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    dependencies = {
      { "nvim-neorg/lua-utils.nvim", lazy = true },
    },
    version = "*", -- Pin Neorg to the latest stable release
    config = {
      ["core.dirman"] = {
        config = {
          workspaces = {
            my_ws = "~/neorg", -- Format: <name_of_workspace> = <path_to_workspace_root>
            -- my_other_notes = "~/work/notes",
          },
          index = "index.norg", -- The name of the main (root) .norg file
        },
      },
    },
  },
}
