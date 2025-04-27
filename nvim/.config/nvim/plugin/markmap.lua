vim.api.nvim_create_user_command("Markmap", function()
  local file_path = vim.fn.expand("%:p")

  local markmap_cli_path = "/home/n451/.local/share/nvim/lazy/markmap.nvim/node_modules/markmap-cli/bin/cli.js"

  vim.system({ markmap_cli_path, file_path })
end, {})
