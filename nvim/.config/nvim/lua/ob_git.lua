local M = {}

-- TODO: lock commit if not finished pulling
-- local check if in git repo
-- if theres things in staging area, commit them on vim exist
-- if delete, stage that?

local mes = {
  push = { ok = "pushed ", err = "failed to push" },
  pull = { ok = "pulled ", err = "failed to pull" },
  add = { ok = "added ", err = "failed to add" },
  commit = { ok = "commited ", err = "failed to commit" },
}

--- runs a git cmd in the current vault root
---@param cmds string[]
---@param callback? fun(obj: vim.SystemCompleted)
function M.run(cmds, callback)
  local client = require("obsidian").get_client()
  local cmd = cmds[2]

  -- TODO: signify start operation
  -- vim.notify(msgs.ok, vim.log.levels.INFO, { title = "Obsidian" })
  vim.system(
    cmds,
    {
      cwd = tostring(client:vault_root()),
      stdout = function(err, data)
        if cmd == "pull" then
          print(err, data)
        end
      end,
    },
    vim.schedule_wrap(function(obj)
      local msgs = mes[cmd]
      if obj.code == 0 then
        vim.notify(msgs.ok, vim.log.levels.INFO, { title = "Obsidian" })
      else
        vim.notify(msgs.err, vim.log.levels.ERROR, { title = "Obsidian" })
      end
      if callback then
        callback(obj)
      end
    end)
  )
end

local opts
opts = {
  ---@return string
  message = function()
    return os.date("%Y-%m-%d %H:%M:%S")
  end,

  pull = function(ev)
    M.run({ "git", "pull" }, function()
      local file = ev.data.note.path.filename
      -- TODO: infinately pulling here...
      if not vim.b[ev.buf].pulled_once then
        vim.cmd.e(file)
        vim.b[ev.buf].pulled_once = true
      end
    end)
  end,

  add = function(ev)
    local file = ev.data.note.path.filename
    M.run({ "git", "add", file })
  end,

  commit = function()
    ---@type string
    local msg = opts.message()
    M.run({ "git", "commit", "-m", msg })
  end,

  push = function()
    M.run({ "git", "push" })
  end,
}

local group_id = vim.api.nvim_create_augroup("obsidian-git", { clear = true })

local setup_autocmd = function(pattern, callbacks)
  local callback

  if type(callbacks) == "table" then
    callback = function(ev)
      for _, cb in ipairs(callbacks) do
        cb(ev)
      end
    end
  else
    callback = callbacks
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = pattern,
    callback = callback,
    group = group_id,
  })
end

function M.enable(enable)
  if enable then
    setup_autocmd("ObsidianEnterNote", opts.pull)
    setup_autocmd("ObsidianPostWriteNote", { opts.add, opts.commit, opts.push })
  end
end

return M
