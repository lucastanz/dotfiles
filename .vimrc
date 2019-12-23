""""""""""""""""""""""
" General            
""""""""""""""""""""""

" disable vi-compatibility
set nocompatible
filetype off

" Plug
" automatic installation - https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""
" Plugins
""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'lucastanz/ultisnips-reloaded'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
"Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stephpy/vim-php-cs-fixer'
"Plug 'vim-php/vim-php-refactoring'
Plug 'vim-scripts/matchit.zip'
"Plug 'vim-scripts/php.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
" auto insert phpnamespaces using \u
Plug 'nelsyeung/twig.vim'
Plug '2072/PHP-Indenting-for-VIm'
Plug 'janko/vim-test'
Plug 'benmills/vimux'
Plug 'vim-vdebug/vdebug'
"Plug 'farmergreg/vim-lastplace'
"Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "install also ripgrep (https://github.com/BurntSushi/ripgrep#installation)
call plug#end()

"""""""""""""""""""""
" End Plug 
"""""""""""""""""""""

" General - Tabs and autoindent
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set relativenumber
set number
set scrolloff=10
set ignorecase " ignore case when searching
set smartcase " ignore case if search pattern is all lowercase
set visualbell " don't beep
set noerrorbells " don't beep
set autowrite " save on buffer switch

" always show what mode we're currently editing in
set showmode

" no wrap lines
set nowrap

" no .swp files or backups
set noswapfile
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

" highlight search
set hlsearch
set incsearch

" to make Vim’s :! shell behave like your command prompt (loads .bashrc)
set shell=bash

set tags=.tags

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

let mapleader = ","
let g:mapleader = ","

" fast saves
nmap <leader>w :w!<cr>

" down is really the next line
nnoremap j gj
nnoremap k gk

" easy escaping to normal mode
imap jj <esc>

" run PHPUnit tests
map <leader>t :!./vendor/bin/phpunit %<cr>

" clear search highlight with ctrl-l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Opens every buffer on a new tab
"au BufAdd,BufNewFile * nested tab sball

" Set terminal colors
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

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

" Save as root
cnoremap w!! %!sudo tee > /dev/null %

"""""""""""""""""""""
" Abbrev
"""""""""""""""""""""

" laravel
abbrev mm !php artisan make:model
abbrev mc !php artisan make:controller
abbrev mmig !php artisan make:migration

""""""""""""""""""""""
" Files behaviour
""""""""""""""""""""""

" php

" auto-remove trailing spaces
autocmd BufWritePre *.php :%s/\s\+$//e

" example of load undelying class for Laravel (todo fix path)
function! FacadeLookup()
    let facade = input('Facade Name: ')
    let classes = {
\        'Form': 'Html/FormBuilder.php',
\        'Html': 'Html/HtmlBuilder.php',
\        'File': 'Filesystem/Filesystem.php',
\        'Eloquent': 'Database/Eloquent/Model.php'
\    }

    execute ":e vendor/laravel/framework/src/Illuminate/" . classes[facade]
endfunction
nmap ,lf :call FacadeLookup()<cr>

""""""""""""""""""""""
" Plugins            
""""""""""""""""""""""

" NERDTree
let NERDTreeAutoDeleteBuffer=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
"
" Open a NerdTree if no file is given as CLI argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close if the only remaining window is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

autocmd BufReadPre,FileReadPre * :NERDTreeClose

" vim-commentary
autocmd FileType php setlocal commentstring=//\ %s

" phpactor
" autocompletion
autocmd FileType php setlocal omnifunc=phpactor#Complete

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>oo :call phpactor#GotoDefinition()<CR>
nmap <Leader>oh :call phpactor#GotoDefinitionHsplit()<CR>
nmap <Leader>ov :call phpactor#GotoDefinitionVsplit()<CR>
nmap <Leader>ot :call phpactor#GotoDefinitionTab()<CR>

" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

" Netrw
"let g:netrw_banner=0    " no header for netrw
"let g:netrw_liststyle=3 " file list like a tree
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 20
"let g:netrw_list_hide = '.*\.svn$'
" new settings ( require last netrw vimball for Lexplore command ) 
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :NERDTreeToggle
"augroup END
noremap <silent> <c-n> :NERDTreeToggle <CR>

" fzf
nnoremap <C-p> :Files<Cr>
nnoremap <C-f> :Rg<Cr>

" CTRL-P
"set runtimepath^=~/.vim/plugged/ctrlp.vim
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.gif,*.png
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)|node_modules|public|vendor$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
"
"" Set delay to prevent extra search
"let g:ctrlp_lazy_update = 350
"
"" Do not clear filenames cache, to improve CtrlP startup
"" You can manualy clear it by <F5>
"let g:ctrlp_clear_cache_on_exit = 0
"
"" Set no file limit, we are building a big project
"let g:ctrlp_max_files = 0
"let g:ctrlp_working_path_mode = 'w'

" Airline.vim options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='wombat'
set laststatus=2 " always show the bottom bar

let g:pdv_cfg_Package = 'placeholder'
let g:pdv_cfg_Version = '1.0.0'
let g:pdv_cfg_Author = 'Author'
let g:pdv_cfg_Copyright = 'Copyright 2011 by Your Name <your.name@example.com>'
let g:pdv_cfg_License = 'Provided under the GPL (http://www.gnu.org/copyleft/gpl.html)'

" colorscheme
set background=dark
colorscheme molokai

" automatic jslint
let JSHintUpdateWriteOnly=1

" set html filetype for .blade.php files
augroup blade_ft
    au!
    autocmd BufNewFile,BufRead *.blade.php set filetype=html
augroup END

autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype ts setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.feature setlocal ts=2 sts=2 sw=2

au BufReadPost *.twig set syntax=html

" automatic closing brackets
inoremap {<CR>  {<CR>}<Esc>O
inoremap {<C-j>  {<CR>}<Esc>O

inoremap [<CR>  [<CR>];<Esc>O
inoremap [<C-j>  [<CR>];<Esc>O

inoremap (<CR>  (<CR>);<Esc>O
inoremap (<C-j>  (<CR>);<Esc>O

" vim-php-namespace
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

" autocreates a dir if does not exist
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" tagbar
nmap <F8> :TagbarToggle<CR>

" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "vimux"

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>" 
let g:UltiSnipsJumpBackwardTrigger="<s-tab>" 
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/ultisnips-reloaded/UltiSnips/']

" vdebug
let g:vdebug_options = {'ide_key': 'netbeans-xdebug'}
let g:vdebug_options = {'break_on_open': 0}
let g:vdebug_options = {'server': '127.0.0.1'}
let g:vdebug_options = {'port': '10000'}

" rg search if available
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%m
endif

" to make higlighting work for both html and twig in twig files
syntax on
