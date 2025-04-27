return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_x = {
        {
          "g:obsidian",
          color = "String",
        },
        {
          "g:feed_progress",
        },
        "filetype",
      },
    },
  },
}
