return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Setup options here in future
  },

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}



