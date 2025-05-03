return {
  "nvim-lualine/lualine.nvim",
  cond = false,
  opts = {
    options = {
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_x = {
        {
          "g:obsidian",
        },
        {
          "g:feed_progress",
        },
        "filetype",
      },
    },
  },
}
