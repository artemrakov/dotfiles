return function()
    local alpha = require('alpha')
    local startify = require('alpha.themes.startify')
    startify.section.top_buttons.val = {
        startify.button("e", "New file" , ":ene <BAR> startinsert <CR>"),
        startify.button('s', 'Plugins - Sync', ':PackerSync<CR>'),
        startify.button('c', 'Plugins - Cleanup', ':PackerClean<CR>'),
        startify.button('i', 'Plugins - Install', ':PackerInstall<CR>'),
    }
    alpha.setup(startify.config)
end
