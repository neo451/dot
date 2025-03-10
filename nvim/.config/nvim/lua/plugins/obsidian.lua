return {
   "obsidian-nvim/obsidian.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   dir = "~/Plugins/obsidian.nvim/",
   dev = true,
   lazy = false,
   opts = {
      templates = {
         folder = "templates",
         date_format = "%Y-%m-%d",
         time_format = "%H:%M",
      },
      ui = {
         enable = false,
      },
      picker = {
         name = "snacks.pick",
      },
      completion = {
         blink = true,
         nvim_cmp = false,
         -- min_chars = 2,
      },
      workspaces = {
         {
            name = "brain",
            path = "~/Brain",
         },
      },
   },
   keys = {
      {
         "<leader>os",
         "<cmd>ObsidianSearch<cr>",
      },
      {
         "<leader>on",
         "<cmd>ObsidianNew<cr>",
      },
   },
}
