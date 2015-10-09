""""""""""""""""""""""
" General            
""""""""""""""""""""""

" not compatible with vi
set nocompatible

" pathogen.vim plugin management
execute pathogen#infect()

" Tabs and autoindent
filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" Syntax highlighting
syntax on

" autocompletion like zsh 
set wildmenu
set wildmode=full

" increase history to 1000
set history=1000

" suppress error messages when editing and not saving buffers/args
set hidden

" turn on mouse support
set mouse=a

" clipboard, also had to install vim-gtk for full support
set clipboard=unnamedplus

set hlsearch
set incsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Opens every buffer on a new tab
"au BufAdd,BufNewFile * nested tab sball

" Set terminal colors
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
highlight Normal ctermfg=white ctermbg=232
highlight VertSplit ctermfg=234 ctermbg=232
set fillchars+=vert:\ 
hi Search ctermbg=9

""""""""""""""""""""""
" Mappings            
""""""""""""""""""""""

" easily traverse buffers (:bp, :bn, :bf, :bl)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" easily traverse arglists (:prev, :next, :first, :last)
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>


""""""""""""""""""""""
" Plugins            
""""""""""""""""""""""

" Netrw
let g:netrw_banner=0    " no header for netrw
let g:netrw_liststyle=3 " file list like a tree
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lexplore
augroup END
noremap <c-n> :Lexplore <CR>

" CTRL-P
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Airline.vim options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='wombat'
set laststatus=2 " always show the bottom bar

" PHP Complete
"set omnifunc=syntaxcomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
