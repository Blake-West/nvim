local key_map = vim.api.nvim_set_keymap
local key_map_opts = { noremap = true, silent = true }

key_map('i', "jk", "<Esc>", key_map_opts)

-- Treesitter keybinds
local builtin = require("telescope.builtin")

vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', "<leader>fg", builtin.live_grep, {})
vim.keymap.set('n', "<leader>fb", builtin.buffers, {})
vim.keymap.set('n', "<leader>fh", builtin.help_tags, {})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, key_map_opts)
