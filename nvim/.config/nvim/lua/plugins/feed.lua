local ok, feed = pcall(require, "feed")
if not ok then
	return
end

local db = require("feed.db") -- TODO: expose db

local function play_podcast()
	local link = feed.get_entry().link
	if link:find("mp3") then
		vim.system({ "vlc.exe", link })
	else
		vim.notify("not a podcast episode")
	end
end

local function show_in_w3m()
	local link = feed.get_entry().link
	ok, _ = pcall(vim.cmd.W3m, link)
	if not ok then
		vim.notify("[feed.nvim]: need w3m.vim installed")
	end
end

local function show_in_glow()
	local _, id = feed.get_entry()
	vim.system({ "glow", db.dir .. "/data/" .. id })
end

local function open_xml()
	local feed_name = feed.get_entry().feed
	for k, v in pairs(db.feeds) do
		if v.title == feed_name then
			vim.ui.open(k)
			return
		end
	end
end

feed.setup({
	db_dir = "~/new_db",
	feeds = {
		{ "https://plink.anyfeeder.com/time", tags = { "news", "general" } },
		{ "https://plink.anyfeeder.com/appinn", tags = { "app" } },
		"https://plink.anyfeeder.com/bbc/uk",
		"https://plink.anyfeeder.com/weixin/ikanlixiang",
		"http://shapeof.com/feed.json",
		"https://andrewkelley.me/rss.xml",
		"https://neovim.io/news.xml",
		"https://www.ruanyifeng.com/blog/atom.xml",
		{ "http://blog.codingnow.com/atom.xml", tags = { "prob" } },
	},
	progress = "native",
	on_attach = function(buf)
		-- TODO: weird ...
		if buf.index then
			vim.keymap.set("n", "x", open_xml, { buffer = buf.index })
		end
		if buf.entry then
			vim.keymap.set("n", "x", open_xml, { buffer = buf.entry })
		end
	end,
})
