local function build(name, cmds)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      if ev.data.kind == "install" and ev.data.spec.name == name then
        print("running build for " .. name)
        vim.system(
          cmds,
          {
            cwd = ev.data.path,
            stderr = function(err, data)
              if err then
                print(err, vim.log.levels.ERROR)
              end
              if data then
                print(vim.trim(data))
              end
            end,
          },
          vim.schedule_wrap(function(out)
            assert(out.code == 0, "failed to build")
          end)
        )
      end
    end,
  })
end

local function branch(name, branch_name)
  local pkgs = vim.pack.get()

  local pkg = vim.iter(pkgs):find(function(pkg)
    if pkg.spec.name == name then
      return true
    end
  end)
  local path = pkg.path
  local out = vim
    .system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, {
      cwd = path,
    })
    :wait()
  assert(out.code == 0, "failed to get current branch")
  local cur_branch = vim.trim(out.stdout)
  if cur_branch ~= branch_name then
    vim.system({ "git", "switch", branch_name }, {
      cwd = path,
    }, function(obj)
      assert(obj.code == 0, "failed to get current branch")
    end)
  end
end

return {
  branch = branch,
  build = build,
}
