return {
  cmd = { "rime_ls" },
  filetypes = { "markdown" },
  init_options = {
    enabled = true,
    shared_data_dir = os.getenv("RIME_DATA_DIR"),
    -- shared_data_dir = "/usr/share/rime-data",
    user_data_dir = "~/.local/share/rime-ls",
    log_dir = "/tmp",
    max_candidates = 9,
    paging_characters = { ",", ".", "-", "=" },
    trigger_characters = {},
    schema_trigger_character = "&",
    max_tokens = 0,
    always_incomplete = true,
    preselect_first = false,
    show_filter_text_in_label = false,
    long_filter_text = true,
  },
}
