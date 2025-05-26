return {
  "nvim-lualine/lualine.nvim",
  cond = true,
  opts = {
    options = {
      theme = vim.g.my_color,
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_x = {
        { require("rime").status, "encoding", "fileformat", "filetype" },
        "g:musicfox_lyric",
        "g:musicfox",
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
