local telescope = require("telescope")

telescope.setup({
	extensions = {
		fzf = {},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},

	defaults = {
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(filepath)
					local image_extensions = { "png", "jpg" } -- Supported image formats
					local split_path = vim.split(filepath:lower(), ".", { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. "\r\n")
						end
					end
					vim.fn.jobstart({
						"catimg",
						filepath, -- Terminal image viewer command
					}, { on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
				end
			end,
		},
	},
})

local map = vim.keymap.set

local builtin = require("telescope.builtin")

map("n", "<leader>s", "", { desc = "telscope" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sb", builtin.builtin, { desc = "[S]earch [B]uiltin" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find)
map("n", "<leader>sn", function()
	builtin.find_files({ cwd = "/home/n451/dot/nvim/.config/nvim/" })
end, { desc = "[S]earch [N]eovim files" })

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file-browser")
