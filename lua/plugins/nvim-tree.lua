return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 40,
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
