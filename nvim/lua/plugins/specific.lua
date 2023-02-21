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
    'mfussenegger/nvim-dap',
    config = require('plugins.nvim-dap')
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }

  use {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      local general_on_attach = require('lsp.on_attach')
      local serverConfig = require('lsp.servers.rust_analyzer')(general_on_attach)

      local opts = {
        tools = {
          inlay_hints = {
            auto = false,
          },
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = serverConfig.on_attach
        },
      }

      local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
      local codelldb_path = path .. "adapter/codelldb"
      local liblldb_path = path .. "lldb/lib/liblldb.dylib"

      if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
        opts.dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        }
      else
        local msg = "Either codelldb or liblldb is not readable."
            .. "\n codelldb: "
            .. codelldb_path
            .. "\n liblldb: "
            .. liblldb_path
        vim.notify(msg, vim.log.levels.ERROR)
      end

      rt.setup(opts)
    end
  }
end

return M
