local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end)
end

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "[[", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "]]", function()
	harpoon:list():next()
end)

-- -- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
-- 	local file_paths = {}
-- 	for _, item in ipairs(harpoon_files.items) do
-- 		table.insert(file_paths, item.value)
-- 	end
--
-- 	require("telescope.pickers")
-- 		.new({}, {
-- 			prompt_title = "Harpoon",
-- 			finder = require("telescope.finders").new_table({
-- 				results = file_paths,
-- 			}),
-- 			previewer = conf.file_previewer({}),
-- 			sorter = conf.generic_sorter({}),
-- 		})
-- 		:find()
-- end

vim.keymap.set("n", "<leader>ha", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
	-- toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
