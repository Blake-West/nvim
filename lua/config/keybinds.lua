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
-- Terminal mappings
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], {noremap = true})

-- Multiple named terminal instances (leader+t1 through leader+t5)
local Terminal = require("toggleterm.terminal").Terminal

-- Create 5 different named terminals
for i = 1, 5 do
  local term = Terminal:new({ 
    count = i,
    direction = "float",
    float_opts = {
      border = "curved",
    }
  })
  
  -- Set keybinding for each terminal
  vim.keymap.set({"n", "t"}, "<leader>t"..i, function() term:toggle() end, {noremap = true, silent = true, desc = "Toggle Terminal "..i})
end
