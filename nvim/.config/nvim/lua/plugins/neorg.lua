require("neorg").setup({
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
})
