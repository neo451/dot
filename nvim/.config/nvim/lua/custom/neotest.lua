return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"MisanthropicBit/neotest-busted",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					-- require("neotest-golang"),
					require("neotest-busted")({
						busted_command = "/usr/local/bin/busted",
						-- Extra arguments to busted
						-- 	-- busted_args = { "--shuffle-files" },
						-- 	-- -- List of paths to add to package.path in neovim before running busted
						-- 	-- busted_paths = { "my/custom/path/?.lua" },
						-- 	-- -- List of paths to add to package.cpath in neovim before running busted
						-- 	-- busted_cpaths = { "my/custom/path/?.so" },
						-- 	-- Custom config to load via -u to set up testing.
						-- 	-- If nil, will look for a 'minimal_init.lua' file
						-- 	-- minimal_init = "custom_init.lua",
						-- 	-- Only use a luarocks installation in the project's directory. If
						-- 	-- true, installations in $HOME and global installations will be
						-- 	-- ignored. Useful for isolating the test environment
						-- 	-- local_luarocks_only = true,
						-- 	-- Find parametric tests
						-- 	-- parametric_test_discovery = false,
					}),
				},
			})
		end,
	},
}
