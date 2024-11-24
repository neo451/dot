return {
	{
		"neo451/feed.nvim",
		cmd = "Feed",
		dir = "~/Plugins/feed.nvim/",
		opts = function()
			local feed = require("feed")

			local function play_podcast()
				local link = feed.get_entry().link
				if link and link:find("mp3") then
					local s, e = link:find("mp3")
					vim.system({ "vlc.exe", link:sub(1, e) })
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
				local db = require("feed.db") -- TODO: expose db
				local feed_name = feed.get_entry().feed
				for k, v in pairs(db.feeds) do
					if v.title == feed_name then
						vim.ui.open(k)
						return
					end
				end
			end

			local function open_html()
				local db = require("feed.db") -- TODO: expose db
				local _, id = feed.get_entry()
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(db.dir .. "/data/" .. id))
				vim.keymap.set("n", "q", "<cmd>bd<cr>", { buffer = buf })
				vim.api.nvim_set_option_value("filetype", "html", { buf = buf })
				vim.api.nvim_set_current_buf(buf)
				vim.lsp.buf.format()
			end

			local function open_db_dir()
				local config = require("feed.config")
				vim.cmd.Oil(config.db_dir)
			end

			local function blowup()
				local db = require("feed.db") -- TODO: expose db
				db:blowup()
			end

			feed.register_command("blowup", "blowup db", { all = true }, blowup)
			feed.register_command("open_xml", "open the feed's xml", { index = true }, open_xml, "x")
			feed.register_command("open_db_dir", "open the db", { index = true }, open_db_dir, "d")
			feed.register_command("open_html", "open_html", { entry = true }, open_html)
			feed.register_command("play_podcast", "play podcast", { index = true }, play_podcast, "p")

			feed.setup({
				-- TODO: colorscheme = "morning",
				feeds = {
					{ "https://plink.anyfeeder.com/time", tags = { "news" } },
					{ "https://plink.anyfeeder.com/appinn", tags = { "app" } },
					-- { "http://blog.codingnow.com/atom.xml", tags = { "prob" } },
					"https://plink.anyfeeder.com/bbc/uk",
					"https://plink.anyfeeder.com/weixin/ikanlixiang",
					"http://shapeof.com/feed.json",
					{ "https://andrewkelley.me/rss.xml", tags = { "zig" } },
					{ "https://archlinux.org/feeds/news/", tags = { "linux" } },
					"https://neovim.io/news.xml",
					"https://www.ruanyifeng.com/blog/atom.xml",
					-- "https://rsshub.app/github/trending/daily/lua/en",
					{ "https://pod.link/developer-voices.rss", tags = { "pod" } },
					{ "https://listen.teamcoco.com/EVrx2sp-?id=EVrx2sp-&platform=rss", tags = { "pod" } },
				},
				progress = "mini",
			})
		end,
		keys = {
			{ "<leader>ff", "<cmd>Feed<cr>", desc = "Feed" },
			{ "<leader>fi", "<cmd>Feed show_index<cr>", desc = "Feed show_index" },
			{ "<leader>fu", "<cmd>Feed update<cr>", desc = "Feed update" },
			{ "<leader>fg", "<cmd>Feed search<cr>", desc = "Feed search" },
		},
	},
}
