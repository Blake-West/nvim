local vo = vim.opt

vo.backup = false -- Disable backup files
vo.number = true -- Enable numbering on the left side
vo.tabstop = 2 -- 2 Spaces instead of <Tab>
vo.shiftwidth = 2 -- Spaces to use for auto indent
vo.expandtab = true -- Convert tabs to space characters
vo.smartindent = true -- Reason to make indent smark? Why not default?
vo.scrolloff = 5 -- Lines to buffer cursor vertically before scrolling
vo.sidescrolloff = 5 -- Lines to buffer cursor horizontally before scrolling
vo.wrap = false -- Don't wrap the line, let it be lobg
vo.undofile = true -- Persistant undos between files
vo.updatetime = 300 -- Polling rate essentially
