return {
   "nvim-orgmode/orgmode",
   event = "VeryLazy",
   enabled = false,
   ft = { "org" },
   opts = {
      org_agenda_files = "~/org/**/*",
      org_default_notes_file = "~/org/refile.org",
   },
}
