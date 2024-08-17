return {
   {
      "davidgranstrom/scnvim",
      config = function()
         local scnvim = require("scnvim")
         local map = scnvim.map
         local map_expr = scnvim.map_expr
         scnvim.setup({
            keymaps = {
               ["<M-CR>"] = {
                  map("editor.send_block", { "i", "n" }),
                  map("editor.send_selection", "x"),
               },
               ["<CR>"] = map("postwin.toggle"),
               ["<M-L>"] = map("postwin.clear", { "n", "i" }),
               ["<C-y>"] = map("signature.show", { "n", "i" }),
               ["<leader>."] = map("sclang.hard_stop", { "n", "x", "i" }),
               ["<leader>st"] = map("sclang.start"),
               ["<leader>sk"] = map("sclang.recompile"),
               ["<F1>"] = map_expr("s.boot"),
               ["<F2>"] = map_expr("s.meter"),
               ["<F3>"] = map_expr("s.plotTree"),
            },
            sclang = {
               cmd = "/mnt/d/audio-software/sclang.exe",
            },
            postwin = {
               float = {
                  enabled = true,
               },
            },
         })
      end,
   },
   {
      "modal",
      dir = "/home/n451/modal.nvim/",
      config = function()
         require("modal_nvim").setup({})
      end,
   },
   { "orca", dir = "/home/n451/Plugins/nvim-orca/" },
}
