local M = {}

function M.run(use)
  use {
    'williamboman/nvim-lsp-installer',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      local lsp_installer = require "nvim-lsp-installer"

      local servers = {
        'bashls', 'pyright', 'yamlls', 'ansiblels', 'cssls', 'diagnosticls', 'eslint',
        'emmet_ls', 'gopls', 'html', 'jsonls', 'jdtls', 'tsserver', 'sumneko_lua',
        'sqlls', 'stylelint_lsp', 'terraformls',
        'vimls', 'lemminx', 'clojure_lsp', 'hls'
      }

       for _, name in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
          print("Installing " .. name)
          server:install()
        end
      end

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local enhance_server_opts = {
        ["jsonls"] = function(opts)
          opts.settings = {
            json = {
              schemas = require('schemastore').json.schemas()
            },
          }
        end,
     }

      lsp_installer.on_server_ready(function(server)
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        if enhance_server_opts[server.name] then
          -- Enhance the default opts with the server-specific ones
          enhance_server_opts[server.name](opts)
        end

        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end)

      require'lspconfig'.solargraph.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "/root/.asdf/shims/solargraph", "stdio" }
        -- settings = {
          -- solargraph = {
            -- bundlerPath = "/root/.asdf/shims/bundler",
          -- },
          -- commandPath = "/root/.asdf/shims/solargraph"
        -- }
      }
    end,
  }

  use 'kosayoda/nvim-lightbulb'
end

return M
