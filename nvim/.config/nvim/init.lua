require("config.keymaps")
require("config.options")
require("config.lazy")
require("config.autocmds")

pp = function(a)
   print(vim.inspect(a))
end

vim.filetype.add({
   extension = {
      modal = "modal",
      sc = "supercollider",
      scd = "supercollider",
   },
})

-- require("nvim-web-devicons").set_icon_by_filetype({ norg = "md" })

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.modal = {
--    install_info = {
--       url = "~/modal/tree-sitter-modal", -- local path or git repo
--       files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
--       -- generate_requires_npm = true, -- if stand-alone parser without npm dependencies
--       -- requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
--    },
--    -- filetype = "modal", -- if filetype does not match the parser name
-- }
-- vim.treesitter.language.register("modal", "modal")
--
-- -- vim.filetype.add({
-- --    tidal = "tidal",
-- -- })
