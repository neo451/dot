return {
  {
    "echasnovski/mini.hipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    opts = {},
  },
  {
    "echasnovski/mini.test",
    opts = {},
    -- keys = {
    --   "<leader><leader>x",
    -- },
  },
  {
    "echasnovski/mini.keymap",
    config = function()
      local map_multistep = require("mini.keymap").map_multistep

      -- map_multistep("i", "<Tab>", { "pmenu_next" })
      -- map_multistep("i", "<S-Tab>", { "pmenu_prev" })
      map_multistep("i", "<CR>", { "minipairs_cr" })
      map_multistep("i", "<BS>", { "minipairs_bs" })
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
