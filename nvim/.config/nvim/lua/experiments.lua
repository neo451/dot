vim.cmd([[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
]])

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteWritePost",
  callback = function(ev)
    --- format code blocks
    require("conform").format({
      bufnr = ev.buf,
      formatters = { "prettier", "injected" },
    })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    local note = ev.data.note
    --- if frontmatter has `spell: false`, turn of spell
    if note and note.metadata and note.metadata.spell == false then
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
    -- "position",
  },
})

require("statusline").enable(false)

require("babel").enable(true)

pcall(function()
  require("vim._extui").enable({
    msg = {
      pos = "box",
    },
  })
end)

-- require("rime") -- additional rime stuff

require("_obsidian").enable(true)

local function enable_wall()
  vim.o.termguicolors = false
  vim.cmd.colorscheme("neopywal")
end

-- enable_wall()

-- require("quickfix")
