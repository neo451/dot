return {
   { 'saghen/blink.compat' },
   {

      "saghen/blink.cmp",
      lazy = false, -- lazy loading handled internally
      -- optional: provides snippets for the snippet source
      dependencies = {
         "rafamadriz/friendly-snippets",
         'hrsh7th/cmp-emoji',
      },

      -- use a release tag to download pre-built binaries
      version = "v0.*",
      -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
         -- 'default' for mappings similar to built-in completion
         -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
         -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
         -- see the "default configuration" section below for full documentation on how to define
         -- your own keymap.
         keymap = { preset = "default" },
         sources = {
            -- add lazydev to your completion providers
            completion = {
               enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev", "emoji" },
            },
            providers = {
               -- dont show LuaLS require statements when lazydev has items
               lsp = { fallback_for = { "lazydev" } },
               lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
               emoji = {
                  name = 'emoji', -- IMPORTANT: use the same name as you would for nvim-cmp
                  module = 'blink.compat.source',

                  -- all blink.cmp source config options work as normal:
                  score_offset = -3,

                  -- opts = {
                  --    -- this table is passed directly to the proxied completion source
                  --    -- as the `option` field in nvim-cmp's source config
                  --
                  --    -- this is an option from cmp-digraphs
                  --    cache_digraphs_on_start = true,
                  -- }
               }
            },
         },

         highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
         },
         -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- adjusts spacing to ensure icons are aligned
         nerd_font_variant = "mono",

         -- experimental auto-brackets support
         accept = { auto_brackets = { enabled = true } },

         -- experimental signature help support
         trigger = { signature_help = { enabled = true } },
      },
   }
}
