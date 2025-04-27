-- TODO: https://github.com/B4rc1/obsidian-companion.nvim?tab=readme-ov-file
-- TODO: https://github.com/oflisback/obsidian-bridge.nvim
return {
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
