lua require('config')

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set mouse=a
set breakindent
set number
set signcolumn=yes
set updatetime=250
set smartcase
set undofile
set splitbelow
set splitright
set noswapfile
set numberwidth=2
set relativenumber
set cpoptions+=n
set clipboard=unnamedplus
set cul


" set undodir=/tmp/.vim/backups
set ignorecase
set scrolloff=3
set completeopt=menu,menuone,noselect
set termguicolors
set expandtab

set softtabstop=2
set tabstop=2
set smarttab
" new line indent: how many spaces for one tab
set shiftwidth=2

let mapleader = "\<Space>"
let maplocalleader = ","

let g:vimsyn_embed = 'l'
let g:better_whitespace_enabled=1
let g:gitblame_enabled = 0


let g:tokyonight_style = "night"
colorscheme tokyonight


nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')


map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Edit .vimrc
map <leader>vl :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

nmap <silent> // :nohlsearch<CR>

" TODO: improve n+1 line moving by russian keys
nnoremap <expr> л (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> о (v:count == 0 ? 'gj' : 'j')


map <Leader>nd :e ~/Dropbox<cr>
map <Leader>nj :sp ~/Dropbox/notes/debugging_journal.txt<cr>
map <Leader>nc :sp ~/Dropbox/notes/coding-notes.txt<cr>
map <Leader>nn :sp ~/Dropbox/notes/programming_notes.txt<cr>
map <Leader>np :sp ~/Dropbox/work/shogun/project-notes.md<cr>

" Find files using Telescope command-line sugar
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sd <cmd>Telescope diagnostics<cr>
nnoremap <leader>sc <cmd>Telescope git_commits<cr>
nnoremap <leader>sr <cmd>Telescope lsp_references<cr>
nnoremap <leader>so <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>sa <cmd>Telescope lsp_range_code_actions<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>

nnoremap <leader><leader> :NvimTreeToggle<CR>
nnoremap <C-n> :NvimTreeFindFile<CR>

nnoremap <leader>ff :Format<CR>

nnoremap <leader>S :lua require('spectre').open()<CR>

nnoremap <leader>gb :GitBlameToggle<cr>

vmap "y "*y
nmap "y "*y
nmap "Y "*Y
nmap "p "*p
nmap "P "*P



" automatically run :PackerCompile whenever plugins.lua is updated
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source ~/.config/nvim/lua/plugins.lua | PackerCompile
  autocmd BufWritePost config.lua source ~/.config/nvim/lua/config.lua | PackerCompile
  autocmd BufWritePost *plugins* source ~/.config/nvim/lua/config.lua | PackerCompile
augroup end

" https://github.com/neovim/nvim-lspconfig/wiki/Code-Actions
 " autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()

" Highlight on yank
" nnoremap gV `[v`]
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

let s:middot='·'
let s:raquo='»'
let s:small_l='l'

" Override default `foldtext()`, which produces something like:
"
"   +---  2 lines: source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim--------------------------------
"
" Instead returning:
"
"   »··[2ℓ]··: source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim···································
"
function! Foldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction

if has('folding')
  if has('windows')
    set fillchars=diff:∙                " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    set fillchars+=fold:·               " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    set fillchars+=vert:┃               " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif

  set foldmethod=indent                 " not as cool as syntax, but faster
  set foldlevelstart=99                 " start unfolded
  set foldtext=Foldtext()
endif


function! Cycle_numbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

nnoremap <silent> <Leader>l :call Cycle_numbering()<CR>
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

" Command mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Toggle folds
" nnoremap <tab> za

function! Arakov_substitute(pattern, replacement, flags) abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, a:pattern, a:replacement, a:flags))
    let l:number=l:number + 1
  endfor
endfunction

function! Zap() abort
  call Arakov_substitute('\s\+$', '', '')
endfunction

nnoremap <silent> <Leader>z :call Zap()<CR>

autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

let g:slime_target = "tmux"
let g:mkdp_auto_close = 0
