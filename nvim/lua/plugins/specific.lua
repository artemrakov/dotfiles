local M = {}

function M.run(use)
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use 'tpope/vim-rails'
  --     use 'slim-template/vim-slim'
  -- use { 'mfussenegger/nvim-jdtls' }

  -- use 'tpope/vim-dispatch'
  -- use 'clojure-vim/vim-jack-in'
  -- use 'radenling/vim-dispatch-neovim'
  -- use 'Olical/conjure'
  -- use 'guns/vim-sexp'
  -- use 'tpope/vim-sexp-mappings-for-regular-people'
  -- use 'clojure-vim/clojure.vim'
  -- use 'tpope/vim-unimpaired'

  use {
    "mhanberg/elixir.nvim",
    requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      local general_on_attach = require('lsp.on_attach')
      local serverConfig = require('lsp.servers.elixirls')(general_on_attach)

      require("elixir").setup({
        on_attach = serverConfig.on_attach
      })
    end
  }


  use {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      local general_on_attach = require('lsp.on_attach')
      local serverConfig = require('lsp.servers.rust_analyzer')(general_on_attach)

      rt.setup({
        server = {
          on_attach = serverConfig.on_attach
        },
      })
    end
  }
end

return M
