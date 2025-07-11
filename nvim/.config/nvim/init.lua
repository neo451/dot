local function build(name, cmds)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      if ev.data.kind == "install" and ev.data.spec.name == name then
        vim.system(
          cmds,
          {
            cwd = ev.data.path,
          },
          vim.schedule_wrap(function(out)
            assert(out.code == 0, "failed to build")
            vim.notify(out.stdout)
            vim.notify(out.stderr)
          end)
        )
      end
    end,
  })
end

build("mcphub.nvim", { "nvim", "-l", "bundled_build.lua" })

local ok, err = pcall(vim.pack.add, {
  "https://github.com/mbbill/undotree",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",

  -- lazy loader
  "https://github.com/BirdeeHub/lze",

  -- lib
  "https://github.com/gregorias/coop.nvim",
  "https://github.com/nvim-lua/plenary.nvim",

  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/NeogitOrg/neogit",

  -- motions
  "https://github.com/monaqa/dial.nvim",

  -- beauty
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/echasnovski/mini.icons",
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
})

if not ok then
  vim.notify(err)
end

local local_plugins = {
  "~/Plugins/obsidian.nvim/",
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
    before = function()
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
      require("_mini")
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
      require("_ai")
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
})

require("_obsidian")
require("experiments")

vim.cmd("colorscheme tokyonight-storm")
