local obj = vim.system({ "rg", "vim.highlight" }, { text = true }):wait()

Pr(obj.stdout)
