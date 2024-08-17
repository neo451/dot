return {
   "nvim-telescope/telescope.nvim",
   event = "VimEnter",
   tag = "0.1.5",
   dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
         cond = function()
            return vim.fn.executable("make") == 1
         end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      "jvgrootveld/telescope-zoxide",
   },
   keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
      { "<leader>sb", "<cmd>Telescope builtin<cr>", desc = "[S]earch [S]elect Telescope" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch current [W]ord" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },
      {
         "<leader>/",
         function()
            require("telescope.builtin").current_buffer_fuzzy_find(
               require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
            )
         end,
         desc = "[/] Fuzzily search in current buffer",
      },

      {
         "<leader>s/",
         function()
            require("telescope.builtin").live_grep({
               grep_open_files = true,
               prompt_title = "Live Grep in Open Files",
            })
         end,
         desc = "[S]earch [/] in Open Files",
      },

      {
         "<leader>sn",
         function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
         end,
         desc = "[S]earch [N]eovim files",
      },
   },
   config = function()
      require("telescope").setup({
         extensions = {
            fzf = {},
            ["ui-select"] = {
               require("telescope.themes").get_dropdown(),
            },
         },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
   end,
}
