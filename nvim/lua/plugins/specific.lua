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
end

return M
