local function play_podcast()
  local link = require("feed").get_entry().link
  if link:find("mp3") then
    vim.ui.open(link)
  else
    vim.notify("not a podcast episode")
  end
end

-- TODO: add to docs
local function open_zathura()
  local _, id = require("feed").get_entry()
  local db = require("feed").db
  vim.fn.jobstart(
    ("pandoc %s -f html -t pdf --pdf-engine  xelatex -o - | zathura -"):format(tostring(db.dir / "data" / id))
  )
end

local function show_in_w3m()
  if not vim.fn.executable("w3m") then
    vim.notify("w3m not installed")
    return
  end
  local link = require("feed").get_entry().link
  local w3m = require("feed.ui.window").new({
    relative = "editor",
    col = math.floor(vim.o.columns * 0.1),
    row = math.floor(vim.o.lines * 0.1),
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    border = "rounded",
    style = "minimal",
    title = "Feed w3m",
    zindex = 10,
  })
  vim.keymap.set({ "n", "t" }, "q", "<cmd>q<cr>", { silent = true, buffer = w3m.buf })
  vim.fn.jobstart({ "w3m", link }, { term = true })
  vim.cmd("startinsert")
end

local function icon_tags(id, db)
  -- local icons = {
  --    news = "📰",
  --    tech = "💻",
  --    movies = "🎬",
  --    games = "🎮",
  --    music = "🎵",
  --    podcast = "🎧",
  --    books = "📚",
  --    unread = "🆕",
  --    read = "✅",
  --    junk = "🚮",
  --    star = "⭐",
  -- }
  local icons = {
    news = " ",
    tech = " ",
    movies = "󱜂 ",
    games = "󱤙 ",
    music = " ",
    podcast = "󰦔 ",
    books = "󱚛 ",
    unread = "󱥼 ",
    read = "󰑇 ",
    junk = " ",
    star = "󰓒 ",
  }

  local get_icon = function(name)
    if icons[name] then
      return icons[name]
    end
    local has_mini, MiniIcons = pcall(require, "mini.icons")
    if has_mini then
      local icon = MiniIcons.get("filetype", name)
      if icon then
        return icon .. " "
      end
    end
    return name
  end

  local tags = vim.tbl_map(get_icon, db:get_tags(id))

  table.sort(tags)

  return "[" .. table.concat(tags, " ") .. "]"
end

-- local og_color
-- local og_background
--
-- vim.api.nvim_create_autocmd("User", {
--    pattern = "FeedShowIndex",
--    callback = function()
--       if not og_color then
--          og_color = vim.g.colors_name
--       end
--       if not og_background then
--          og_background = vim.opt.background
--       end
--       vim.cmd.colorscheme("e-ink")
--       vim.opt.background = "dark"
--    end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
--    pattern = "FeedQuitIndex",
--    callback = function()
--       vim.cmd.colorscheme(og_color)
--       vim.opt.background = og_background
--    end,
-- })

-- return {
--   dir = "~/Plugins/feed.nvim",
--   dev = true,
--   cmd = "Feed",
--   cond = false,
--   keys = {
--     {
--       "<leader>Fs",
--       "<cmd>Feed search<cr>",
--       desc = "Feed search",
--     },
--     {
--       "<leader>Ff",
--       "<cmd>Feed<cr>",
--       desc = "Feed",
--     },
--   },
require "feed".setup {
  web = {
    open_browser = true,
  },
  zen = {
    enabled = false,
  },
  date = {
    locale = "zh_CN.utf8",
  },
  keys = {
    index = {
      { "p", play_podcast },
      { "w", show_in_w3m },
      { "z", open_zathura },
    },
  },
  feeds = require("feeds"),
  rsshub = {
    instance = "127.0.0.1:1200",
  },
  protocol = {
    backend = "local",
    ttrss = {
      url = "http://127.0.0.1:8280/tt-rss/api/",
      user = "n451",
      password = "123",
    },
    freshrss = {
      url = "http://127.0.0.1:8080/api/greader.php/",
      user = "n451",
      password = "6295141.3",
      auth = "n451/1e4d0d767d8647e7caa5c89ad5ae35f7fb8ccc45",
    },
  },
  -- progress = {
  --   backend = "fidget",
  -- },
  ui = {
    order = { "date", "feed", "tags", "title", "reading_time" },
    reading_time = {
      color = "Comment",
      format = function(id, db)
        local content = db:get(id):gsub("%s+", " ")
        local words = vim.fn.strchars(content)
        local time = math.ceil(words / 1000)
        return string.format("(%s min)", time)
      end,
    },
    tags = {
      color = "String",
      format = icon_tags,
    },
  },
  picker = {
    tags = {
      format = icon_tags,
    },
  },
}
-- }
