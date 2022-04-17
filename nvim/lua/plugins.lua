return require('packer').startup({

  function(use)
    use { 'tpope/vim-sensible' }
    use 'mhinz/vim-startify'
    use 'f-person/git-blame.nvim'
    use 'tpope/vim-repeat'
    use { 'ntpeters/vim-better-whitespace' }

    use {
      'Pocco81/AutoSave.nvim',
      config = function ()
        local autosave = require("autosave")
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
        npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
        npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
        npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
      end
    }

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
          theme = 'auto',
          globalstatus = true,
          section_separators = { left = '', right = ''},
          component_separators = { left = '|', right = '|'},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },

      }) end
    }

    use 'tpope/vim-surround'
    use 'windwp/nvim-spectre'
    use 'dyng/ctrlsf.vim'
    use {
     'marko-cerovac/material.nvim'
    }
    use { 'rktjmp/lush.nvim'}
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
      config = function ()
        require('Comment').setup()
      end
    }
    -- use { 'andymass/vim-matchup' }

    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        -- FIXME: enable sort_mru
        require('telescope').setup{
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
      config = function() require('nvim-tree').setup {} end
    }

    -- use {
    --   "beauwilliams/focus.nvim",
    --   config = function() require("focus").setup() end
    -- }

    use 'slim-template/vim-slim'

    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)
    require('plugins.autocomplete').run(use)

  end,
  config = {
    enable = true,
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
