function test(a)
  vim.validate("a", a, { "string" })
  -- error("test")
end

-- TODO: find full path with vim.loader

local pattern = "([/%w%.%-_][/%w%.%-_]*):(%d+)"

local function err2qf()
  local lines = vim.split(vim.v.errmsg, "\n")

  ---@type vim.quickfix.entry
  local items = vim.iter(lines):fold({}, function(acc, line)
    local filename, lnum = line:match(pattern)
    if filename then
      table.insert(acc, {
        filename = filename,
        lnum = tonumber(lnum),
      })
    end
    return acc
  end)

  vim.fn.setqflist({}, "r", {
    title = lines[1],
    items = items,
  })
  vim.cmd.copen()
end

err2qf()
