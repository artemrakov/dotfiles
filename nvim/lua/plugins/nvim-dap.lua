return function()
  local dap = require('dap')
  vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = '', linehl = '', numhl = '' })

  vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
  vim.keymap.set('n', '<leader>do', function() dap.step_out() end)
  vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
  vim.keymap.set('n', '<leader>dn', function() dap.step_over() end)
  vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)

  vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
end
