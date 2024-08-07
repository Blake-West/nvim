print("Here sourcing keybinds")
local key_map = vim.api.nvim_set_keymap
local key_map_opts = { noremap = true, silent = true }

local vopt = vim.opt

key_map('i', "jk", "<Esc>", key_map_opts)


vim.opt.number = true



