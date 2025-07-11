return {
  dir = "~/Plugins/musicfox.nvim/",
  cond = vim.fs.exists("~/Plugins/musicfox.nvim"),
  opts = {},
  keys = {
    {
      "<leader>ml",
      "<Plug>MusicfoxLyrics",
    },
    {
      "<leader>mf",
      "<Plug>MusicfoxOpen",
    },
    {
      "<leader>mp",
      "<Plug>MusicfoxPlayPause",
    },
    {
      "<leader>>",
      "<Plug>MusicfoxNext",
    },
    {
      "<leader><",
      "<Plug>MusicfoxPrevious",
    },
  },
}
