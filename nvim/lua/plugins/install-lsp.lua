local M = {}

function M.run(use)

  use 'mfussenegger/nvim-jdtls'

  use {
    'williamboman/mason-lspconfig.nvim',
     requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason').setup()
      require("mason-lspconfig").setup({
        local lsp = require('lsp')
        ensure_installed = lsp.servers
      })
    end
  }

  -- use {
  --   'neovim/nvim-lspconfig',
  --   requires = {
  --     'williamboman/mason.nvim',
  --     'williamboman/mason-lspconfig.nvim',
  --     'kosayoda/nvim-lightbulb',
  --   },
  --   config = function()
  -- }
  use { "WhoIsSethDaniel/mason-tool-installer.nvim", requires = { "williamboman/mason.nvim" },
    config = function()
      local tools = require('lsp.servers.nullls')
      require 'mason-tool-installer'.setup {
        ensure_installed = tools.list,
        run_on_start = true,
        start_delay = 2000, -- 3 second delay
      }
    end }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
  }
end

return M
