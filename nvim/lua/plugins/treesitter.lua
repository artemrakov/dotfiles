local M = {}

function M.run(use)
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'andymass/vim-matchup',
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
    'p00f/nvim-ts-rainbow',
    'JoosepAlviste/nvim-ts-context-commentstring',

    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require'treesitter-context'.setup {
          separator = '-'
        }
      end
    },
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        endwise = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        -- indent = {
        --   enable = true,
        -- },
        matchup = {
          enable = true
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 1000,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end
  }
end

return M
