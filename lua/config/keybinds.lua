local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
  { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
  { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
  { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
  { "<leader>r", "<Cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
  { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  { "<leader>E", ":NvimTreeFocus<CR>", desc = "Focus File Explorer" },
  { "jk", "<Esc>", desc = "Exit Insert Mode", mode = "i" },
  { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Select next buffer", mode = 'n' },
  { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Select previous buffer", mode = 'n' },
  { "<leader>x", function() _G.close_buffer() end, desc = "Close current tab" },
  { "<leader>X", function() _G.close_all_buffers() end, desc = "Close all tabs" },
  { "<leader>gb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame" },
})

-- Terminal mappings
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, desc = "Move to left pane" })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, desc = "Move to pane below" })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, desc = "Move to pane above" })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, desc = "Move to right pane" })

-- Multiple terminal instances (leader+t1 through leader+t5)
for i = 1, 5 do
  vim.keymap.set("n", "<leader>t" .. i, function()
    require("toggleterm").exec("", i, 20, nil, "horizontal")
  end, { noremap = true, silent = true, desc = "Toggle Terminal " .. i })
end

-- Cycle between terminals with Tab/Shift-Tab while in terminal mode
vim.keymap.set('t', '<Tab>', function()
  local terms = require("toggleterm.terminal").get_all(true)
  if #terms <= 1 then return end
  local current = require("toggleterm.terminal").get_focused_id()
  if not current then return end
  -- Find next terminal
  for idx, term in ipairs(terms) do
    if term.id == current then
      local next_term = terms[(idx % #terms) + 1]
      next_term:open()
      return
    end
  end
end, { noremap = true, silent = true, desc = "Next Terminal" })

vim.keymap.set('t', '<S-Tab>', function()
  local terms = require("toggleterm.terminal").get_all(true)
  if #terms <= 1 then return end
  local current = require("toggleterm.terminal").get_focused_id()
  if not current then return end
  -- Find previous terminal
  for idx, term in ipairs(terms) do
    if term.id == current then
      local prev_term = terms[((idx - 2) % #terms) + 1]
      prev_term:open()
      return
    end
  end
end, { noremap = true, silent = true, desc = "Previous Terminal" })
