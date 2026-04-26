return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Apply cmp-nvim-lsp capabilities to ALL servers
    vim.lsp.config('*', {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })

    -- Configure individual servers (merges with defaults from nvim-lspconfig's lsp/ directory)
    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })

    vim.lsp.config('clangd', {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = { group = "module" },
            prefix = "self",
          },
          cargo = {
            buildScripts = { enable = true },
          },
          procMacro = { enable = true },
          checkOnSave = true,
          check = {
            command = "check",
          },
          diagnostics = {
            enable = true,
          },
          inlayHints = {
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true },
            closureReturnTypeHints = { enable = "with_block" },
            lifetimeElisionHints = { enable = "skip_trivial" },
            parameterHints = { enable = true },
            typeHints = { enable = true },
          },
        },
      },
    })

    -- nil_ls uses defaults from nvim-lspconfig (cmd = {'nil'}, filetypes = {'nix'})

    -- Enable all desired servers (silently skips if binary not on PATH)
    vim.lsp.enable({ 'pyright', 'clangd', 'rust_analyzer', 'nil_ls' })

    -- Set up keybindings when LSP attaches
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Enable inlay hints (VSCode-like type/parameter hints)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/inlayHint') then
          vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>lf', function()
          vim.lsp.buf.format({ async = true })
        end, { buffer = ev.buf, silent = true, desc = "LSP Format" })
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      end,
    })

    -- Configure diagnostics display
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
        source = "if_many",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    })
  end,
}
