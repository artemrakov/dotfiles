return function()
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_filetypes = { xml = false, lua = false }
  vim.g.copilot_no_tab_map = true

  vim.api.nvim_set_keymap('i', '<C-y>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
end
