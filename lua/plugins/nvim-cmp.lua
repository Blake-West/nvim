return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
    "hrsh7th/cmp-buffer",       -- Buffer completion source
    "hrsh7th/cmp-path",         -- Path completion source
  },
  config = function()
    local cmp = require('cmp')
    
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),           -- Scroll backwards on docstring preview
        ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- Scroll forwards on docstring preview
        ['<C-Space>'] = cmp.mapping.complete(),            -- Forcibily start completion 
        ['<C-e>'] = cmp.mapping.abort(),                   -- Abort the autocompletion selection
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter selects the highlighted autocomplete
        ['<Tab>'] = cmp.mapping.select_next_item(),        -- Next autocomplete item
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Previous autocomplete item
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
