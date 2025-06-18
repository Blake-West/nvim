return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      view = {
        width = 40,
        preserve_window_proportions = true,
      },
      renderer = {
        icons = {
          show = {
            modified = true,
          },
        },
        highlight_modified = "all"
      },
    }



  end,
}
