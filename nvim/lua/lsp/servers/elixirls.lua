return function(on_attach)
    local capabilities = require('cmp_nvim_lsp').default_capabilities();
    return {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            local map_opts = { buffer = true, noremap = true }
            -- remove the pipe operator
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", map_opts)
            -- add the pipe operator
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", map_opts)
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", map_opts)
        end

    }
end
