return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("lspconfig").pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnositicMode = "workspace"
          }
        }
      }
    })
    
    -- Add clangd configuration for C/C++
    require('lspconfig').clangd.setup({
      capabilities = capabilities,
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
        fallbackFlags = {
          "-I" .. vim.fn.getcwd() .. "/include",
          "-I" .. vim.fn.getcwd() .. "/src",
          "-std=c++23",  -- or whatever C++ standard you use
        },
      },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })

    -- Add Rust configuration
    require('lspconfig').rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
          checkOnSave = {
            command = "clippy",  -- Use clippy for linting
          },
          inlayHints = {
            enable = true,
            showParameterNames = true,
            parameterHintsPrefix = "<- ",
            otherHintsPrefix = "=> ",
          },
        }
      }
    })

    -- Set up keybindings when LSP attaches
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        
        -- Go to definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        
        -- Show hover information
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        
        -- Find references
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        
        -- Rename symbol
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        
        -- Code actions
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        
        -- Format document
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
        
        -- Show line diagnostics
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        
        -- Go to next diagnostic
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        
        -- Go to previous diagnostic
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      end,
    })

    -- Configure Diagnostics Display
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
  end
}
