-- Keyboard users
vim.keymap.set("n", "<RightMouse>", function()
	require("menu").open("default")
end, {})
