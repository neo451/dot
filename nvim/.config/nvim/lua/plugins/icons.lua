return {
   "echasnovski/mini.icons",
   opts = {
      file = {
         [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
         ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
         dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
      -- TODO:
      -- lsp = {
      --    copilot = { glyph = "", hl = "MiniIconsCyan" },
      --    ["rime-ls"] = { glyph = "", hl = "MiniIconsGreen" },
      -- },
   },
   init = function()
      package.preload["nvim-web-devicons"] = function()
         require("mini.icons").mock_nvim_web_devicons()
         return package.loaded["nvim-web-devicons"]
      end
   end,
}
