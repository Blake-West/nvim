local wk = require("which-key")
local builtin = require("telescope.builtin")

wk.add({
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>ff", builtin.find_files, desc = "Find Files" },
  { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
  { "<leader>fb", builtin.buffers, desc = "Buffers" },
  { "<leader>fh", builtin.help_tags, desc = "Help Tags" },
  { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  { "<leader>E", ":NvimTreeFocus<CR>", desc = "Focus File Explorer" },
  { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "jk", "<Esc>", desc = "Exit Insert Mode", mode = "i" },

  {"<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Select next buffer", mode = 'n'},
  {"<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Select previous buffer", mode = 'n'},

})
