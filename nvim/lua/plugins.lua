return require('packer').startup({
  function(use)
    use { 'wbthomason/packer.nvim' }

    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'folke/tokyonight.nvim' }
    use { "nvim-neotest/nvim-nio" }

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

    use 'tpope/vim-projectionist'
    use { 'tpope/vim-sensible' }
    use({
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup {
          -- your config goes here
          -- or just leave it empty :)
        }
      end,
    })
    use 'tpope/vim-sleuth'
    use 'NMAC427/guess-indent.nvim'
    -- use 'lukas-reineke/indent-blankline.nvim'
    -- use {
    --   'windwp/windline.nvim',
    --   config = function() require('wlsample.bubble').setup() end
    -- }
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup({
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
          { aliases = { ['b'] = { ')', '}', ']', '>' } } }
        })
      end
    })
    use 'windwp/nvim-spectre'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use 'ntpeters/vim-better-whitespace'
    use 'wincent/replay'

    use 'dyng/ctrlsf.vim'
    use { 'rktjmp/lush.nvim' }
    use { 'metalelf0/jellybeans-nvim' }

    use 'AndrewRadev/splitjoin.vim'

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup({
          toggler = { line = 'gcc' }, opleader = { line = 'gc' },
        })
      end
    }

    require('plugins.treesitter').run(use)
    require('plugins.autocomplete').run(use)

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
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end
        })
      end
    }


    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function()
        require('nvim-tree').setup({
          update_cwd = true,
          update_focused_file = {
            enable = true,
            update_cwd = true
          },
        })
      end
    }

    -- with relative path
    -- require "nvim-tree.events".on_file_created(function(file) vim.cmd("edit " .. file.fname) end)
    -- -- with absolute path
    -- require "nvim-tree.events".on_file_created(function(file) vim.cmd("edit " .. vim.fn.fnamemodify(file.fname, ":p")) end)

    use {
      'williamboman/mason-lspconfig.nvim',
      requires = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
      config = function()
        local lsp = require('lsp')
        require('mason').setup()
        require("mason-lspconfig").setup({
          ensure_installed = lsp.servers
        })
      end
    }

    -- use {
    --   'jay-babu/mason-nvim-dap.nvim',
    --   config = function()
    --     require("mason-nvim-dap").setup({
    --       automatic_setup = true,
    --     })
    --
    --     require 'mason-nvim-dap'.setup_handlers {}
    --   end
    -- }

    -- use { "WhoIsSethDaniel/mason-tool-installer.nvim", requires = { "williamboman/mason.nvim" },
    --   config = function()
    --     local tools = require('lsp.servers.nullls')
    --     require 'mason-tool-installer'.setup {
    --       ensure_installed = tools.list,
    --       run_on_start = true,
    --       start_delay = 2000, -- 3 second delay
    --     }
    --   end }

    use 'mfussenegger/nvim-jdtls'

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }
    }

    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = require('plugins.alpha-nvim')
    }

    use {
      'ggandor/leap.nvim',
      config = function()
        require('leap').add_default_mappings()
      end
    }
    use 'ThePrimeagen/vim-be-good'
    use {
      'github/copilot.vim',
      config = require('plugins.copilot')
    }


    require('plugins.specific').run(use)
  end,
  config = {
    enable = true,
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
