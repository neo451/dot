return {
   "nvim-neorg/neorg",
   lazy = false,
   version = "*",
   opts = {
      load = {
         ["core.defaults"] = {},
         ["core.concealer"] = {
            config = {
               icon_preset = "diamond",
            },
         },
         ["core.dirman"] = {
            config = {
               workspaces = {
                  work = "~/work",
                  notes = "~/notes",
               },
               default_workspace = "notes",
            },
         },
         ["core.export"] = {},
         ["core.tangle"] = {},
      },
   },
   keys = {
      { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Open [N]eorg [I]ndex" },
      { "<M-CR>", "<Plug>(neorg.itero.next-iteration)" },
      { "<leader>lg", "<Plug>(neorg.looking-glass.magnify-code-block)", desc = "Neorg [L]ooking [G]lass" },
   },
}
