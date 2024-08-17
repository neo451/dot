return {
   {
      "echasnovski/mini.nvim",
      config = function()
         -- va)  - [V]isually select [A]round [)]paren
         -- yinq - [Y]ank [I]nside [N]ext [']quote
         -- ci'  - [C]hange [I]nside [']quote
         -- require("mini.ai").setup({ n_lines = 500 })
      end,
   },
   {
      "ggandor/leap.nvim",
      event = "BufReadPost",
      config = function()
         local leap = require("leap")
         leap.add_default_mappings()
         leap.add_repeat_mappings(";", ",", {
            relative_directions = true,
            modes = { "n", "x", "o" },
         })
      end,
   },
   -- {
   --    "ggandor/flit.nvim",
   --    opts = {
   --       keys = { f = "f", F = "F" },
   --       -- A string like "nv", "nvo", "o", etc.
   --       labeled_modes = "v",
   --       -- Repeat with the trigger key itself.
   --       clever_repeat = true,
   --       multiline = true,
   --       -- Like `leap`s similar argument (call-specific overrides).
   --       -- E.g.: opts = { equivalence_classes = {} }
   --       opts = {},
   --    },
   -- },
   { "kylechui/nvim-surround", opts = {} },
   { "ethanholz/nvim-lastplace", opts = {} },
}
