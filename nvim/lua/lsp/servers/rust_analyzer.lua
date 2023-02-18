return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            local rt = require("rust-tools")

            vim.keymap.set("n", "<leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
        end
    }
end
