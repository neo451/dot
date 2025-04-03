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
               "g:feed_progress",
            },
            "encoding",
            "fileformat",
            "filetype",
         },
      },
      extensions = {
         "lazy",
         "oil",
         "quickfix",
         "man",
         --"feed",
      },
   },
}
