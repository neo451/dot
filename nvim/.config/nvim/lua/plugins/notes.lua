return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })
    end,
  },
  {
    "zk-org/zk-nvim",
    -- cmd = "ZkIndex",
    config = function()
      require("zk").setup({})
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    cmd = "Telekasten",
    dependencies = {
      -- "nvim-telekasten/calendar-vim",
    },
    opts = {
      home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
    },
  },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    ft = { "norg" },
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
