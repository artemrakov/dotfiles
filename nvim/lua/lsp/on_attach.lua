return function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    local options = { noremap = true, silent = true }

    map('n', '<space>e', vim.diagnostic.open_float, options)
    map('n', 'K', function() vim.lsp.buf.hover() end, options)
    map('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
    map('n', '\'gr', function()
        require 'telescope.builtin'.lsp_references({
            layout_strategy = 'vertical',
            layout_settings = { width = 0.9, height = 0.9 }
        })
    end, options)
    map('n', '\'gd', function() vim.lsp.buf.definition() end, options)
    -- Rename file
    map('n', '<space>rf', ':Rename ', {})

    map('n', '<space>rn', function() vim.lsp.buf.rename() end, options)


    map('n', '[d',
        function() vim.diagnostic.goto_prev({ float = { border = 'single' } }) end,
        options)
    map('n', ']d',
        function() vim.diagnostic.goto_next({ float = { border = 'single' } }) end,
        options)
    map('n', '\'gi', function() vim.lsp.buf.implementation() end, options)
    map('n', '\'a', '<cmd>CodeActionMenu<CR>', options)
    map('n', '\'d', function()
        vim.diagnostic.open_float(0, {
            scope = 'line',
            source = "if_many",
            border = 'rounded',
            focusable = false
        })
    end, options)
    map('n', '\'D', '<cmd>TroubleToggle<CR>', options)

    map('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, options)
end
