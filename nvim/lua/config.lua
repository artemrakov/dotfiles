-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- # https://github.com/wbthomason/packer.nvim

-- https://github.com/nanotee/nvim-lua-guide#tips-2
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

require('plugins')


vim.diagnostic.config({
  virtual_text = {
    prefix = 'x'
  }
  -- signs = true,
  -- underline = true,
  -- update_in_insert = false,
  -- severity_sort = false,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("i", "<c-y>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", opts)
keymap("s", "<c-y>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", opts)

keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
