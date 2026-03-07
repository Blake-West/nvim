local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
  { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
  { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
  { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
  { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  { "<leader>E", ":NvimTreeFocus<CR>", desc = "Focus File Explorer" },
  { "jk", "<Esc>", desc = "Exit Insert Mode", mode = "i" },
  { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Select next buffer", mode = 'n' },
  { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Select previous buffer", mode = 'n' },
})

-- Terminal mappings
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { noremap = true })

-- Multiple named terminal instances (leader+t1 through leader+t5)
local ok, Terminal = pcall(function()
  return require("toggleterm.terminal").Terminal
end)
if ok and Terminal then
  for i = 1, 5 do
    local term = Terminal:new({
      count = i,
      direction = "float",
      float_opts = { border = "curved" },
    })
    vim.keymap.set({ "n", "t" }, "<leader>t" .. i, function() term:toggle() end,
      { noremap = true, silent = true, desc = "Toggle Terminal " .. i })
  end
end
