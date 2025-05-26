---@param cmd string[]
---@param err string
local function system(cmd, err)
  local proc = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    error("__ignore__")
  end
  return vim.split(vim.trim(proc), "\n")
end

local uv = vim.uv

local remote_patterns = {
  { "^(https?://.*)%.git$", "%1" },
  { "^git@(.+):(.+)%.git$", "https://%1/%2" },
  { "^git@(.+):(.+)$", "https://%1/%2" },
  { "^git@(.+)/(.+)$", "https://%1/%2" },
  { "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
  { "^ssh://git@(.*)$", "https://%1" },
  { "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
  { "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
  { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
  { "^https://%w*@(.*)", "https://%1" },
  { "^git@(.*)", "https://%1" },
  { ":%d+", "" },
  { "%.git$", "" },
}

local url_patterns = {
  ["github%.com"] = {
    branch = "/tree/{branch}",
    file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
    permalink = "/blob/{commit}/{file}#L{line_start}-L{line_end}",
    commit = "/commit/{commit}",
  },
  ["gitlab%.com"] = {
    branch = "/-/tree/{branch}",
    file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
    permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
    commit = "/-/commit/{commit}",
  },
  ["bitbucket%.org"] = {
    branch = "/src/{branch}",
    file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
    permalink = "/src/{commit}/{file}#lines-{line_start}-L{line_end}",
    commit = "/commits/{commit}",
  },
  ["git.sr.ht"] = {
    branch = "/tree/{branch}",
    file = "/tree/{branch}/item/{file}",
    permalink = "/tree/{commit}/item/{file}#L{line_start}",
    commit = "/commit/{commit}",
  },
}

---@param remote string
local function get_repo(remote)
  local ret = remote
  for _, pattern in ipairs(remote_patterns) do
    ret = ret:gsub(pattern[1], pattern[2]) --[[@as string]]
  end
  return ret:find("https://") == 1 and ret or ("https://%s"):format(ret)
end

local function list_repos()
  local repo = {}
  local cwd = uv.cwd()

  for _, line in ipairs(system({ "git", "-C", cwd, "remote", "-v" }, "Failed to get git remotes")) do
    local name, remote = line:match("(%S+)%s+(%S+)%s+%(fetch%)")
    if name and remote then
      repo[#repo + 1] = get_repo(remote)
    end
  end
  return repo
end

---@param repo string
---@param fields snacks.gitbrowse.Fields
local function get_url(repo, fields)
  for remote, patterns in pairs(url_patterns) do
    if repo:find(remote) then
      local pattern = patterns[opts.what]
      if type(pattern) == "string" then
        return repo .. pattern:gsub("(%b{})", function(key)
          return fields[key:sub(2, -2)] or key
        end)
      elseif type(pattern) == "function" then
        return repo .. pattern(fields)
      end
    end
  end
  return repo
end

local function get_url() end

dd(list_repos())
