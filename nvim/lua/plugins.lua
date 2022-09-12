return require('packer').startup({

  function(use)
    use { 'wbthomason/packer.nvim' }

    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }

    use {
      'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter' }
    }

    use { 'LudoPinelli/comment-box.nvim' }
    use {
      'phaazon/hop.nvim',
      config = function()
        require 'hop'.setup()
      end
    }

    use {
      'TimUntersberger/neogit',
      config = function()
        local neogit = require('neogit')
        neogit.setup()
      end,
      requires = 'nvim-lua/plenary.nvim'
    }


    use { 'tpope/vim-sensible' }

    use {
      'ThePrimeagen/refactoring.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-treesitter/nvim-treesitter' }
      }
    }

    use {
      'nvim-zh/auto-save.nvim',
      config = function()
        local autosave = require("auto-save")
        autosave.setup()
      end
    }


    use 'tpope/vim-sleuth'
    use 'NMAC427/guess-indent.nvim'
    -- use 'lukas-reineke/indent-blankline.nvim'
    -- use {
    --   'windwp/windline.nvim',
    --   config = function() require('wlsample.bubble').setup() end
    -- }
    use {
      'nvim-lualine/lualine.nvim',
      config = function() require('lualine').setup({
          options = {
            icons_enabled = false,
            theme = 'gruvbox-material',
            globalstatus = true,
            section_separators = { left = '', right = '' },
            component_separators = { left = '|', right = '|' },
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
          },

        })
      end
    }

    use 'tpope/vim-surround'
    use 'windwp/nvim-spectre'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'
    use 'jpalardy/vim-slime'
    use { 'ntpeters/vim-better-whitespace' }
    use 'wincent/replay'
    use 'folke/tokyonight.nvim'
    use 'gelguy/wilder.nvim'

    use 'dyng/ctrlsf.vim'
    use { 'rktjmp/lush.nvim' }
    use { 'metalelf0/jellybeans-nvim' }

    use 'AndrewRadev/splitjoin.vim'

    -- Rails
    use 'tpope/vim-rails'
    -- End
    -- Clojure

    use 'tpope/vim-dispatch'
    use 'clojure-vim/vim-jack-in'
    use 'radenling/vim-dispatch-neovim'
    use 'Olical/conjure'
    use 'guns/vim-sexp'
    use 'tpope/vim-sexp-mappings-for-regular-people'
    use 'clojure-vim/clojure.vim'

    -- End

    use { 'tpope/vim-unimpaired' }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    -- use { 'andymass/vim-matchup' }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require('telescope')

        telescope.load_extension('refactoring')
        telescope.load_extension('fzf')

        vim.api.nvim_set_keymap(
          "v",
          "<leader>rr",
          "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
          { noremap = true }
        )

        telescope.setup {
          defaults = {
            sorting_strategy = "ascending",
            mappings = {
              i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
              },
            },
          },
          pickers = {
            buffers = {
              ignore_current_buffer = true,
              sort_mru = true
            }
          },
        }
      end,
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
      'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup({
          signs = {
            add = { hl = 'GitGutterAdd', text = '+' },
            change = { hl = 'GitGutterChange', text = '~' },
            delete = { hl = 'GitGutterDelete', text = '_' },
            topdelete = { hl = 'GitGutterDelete', text = '‾' },
            changedelete = { hl = 'GitGutterChange', text = '~' },
          },
        })
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require('nvim-tree').setup({
          update_cwd = true,
          update_focused_file = {
            enable = true,
            update_cwd = true
          },
        })
      end
    }

    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require 'alpha'.setup(require 'alpha.themes.startify'.config)
      end
    }

    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })


    use 'slim-template/vim-slim'
    use 'meain/vim-printer'


    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)
    require('plugins.autocomplete').run(use)

    use {
      'williamboman/mason.nvim',
      config = function()
        require("mason").setup()
      end
    }

  end,
  config = {
    enable = true,
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
