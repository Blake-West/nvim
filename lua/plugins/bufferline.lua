--return {
--  "mrjones2014/winbarbar.nvim",
--  dependencies = { "nvim-tree/nvim-web-devicons" },
--  config = function()
--    require("bufferline").setup{
--      auto_hide = false,
--      icons = true,
--      icon_custom_colors = false,
--
--
--      icon_modified = '●',
--      disabled_filetypes = {
--        'NvimTree',
--        'neo-tree', 
--        'alpha',
--        'dashboard',
--        'help',
--        'toggleterm',
--        'Trouble',
--        'qf'
--      },
--
--      disabled_buftypes = {
--        'terminal',
--        'nofile',
--        'prompt'
--      },
--    }
--  end,
--}


-- Smart buffer close that preserves window layout (keeps nvim-tree split intact)
local function close_buffer(bufnr)
  bufnr = bufnr or 0
  if bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end

  -- Get all listed buffers excluding the one we're closing
  local bufs = vim.tbl_filter(function(b)
    return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted and b ~= bufnr
  end, vim.api.nvim_list_bufs())

  -- For every window showing this buffer, switch it to another buffer
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      if #bufs > 0 then
        vim.api.nvim_win_set_buf(win, bufs[#bufs])
      else
        vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(true, false))
      end
    end
  end

  -- Now safely delete the buffer without affecting windows
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_delete(bufnr, { force = false })
  end
end

-- Make it globally accessible for keybinds
vim.g._close_buffer = nil  -- placeholder; we store the function on a module
_G.close_buffer = close_buffer

local function close_all_buffers()
  local bufs = vim.tbl_filter(function(b)
    return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())

  -- Create a fresh empty buffer first
  local empty = vim.api.nvim_create_buf(true, false)

  -- Switch all non-nvimtree windows to the empty buffer
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype ~= "NvimTree" then
      vim.api.nvim_win_set_buf(win, empty)
    end
  end

  -- Delete all the old buffers
  for _, b in ipairs(bufs) do
    if vim.api.nvim_buf_is_valid(b) and b ~= empty then
      vim.api.nvim_buf_delete(b, { force = false })
    end
  end
end

_G.close_all_buffers = close_all_buffers

-- Override :bd to use the smart close
vim.api.nvim_create_user_command("Bd", function() close_buffer() end, {})
vim.api.nvim_create_user_command("Bda", function() close_all_buffers() end, {})
vim.cmd("cabbrev bd Bd")
vim.cmd("cabbrev bdelete Bd")

return {
  "akinsho/bufferline.nvim",
  version = '*',
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup{
      options = {
        close_command = function(bufnr) close_buffer(bufnr) end,
        right_mouse_command = function(bufnr) close_buffer(bufnr) end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            highlight = "Directory",
          }
        }
      }
    }
  end,
}



