return {
  {
    "marcocofano/excalidraw.nvim",
    opts = {},
  },
  -- TODO: https://github.com/ViViDboarder/vim-settings/blob/23cf5fc1feabcc1baf66a622ffb869117b51e50f/neovim/lua/plugins/obsidian.lua
  -- TODO: https://github.com/B4rc1/obsidian-companion.nvim?tab=readme-ov-file
  -- TODO: https://github.com/oflisback/obsidian-bridge.nvim
  {
    "oflisback/obsidian-bridge.nvim",
    opts = {
      -- your config here
    },
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
    },
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = false,
  },
  {
    "efirlus/quickadd.nvim",
    cond = false,
    opts = {
      -- daily_note_path = "~/notes/daily/",
      -- todo_path = "~/notes/project/todolist.md",
    },
  },
  {
    "arakkkkk/kanban.nvim",
    cond = false,
    opts = {
      markdown = {
        description_folder = "./tasks/", -- Path to save the file corresponding to the task.
        list_head = "## ",
      },
    },
  },
  {
    "delphinus/obsidian-kensaku.nvim",
    dependencies = {
      "lambdalisue/kensaku.vim",
      "vim-denops/denops.vim",
    },
    cond = false,
  },
}
