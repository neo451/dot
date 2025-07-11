vim.api.nvim_create_user_command("Sort", function(opts)
  if not tonumber(opts.args) then
    print("Error: Argument must be a number")
    return
  end
  local bang = opts.bang and "!" or ""
  local range = opts.range == 0 and "" or ("%d,%d"):format(opts.line1, opts.line2)
  local pattern = string.format("%ssort%s /^\\([^|]*|\\)\\{%s\\}/", range, bang, opts.args)
  vim.cmd(pattern)
end, { nargs = 1, bang = true, range = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    local note = ev.data.note
    --- if frontmatter has `spell: false`, turn of spell
    if note and note.metadata and note.metadata.spell == false then
      print("here?")
      vim.wo.spell = false
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.md",
  callback = function(ev)
    local client_id = ev.data.client_id

    local client = vim.lsp.get_client_by_id(client_id)

    if client and client.name == "harper_ls" then
      local ob = require("obsidian").get_client()
      local note = ob:current_note(ev.buf)
      if note and note.metadata and note.metadata.harper == false then
        client:stop()
      end
    end
  end,
})

vim.api.nvim_create_user_command("Lsp", "checkhealth vim.lsp", {})

require("search").setup({})

require("statusline").setup({
  left = {
    "mode",
    "git",
    "diagnostic",
  },
  right = {
    "obsidian",
    "lsp",
    "ft",
    -- "percentage",
    "position",
  },
})

require("statusline").enable(false)

require("babel").enable(true)

pcall(function()
  require("vim._extui").enable({})
end)

require("ob_git").enable(false)

-- require("quickfix")

local project_rooter_config = {
  patterns = {
    ".git",
    "CMakeLists.txt",
    "Makefile",
    "package.json",
    "Cargo.toml",
    "pyproject.toml",
    "go.mod",
    "main.tex",
    ".root",
  }, -- what files to watch out for
  level_limit = 5, -- how many levels to go up
}

local function ProjectRooter()
  local config = project_rooter_config
  local patterns = config.patterns

  local current = vim.fn.expand("%:p:h")
  local level = 0

  local found = nil

  while found == nil and level <= config.level_limit do
    if vim.fn.isdirectory(current) == 1 then
      for _, pattern in ipairs(patterns) do
        if vim.fn.glob(current .. "/" .. pattern) ~= "" then
          -- Found a project root, set the working directory
          found = current
          break
        end
      end
    end

    if found ~= nil then
      break
    end

    current = vim.fn.fnamemodify(current, ":h")
    level = level + 1
  end

  if found == nil then
    -- No project root found, notify the user
    vim.notify("No project root found in " .. vim.fn.expand("%:p:h"), vim.log.levels.WARN)
    return
  end

  vim.ui.input({
    prompt = "Root found. Confirm: ",
    default = found,
    completion = "dir",
  }, function(input)
    if input ~= nil and vim.fn.isdirectory(input) == 1 then
      vim.cmd.cd(input)
    end
  end)
end

local wk = require("which-key")

wk.add({
  { "<leader>pp", ProjectRooter, desc = "Project rooter" },
})
