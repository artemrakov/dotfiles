local general_on_attach = require('lsp.on_attach')

local M = {}

M.servers = {
  'tsserver',
  'solargraph',
  'sumneko_lua',
  'jsonls',
  'elixirls',
  'rust_analyzer'
}

M.setup = function()
  require('lsp.settings')()
  require('lsp.servers.nullls').setup()

  for _, serverName in pairs(M.servers) do
    local serverConfig = require('lsp.servers.' .. serverName)(
      general_on_attach)
    -- serverConfig.flags = { debounce_text_changes = 100, lintDebounce = 200 }
    serverConfig.capabilities = serverConfig.capabilities or require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')[serverName].setup(serverConfig)
  end

  -- local lspconfig = require('lspconfig')
  -- local configs = require 'lspconfig.configs'
  -- if not configs.barium then
  --   configs.barium = {
  --     default_config = {
  --       cmd = { 'barium' };
  --       filetypes = { 'brazil-config' };
  --       root_dir = function(fname)
  --         return lspconfig.util.find_git_ancestor(fname)
  --       end;
  --       settings = {};
  --     };
  --   }
  -- end
  --
  -- lspconfig.barium.setup {
  --   on_attach = general_on_attach,
  --   capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- }
end

return M
