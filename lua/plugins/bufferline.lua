return {
  "mrjones2014/winbarbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup{
      auto_hide = false,
      icons = true,
      icon_custom_colors = false,


      icon_modified = '●',
      disabled_filetypes = {
        'NvimTree',
        'neo-tree', 
        'alpha',
        'dashboard',
        'help',
        'toggleterm',
        'Trouble',
        'qf'
      },

      disabled_buftypes = {
        'terminal',
        'nofile',
        'prompt'
      },
    }
  end,
}


--return {
--  "akinsho/bufferline.nvim", 
--  version = '*',
--  dependencies = "nvim-tree/nvim-web-devicons",
--  event = "VeryLazy",
--  config = function()
--    vim.opt.termguicolors = true
--    require("bufferline").setup{
--      options = {
--        offsets = {
--          {
--            filetype = "NvimTree",
--            text = "",
--            highlight = "Directory",
--          }
--        }
--      }
--    }
--  end,
--}



