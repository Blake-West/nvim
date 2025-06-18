return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_supress_dirs = { "~/", "~/Downloads", '/' },
      auto_session_use_git_branch = false,


      auto_save_enabled = true,

      auto_restore_enabled = true,


      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      }
    })
  end,
}
