return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "katkodeorg/telescope_worktree.nvim",
  },
  config = function()
    require("telescope").setup({})
    pcall(require("telescope").load_extension, "telescope_worktree")
    local extensions = require("telescope").extensions
    vim.keymap.set("n", "<leader>wt", function()
      extensions.telescope_worktree.create_worktree()
    end, { desc = "[W]ork tree [C]reate" })
  end,
}
