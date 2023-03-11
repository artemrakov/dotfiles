local bind = vim.keymap.set
local silent = { silent = true }
local opts = { noremap = true, silent = true }


bind("n", "//", ":nohlsearch<CR>", silent)

bind('n', '<leader>vr', ':so $MYVIMRC<CR>')
bind('n', '<leader>vl', ':vsp $MYVIMRC<CR>')

-- Better window movement
bind("n", "<C-l>", "<C-w>l", silent)
bind("n", "<C-h>", "<C-w>h", silent)
bind("n", "<C-j>", "<C-w>j", silent)
bind("n", "<C-k>", "<C-w>k", silent)

bind("n", "gV", "`[v`]", silent)

bind("n", "k", "gk", silent)
bind("n", "j", "gj", silent)

-- for russian layout
bind("n", "л", "gk", silent)
bind("n", "о", "gj", silent)

-- Move selected line / block of text in visual mode
-- bind("x", "K", ":move '<-2<CR>gv-gv", silent)
-- bind("x", "J", ":move '>+1<CR>gv-gv", silent)

-- Keep visual mode indenting
bind("v", "<", "<gv", silent)
bind("v", ">", ">gv", silent)

-- Buffers
bind("n", "gn", ":bn<CR>", silent)
bind("n", "gp", ":bp<CR>", silent)

-- Quickfix
-- bind("n", "<leader>,", ":cp<CR>", silent)
-- bind("n", "<leader>.", ":cn<CR>", silent)

-- Toggle quicklist
-- https://github.com/ecosse3/nvim/blob/master/lua/utils/init.lua
-- bind("n", "<leader>q", "<cmd>lua require('utils').toggle_quicklist()<CR>", silent)

-- Easyalign
-- bind("n", "ga", "<Plug>(EasyAlign)", silent)
-- bind("x", "ga", "<Plug>(EasyAlign)", silent)

-- Refactor with spectre
-- bind("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", silent)
-- bind("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

-- bind(
--   "v",
--   "<leader>rr",
--   "<Esc><rmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
--   opts
-- )

-- LSP
bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
bind("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
-- bind("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
bind("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
bind("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
bind("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting({ async = true })<CR>", silent)
bind("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
bind("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
bind("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
bind("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
bind("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)

-- Telescope
bind("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", silent)
bind("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", silent)
bind("n", "<leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", silent)
bind("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", silent)
bind("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", silent)
bind("n", "<leader>sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", silent)
bind("n", "<leader>sr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", silent)
bind("n", "<leader>sa", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>", silent)
bind("n", "<leader>sh", "<cmd>lua require('telescope.builtin').search_history()<cr>", silent)
bind("n", "<leader>so", "<cmd>lua require('telescope.builtin').resume()<cr>", silent)

bind('n', '<leader><leader>', ':NvimTreeToggle<CR>')
bind('n', '<C-n>', ':NvimTreeFindFile<CR>')

-- LuaSnip for snippets
bind("i", "<c-y>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", opts)
bind("s", "<c-y>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", opts)
bind("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
bind("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
bind("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
bind("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

-- Dropbox
bind("n", "<leader>nd", ":e ~/Dropbox<cr>", silent)
bind("n", "<leader>nj", ":sp ~/Dropbox/notes/debugging_journal.txt<cr>", silent)
bind("n", "<leader>nc", ":sp ~/Dropbox/notes/coding-notes.txt<cr>", silent)
bind("n", "<leader>nn", ":sp ~/Dropbox/notes/programming_notes.txt<cr>", silent)
bind("n", "<leader>np", ":sp ~/Dropbox/work/shogun/project-notes.md<cr>", silent)

bind("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", silent)
bind("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>", silent)

-- Comment Box
-- bind("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)
-- bind("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)

-- bind('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
-- bind('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
-- bind('n', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", opts)
-- bind('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", opts)
