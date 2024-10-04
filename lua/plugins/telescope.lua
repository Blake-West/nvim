return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('fzf')
  end
}
