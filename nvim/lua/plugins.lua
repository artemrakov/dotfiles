return require('packer').startup({

  function(use)
    require('plugins.treesitter').run(use)

    use { 'tpope/vim-sensible' }
    use 'f-person/git-blame.nvim'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'
    use 'jpalardy/vim-slime'
    use { 'ntpeters/vim-better-whitespace' }
    use 'wincent/replay'
    use 'folke/tokyonight.nvim'
    use 'gelguy/wilder.nvim'
    -- use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    use {
      'pocco81/auto-save.nvim',
      config = function()
        local autosave = require("auto-save")
        autosave.setup()
      end
    }

    use {
      'windwp/nvim-autopairs',
      requires = {
        'hrsh7th/nvim-cmp',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup({
          check_ts = true
        })
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      end
    }

    use 'tpope/vim-sleuth'


    use { "ellisonleao/glow.nvim" }
    -- anotations
    use {
      "danymat/neogen",
      config = function()
        require('neogen').setup {}
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    use 'NMAC427/guess-indent.nvim'
    use 'wbthomason/packer.nvim'
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
    use 'dyng/ctrlsf.vim'
    use {
      'marko-cerovac/material.nvim'
    }
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

    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('telescope').setup {
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
    use 'b0o/schemastore.nvim'

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

    use {
      'notjedi/nvim-rooter.lua',
      config = function() require 'nvim-rooter'.setup() end
    }

    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })



    -- use {
    --   "beauwilliams/focus.nvim",
    --   config = function() require("focus").setup() end
    -- }

    use 'slim-template/vim-slim'
    use 'meain/vim-printer'

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
