-- require("rime.nvim").setup(nil, {})
-- vim.keymap.set("i", "<C-^>", require("rime.nvim").toggle)

local rime_ls_filetypes = { "markdown", "vimwiki", "norg" }
local function is_rime_entry(entry)
	return vim.tbl_get(entry, "source", "name") == "nvim_lsp"
		and vim.tbl_get(entry, "source", "source", "client", "name") == "rime_ls"
end
local cmp = require("cmp")
local function auto_upload_rime()
	if not cmp.visible() then
		return
	end
	local entries = cmp.core.view:get_entries()
	if entries == nil or #entries == 0 then
		return
	end
	local first_entry = cmp.get_selected_entry()
	if first_entry == nil then
		first_entry = cmp.core.view:get_first_entry()
	end
	if first_entry ~= nil and is_rime_entry(first_entry) then
		local rime_ls_entries_cnt = 0
		for _, entry in ipairs(entries) do
			if is_rime_entry(entry) then
				rime_ls_entries_cnt = rime_ls_entries_cnt + 1
				if rime_ls_entries_cnt == 2 then
					break
				end
			end
		end
		if rime_ls_entries_cnt == 1 then
			cmp.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			})
		end
	end
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = rime_ls_filetypes,
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "i", "<Space>", "", {
			noremap = true,
			silent = false,
			callback = function()
				local entries = cmp.core.view:get_entries()
				if #entries <= 1 then
					vim.fn.feedkeys(" ", "n")
				elseif #entries > 1 then
					vim.fn.feedkeys("1", "n")
					vim.schedule(auto_upload_rime)
				end
			end,
		})
		for numkey = 1, 9 do
			local numkey_str = tostring(numkey)
			vim.api.nvim_buf_set_keymap(0, "i", numkey_str, "", {
				noremap = true,
				silent = false,
				callback = function()
					vim.fn.feedkeys(numkey_str, "n")
					vim.schedule(auto_upload_rime)
				end,
			})
			vim.api.nvim_buf_set_keymap(0, "s", numkey_str, "", {
				noremap = true,
				silent = false,
				callback = function()
					vim.fn.feedkeys(numkey_str, "n")
					vim.schedule(auto_upload_rime)
				end,
			})
		end
	end,
})
