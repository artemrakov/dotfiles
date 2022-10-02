return require('packer').startup({

  function(use)
    use { 'wbthomason/packer.nvim' }

    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }

    -- use { 'LudoPinelli/comment-box.nvim' }
    -- use {
    --   'phaazon/hop.nvim',
    --   config = function()
    --     require 'hop'.setup()
    --   end
    -- }

    -- use {
    --   'TimUntersberger/neogit',
    --   config = function()
    --     local neogit = require('neogit')
    --     neogit.setup()
    --   end,
    --   requires = 'nvim-lua/plenary.nvim'
    -- }

    use { 'tpope/vim-sensible' }
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
            -- theme = 'gruvbox-material',
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

    -- Use a single character as an alias for several text-objects
    -- E.g. q is aliased to `,',", so csqb replaces the nearest set of quotes with parentheses
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    })
    use 'windwp/nvim-spectre'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use 'ntpeters/vim-better-whitespace'
    use 'wincent/replay'
    use 'folke/tokyonight.nvim'

    use 'dyng/ctrlsf.vim'
    use { 'rktjmp/lush.nvim' }
    use { 'metalelf0/jellybeans-nvim' }

    use 'AndrewRadev/splitjoin.vim'


    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)
    require('plugins.autocomplete').run(use)
    require('plugins.specific').run(use)

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require('telescope')

        -- telescope.load_extension('refactoring')
        telescope.load_extension('fzf')

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

    -- with relative path
    require "nvim-tree.events".on_file_created(function(file) vim.cmd("edit " .. file.fname) end)
    -- with absolute path
    require "nvim-tree.events".on_file_created(function(file) vim.cmd("edit " .. vim.fn.fnamemodify(file.fname, ":p")) end)

    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = require('plugins.alpha-nvim')
    }

  end,
  config = {
    enable = true,
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
