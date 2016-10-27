""""""""""""""""""""""
" General            
""""""""""""""""""""""

" not compatible with vi
set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'ervandew/supertab'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'mikehaertl/pdv-standalone'
Bundle 'stephpy/vim-php-cs-fixer'
Bundle 'vim-php/vim-php-refactoring'
Bundle 'EvanDotPro/php_getset.vim'
Bundle 'vim-scripts/matchit.zip'
Bundle "wookiehangover/jshint.vim"
Bundle 'joonty/vdebug'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'

"Bundle 'tpope/vim-vinegar'
"Bundle 'scrooloose/syntastic'

" Tabs and autoindent
filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" no .swp files
set noswapfile

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

" highlight search
set hlsearch
set incsearch
" clear search highlight with ctrl-l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Opens every buffer on a new tab
"au BufAdd,BufNewFile * nested tab sball

" Set terminal colors
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
"highlight Normal ctermfg=white ctermbg=234
"highlight VertSplit ctermfg=232 ctermbg=232
"set fillchars+=vert:\ 
"hi Search ctermbg=238

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


""""""""""""""""""""""
" Plugins            
""""""""""""""""""""""

" Netrw
"let g:netrw_banner=0    " no header for netrw
"let g:netrw_liststyle=3 " file list like a tree
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 20
"let g:netrw_list_hide = '.*\.svn$'
" new settings ( require last netrw vimball for Lexplore command ) 
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :NERDTreeToggle
augroup END
noremap <silent> <c-n> :NERDTreeToggle <CR>

" CTRL-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.gif,*.png
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" PyMatcher for CtrlP
"if !has('python')
"    echo 'In order to use pymatcher plugin, you need +python compiled vim'
"else
"    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"endif

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" If ag is available use it as filename list generator instead of 'find'
"if executable("ag")
"    set grepprg=ag\ --nogroup\ --nocolor
"    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --path-to-agignore ~/.agignore --hidden -g ""'
"endif

" Airline.vim options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='wombat'
set laststatus=2 " always show the bottom bar

" PHP/HTML Complete
"set omnifunc=syntaxcomplete#Complete
set omnifunc=htmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=longest,menuone

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"" PHP Complete

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" pdv-standalone phpdoc
nnoremap <C-K> :call PhpDocSingle()<CR>
vnoremap <C-K> :call PhpDocRange()<CR>

let g:pdv_cfg_Package = 'placeholder'
let g:pdv_cfg_Version = '1.0.0'
let g:pdv_cfg_Author = 'Author'
let g:pdv_cfg_Copyright = 'Copyright 2011 by Your Name <your.name@example.com>'
let g:pdv_cfg_License = 'Provided under the GPL (http://www.gnu.org/copyleft/gpl.html)'

"php cs fixer
" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "symfony"              " which level ?
let g:php_cs_fixer_config = "default"             " configuration
"let g:php_cs_fixer_config_file = '.php_cs'       " configuration file
let g:php_cs_fixer_php_path = "php"               " Path to PHP
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" colorscheme
set background=dark
colorscheme molokai
if fnamemodify(getcwd(), ':t') == 'from-rome-with-love'
  autocmd BufWritePost * call system('sculpin generate')
endif

" automatic jslint
let JSHintUpdateWriteOnly=1

let NERDTreeShowHidden=1

" vdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype ts setlocal ts=2 sts=2 sw=2

inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap {<CR>  {<CR>}<Esc>O
inoremap {<C-j>  {<CR>}<Esc>O
inoremap [<CR>  [<CR>]<Esc>O
inoremap [<C-j>  [<CR>]<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap (<C-j>  (<CR>)<Esc>O

let g:jsx_ext_required = 0

