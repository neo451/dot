require("lualine").setup({
  options = {
    -- theme = vim.g.my_color,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_x = {
      {
        -- require("rime").status,
        "encoding",
        "fileformat",
        "filetype",
      },
      {
        "g:musicfox_lyric",
        color = "String",
      },
      "g:musicfox",
      {
        "b:obsidian_footer_format",
      },
      {
        "g:feed_progress",
      },
      "filetype",
    },
  },
})
