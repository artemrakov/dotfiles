local M = {}

function M.run(use)
  servers = {
    'tsserver',
    'eslint',
    'solargraph',
    'sumneko_lua',
    'elixirls'
  }

  use 'mfussenegger/nvim-jdtls'

  use {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers
      })
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'kosayoda/nvim-lightbulb',
    },
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = require('plugins.on-attach-lsp')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- local lsp_flags = {
      --   -- This is the default in Nvim 0.7+
      --   debounce_text_changes = 150,
      -- }
      -- require('lspconfig')['tsserver'].setup{
      --   on_attach = on_attach,
      --   flags = lsp_flags,
      -- }

      local lspconfig = require('lspconfig')
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- Check if the config is already defined (useful when reloading this file)
      local configs = require 'lspconfig.configs'
      if not configs.barium then
        configs.barium = {
          default_config = {
            cmd = { 'barium' };
            filetypes = { 'brazil-config' };
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname)
            end;
            settings = {};
          };
        }
      end

      lspconfig.barium.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
  }

  require("null-ls").setup({
    sources = {
      require("null-ls").builtins.formatting.markdownlint, -- markdown formatting
      require("null-ls").builtins.formatting.npm_groovy_lint,
    },
  })
end

return M
