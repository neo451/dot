return {
   cmd = { "nixd" },
   filetypes = { "nix" },
   capabilities = require("blink.cmp").get_lsp_capabilities(),
   root_markers = {
      "flake.nix",
      ".git",
   },
}
