vim.g.feed_config = {
	feeds = {
		-- "https://rsshub.app/apple/apps/update/us/id408709785",
		-- "https://rsshub.app/epicgames/freegames",
		-- "https://plink.anyfeeder.com/zaobao/realtime/china",
		-- "https://www.zhihu.com/rss",
		-- "https://feeds.feedburner.com/ruanyifeng",
		"https://sspai.com/feed",
		-- "https://rsshub.app/infzm/2",
		"https://rsshub.app/weibo/search/hot",
	},
	-- layout = {},
	win_options = {
		conceallevel = 3,
	},
}
require("feed")
