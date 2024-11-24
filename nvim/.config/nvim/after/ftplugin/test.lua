local capabilities = vim.lsp.protocol.make_client_capabilities()
local cap = require("blink.cmp").get_lsp_capabilities(capabilities)
vim.print(cap)
--
-- vim.print(cap)
