return {
   { "AndreM222/copilot-lualine" },
   {
      "zbirenbaum/copilot.lua",
      config = function()
         require("copilot").setup({})
      end,
   },
   {
      "zbirenbaum/copilot-cmp",
      config = function()
         require("copilot_cmp").setup()
      end,
   },
}
