" Plugins:
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug'
  Plug 'junegunn/goyo.vim'
  Plug 'godlygeek/tabular'
  Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'branch': 'release/1.x',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json',
    \         'graphql', 'markdown', 'vue', 'yaml', 'html']
    \ }
  Plug 'Pangloss/vim-javascript'
  Plug 'posva/vim-vue'
  Plug 'chrisbra/csv.vim'
  Plug 'vim-scripts/paredit.vim'
  Plug 'vim-scripts/Improved-AnsiEsc'
  Plug 'elzr/vim-json'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'majutsushi/tagbar'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'airblade/vim-gitgutter'
  Plug 'lnl7/vim-nix'
  Plug 'mindriot101/vim-yapf'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'plasticboy/vim-markdown'
  Plug 'guns/xterm-color-table.vim'
  Plug 'flazz/vim-colorschemes'
call plug#end() 

" Basic Settings:
filetype on
filetype plugin on
filetype indent on
syntax enable
" Prevent unsafe commands in configuration files.
set secure
" Load project local vimrc files: `foo/.vimrc` after usual config files.
set exrc
" Show line numbers, column, and enable modeline scripts.
setlocal number linebreak modeline
set ruler modelines=5
setlocal colorcolumn=81
" Enable mouse controls.
set mouse=a backspace=2
" Highlight paired parenthesis, and allow line wrapping during navigation.
set showmatch whichwrap+=<,>,h,l,[,]
" Set tab behavior to use 2 spaces, display literal tabs ('\t') as 4 spaces.
setlocal tabstop=4 expandtab softtabstop=2 shiftwidth=2
set shiftround
setlocal autoindent
" Periodically backup files to swap.
set updatetime=100
" Turn off some of the more annoying autoformatting in comments.
setlocal formatoptions-=c
setlocal formatoptions-=o
" Lower case can match upper case in searches.
set ignorecase smartcase
" Allow use of the system clipboard.
set clipboard=unnamedplus
" Make spellfile if it doesn't exist.
if empty( glob( "~/.vim/spell" ) )
  execute "!mkdir -p ~/.vim/spell"
endif
if empty( glob( "~/.vim/spell/spellfile.add" ) )
  execute "!touch ~/.vim/spell/spellfile.add"
endif
setlocal spellfile=~/.vim/spell/spellfile.add

" Use vertical bar cursor in insert mode and block in visual.
" Note: SI = Insert Mode, EI = Normal Mode, SR = Replace/Visual Mode
if &term =~ 'iTerm'
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
elseif &term =~ '^xterm\|rxvt'
  "  1|0 = Blinking Block, 2 = Solid Block, 3 = Blinking Underscore,
  "  5 = Blinking Vertical Bar,  6 = Solid Vertical Bar
  let &t_SI .= "\<Esc>[5 q"
  let &t_SR .= "\<Esc>[2 q"
  let &t_EI .= "\<Esc>[2 q"
endif

" Status Line:
set laststatus=2
" Statusline = Filepath, Filetype, Column, Current Line, Total Lines,
"              Current/(Total Lines) as percentage;
setlocal statusline=\ %F\ ft:%y%=[c:%c]\ (ln:%l/%L,%p%%)\ 

" Code folding:
set foldlevelstart=1
setlocal foldminlines=0
" Automatically detect foldmarkers.
autocmd BufReadPost * if search( '\({{{\|}}}\)\d*' )
  \ | set foldmethod=marker | endif
" Show part of the first line in a fold's preview.
function! MyFoldText()
  let sub = substitute( getline( v:foldstart ), '/\*\|\*/\|{{{\d\=', '', 'g' )
  return v:folddashes . sub
endfunction
setlocal foldtext=MyFoldText()

command! RemoveEmptyLines :g/^$/d

" Keymaps:
map j gj
map k gk

let mapleader = ','
let maplocalleader = '\'

" Pressing `,ev` edits vimrc and `,rv` reloads it.
nnoremap <Leader>ev :vsplit $HOME/.vimrc<CR>
nnoremap <Leader>rv :source $HOME/.vimrc<CR>
" Window navigation using tab and hjkl
nnoremap <Tab>h <C-w>h
nnoremap <Tab>j <C-w>j
nnoremap <Tab>k <C-w>k
nnoremap <Tab>l <C-w>l
" Resize windows with tab and arrows or <>-=
nnoremap <Tab>< <C-w>>
nnoremap <Tab><Left> <C-w>>
nnoremap <Tab>> <C-w><
nnoremap <Tab><Right> <C-w><
nnoremap <Tab>= <C-w>=
nnoremap <Tab><Up> <C-w>=
nnoremap <Tab>- <C-w>-
nnoremap <Tab><Down> <C-w>-
" Toggle "Uncluttered" view
nnoremap <F5> :Goyo<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
" Activate or navigate Location List or Quickfix
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Buffer> cn :cnext<CR>
nnoremap <Buffer> cp :cprev<CR>
" Jump between tabs
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>
" Format entire file
nnoremap <Leader>gq mgHmqgggqG`qzt`g
" Center selected lines
vnoremap ce :ce<CR>
" Stop highlighting search results
nmap <Space> :nohlsearch<CR>
" Grep under cursor
nnoremap <Leader>g :silent execute "grep! -R "
  \ . shellescape( expand( "<cWORD>" ) ) . " ." <CR> :copen <CR>
" Fuzzy find a file (recursively from CWD), and open it.
nnoremap <C-o> :FZF<CR>

" Nerd Tree:
autocmd BufEnter * if ( winnr( "$" ) == 1 && exists( "b:NERDTree" )
  \                     && b:NERDTree.isTabTree() ) | q | endif
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeNaturalSort = 1
let NERDTreeIgnore = [ 'tags' ]

" Nerd Commenter:
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDToggleCheckAllLines = 1

" Indentation and Formatting:
let g:prettier#exec_cmd_async = 1
let g:prettier#config#config_precedence = 'file-override'

let g:gitgutter_max_signs = 1000
let g:tagbar_autofocus = 1
