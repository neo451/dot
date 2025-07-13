local m = require("manager")

m.branch("harpoon", "harpoon2")
m.build("mcphub.nvim", { "nvim", "-l", "bundled_build.lua" })
m.build("blink.cmp", { "cargo", "build", "--release" })

local ok, err = pcall(vim.pack.add, {
  "https://github.com/mbbill/undotree",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/ThePrimeagen/harpoon",

  -- LSP
  "https://github.com/rachartier/tiny-code-action.nvim",

  -- lazy loader
  "https://github.com/BirdeeHub/lze",

  "https://github.com/alex-popov-tech/store.nvim",

  -- lib
  "https://github.com/gregorias/coop.nvim",
  "https://github.com/nvim-lua/plenary.nvim",

  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/NeogitOrg/neogit",

  -- motions
  "https://github.com/monaqa/dial.nvim",

  -- beauty
  "https://github.com/Bekaboo/dropbar.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.test",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/rasulomaroff/reactive.nvim",
  "https://github.com/mcauley-penney/visual-whitespace.nvim",

  -- treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",

  -- markdown
  -- "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/brianhuster/live-preview.nvim",
  "https://github.com/OXY2DEV/markview.nvim",
  "https://github.com/dhruvasagar/vim-table-mode",
  "https://github.com/jmbuhr/otter.nvim",
  "https://github.com/marcocofano/excalidraw.nvim",
  "https://github.com/arakkkkk/kanban.nvim",
  "https://github.com/efirlus/quickadd.nvim",

  -- game
  "https://github.com/NStefan002/2048.nvim",
  "https://github.com/szymonwilczek/vim-be-better",

  -- app
  "https://github.com/pwntester/octo.nvim",
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/mistweaverco/kulala.nvim",

  -- cmp
  "https://github.com/saghen/blink.cmp",

  -- ai
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/ravitemer/mcphub.nvim",
  "https://github.com/olimorris/codecompanion.nvim",

  -- picker
  "https://github.com/nvim-telescope/telescope.nvim",

  -- workflow
  "https://github.com/abecodes/tabout.nvim",

  -- experiment
  "https://github.com/A7Lavinraj/fyler.nvim",

  -- "file:///home/n451/Plugins/obsidian.nvim/",
  -- my
  -- {
  --   src = "https://github.com/obsidian-nvim/obsidian.nvim",
  --   version = "*",
  -- },
})

if not ok then
  vim.notify(err)
end

vim.cmd("colorscheme tokyonight-storm")

local local_plugins = {
  "~/Plugins/obsidian.nvim/",
  "~/Plugins/templater.nvim/",
  "~/Plugins/feed.nvim/",
}

for _, p in ipairs(local_plugins) do
  local path = vim.fs.normalize(p)
  vim.opt.rtp:append(path)
end

require("autocmds")
require("options")
require("keymaps")
require("lsp")

require("lze").load({
  {
    "snacks.nvim",
    before_all = function()
      -- Setup some globals for debugging (lazy-loaded)
      ---@diagnostic disable-next-line: duplicate-set-field
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      -- vim.print = _G.dd -- Override print to use snacks for `:=` command

      -- Create some toggle mappings
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
      Snacks.toggle.diagnostics():map("<leader>ud")
      Snacks.toggle.line_number():map("<leader>ul")
      Snacks.toggle
        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
        :map("<leader>uc")
      Snacks.toggle.treesitter():map("<leader>uT")
      Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
      Snacks.toggle.inlay_hints():map("<leader>uh")
      Snacks.toggle.indent():map("<leader>ug")
      Snacks.toggle.dim():map("<leader>uD")
    end,
    after = function()
      require("_snacks")
    end,
  },
  {
    "oil.nvim",
    after = function()
      require("_oil")
      vim.keymap.set("n", "-", "<cmd>Oil<cr>")
    end,
  },
  {
    "dial.nvim",
    keys = {
      "<C-a>",
      "<C-x>",
      "g<C-a>",
      "g<C-x>",
      -- TODO: visual
    },
    after = function()
      require("_dail")
    end,
  },
  {
    "mini.icons",
    after = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    "mini.pairs",
    -- event = "InsertEnter",
    ft = "lua",
    after = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "otter.nvim",
    ft = "markdown",
    after = function()
      require("otter").setup({})
    end,
  },
  {
    "mini.ai",
    after = function()
      require("mini.ai").setup({})
    end,
  },
  {
    "mini.test",
    after = function()
      require("mini.test").setup({})
    end,
  },
  {
    "blink.cmp",
    event = "InsertEnter",
    after = function()
      require("_blink")
    end,
  },
  {
    "markview.nvim",
    ft = "markdown",
    after = function()
      local presets = require("markview.presets")
      require("markview").setup({
        markdown = {
          headings = presets.headings.slanted,
        },
      })
    end,
  },
  {
    "nvim-treesitter",
    after = function()
      require("_ts")
    end,
  },
  {
    "lualine.nvim",
    after = function()
      require("_lualine")
    end,
  },
  {
    "mcphub.nvim",
    after = function()
      require("_mcp")
    end,
  },
  {
    "codecompanion.nvim",
    keys = {
      {
        "<leader>cc",
        "<cmd>CodeCompanionChat<cr>",
        desc = "CodeCompanion Chat",
      },
    },
    after = function()
      require("codecompanion").setup({})
    end,
  },
  {
    "neogit",
    cmd = "Neogit",
    after = function()
      require("neogit").setup({})
    end,
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Neo Git",
      },
    },
  },
  {
    "conform.nvim",
    after = function()
      require("_conform")
    end,
  },
  {
    "lazydev.nvim",
    ft = "lua",
    after = function()
      require("lazydev").setup({
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      })
    end,
  },
  {
    "nightfox.nvim",
    colorscheme = "duskfox",
  },
  {
    "tabout.nvim",
    event = "InsertCharPre",
    after = function()
      require("_tabout")
    end,
  },
  {
    "harpoon",
    keys = {
      "<C-e>",
      "<leader>a",
      "<leader>1",
      "<leader>2",
      "<leader>3",
      "<leader>4",
      "<leader>5",
    },
    after = function()
      require("_harpoon")
    end,
  },
  {
    "dropbar.nvim",
    after = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    end,
  },
  {
    "tiny-code-action.nvim",
    event = "LspAttach",
    after = function()
      require("tiny-code-action").setup({})
      vim.keymap.set({ "n", "x" }, "gra", function()
        require("tiny-code-action").code_action({})
      end, { noremap = true, silent = true })
    end,
  },
  {
    "excalidraw.nvim",
    after = function()
      require("excalidraw").setup({})
    end,
  },
  {
    "kanban.nvim",
    after = function()
      require("kanban").setup({})
    end,
  },
})

require("_obsidian")
require("experiments")
