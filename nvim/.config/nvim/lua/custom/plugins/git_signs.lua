return {
   "lewis6991/gitsigns.nvim",
   opts = {
      signs = {
         add = { text = "+" },
         change = { text = "~" },
         delete = { text = "_" },
         topdelete = { text = "‾" },
         changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
         local gitsigns = require("gitsigns")

         local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
         end

         -- Navigation
         map("n", "<Down>", function()
            if vim.wo.diff then
               vim.cmd.normal({ "]c", bang = true })
            else
               gitsigns.nav_hunk("next")
            end
         end)

         map("n", "<Up>", function()
            if vim.wo.diff then
               vim.cmd.normal({ "[c", bang = true })
            else
               gitsigns.nav_hunk("prev")
            end
         end)

         -- Actions
         map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
         map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
         map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
         end, { desc = "[H]unk [S]tage" })
         map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
         end, { desc = "[H]unk [R]eset" })
         map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "[H]unk [U]ndo stage" })
         map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
         map("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [D]iffthis" })
         map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted" })

         -- Text object
         map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
   },
}
