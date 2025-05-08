return {
  "nvim-lualine/lualine.nvim",
  cond = true,
  opts = {
    options = {
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_x = {
        { require("rime").status, "encoding", "fileformat", "filetype" },
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
