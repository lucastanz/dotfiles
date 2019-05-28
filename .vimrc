""""""""""""""""""""""
" General            
""""""""""""""""""""""

" not compatible with vi
set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""""""""""""""""""""""
" Bundles
""""""""""""""""""""""
Bundle 'neoclide/coc.nvim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'mikehaertl/pdv-standalone'
Bundle 'stephpy/vim-php-cs-fixer'
"Bundle 'vim-php/vim-php-refactoring'
Bundle 'vim-scripts/matchit.zip'
Bundle 'mxw/vim-jsx'
Bundle 'mattn/emmet-vim'
Bundle 'qbbr/vim-symfony'

" auto insert phpnamespaces using \u
Bundle 'arnaud-lb/vim-php-namespace'

Bundle 'ludovicchabant/vim-gutentags'
Bundle 'nelsyeung/twig.vim'

"Bundle 'tpope/vim-vinegar'

Bundle '2072/PHP-Indenting-for-VIm'

"""""""""""""""""""""
" End Bundles 
"""""""""""""""""""""


" General - Tabs and autoindent
filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set relativenumber
set number

" no .swp files or backups
set noswapfile
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=yes

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

" coc
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" remap keys for gotos
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-snipeets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" CTRL-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.gif,*.png
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|node_modules|public$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'w'

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

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype ts setlocal ts=2 sts=2 sw=2

au BufReadPost *.twig set syntax=html

" automatic closing brackets
inoremap {<CR>  {<CR>}<Esc>O
inoremap {<C-j>  {<CR>}<Esc>O

inoremap [<CR>  [<CR>];<Esc>O
inoremap [<C-j>  [<CR>];<Esc>O

inoremap (<CR>  (<CR>);<Esc>O
inoremap (<C-j>  (<CR>);<Esc>O

let g:jsx_ext_required = 0

" vim-php-namespace
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

" vim-gutentags
let g:gutentags_enabled = 1
let g:gutentags_generate_on_missing = 1      " Generate a tags file if there is none.
let g:gutentags_generate_on_new = 0          " Don't regenerate tags file in a new Vim session (I tend to reopen Vim a lot).
let g:gutentags_generate_on_write = 1        " Do update the tags file on file save.
let g:gutentags_resolve_symlinks = 1
" Only index tags in git projects. Store tags files inside of the .git
" repository so it doesn't make the repo dirty if 'tags' is missing from
" .gitignore. Downside: this doesn't work for non-git repositories. I would
" enable it for other VCS's as well but I haven't found how to
" conditionalize the '.git' in gutentags_ctags_tagfile...
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_project_root = ['.git']
let g:gutentags_add_default_project_roots = 0
" Make ctags add the language of the tag, so that we can postprocess the
" tags file for fuzzy tag finding.
let g:gutentags_ctags_extra_args = ['--totals=yes', '--tag-relative=yes', '--fields=+acfint', '--PHP-kinds=+acfint-va']
" Exclude useless files
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                                  \ '*.phar', '*.ini', '*.rst', '*.md',
                                  \ '*vendor/*/test*', '*vendor/*/Test*',
                                  \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                                  \ '*var/cache*', '*var/log*']


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

" to make higlighting work for both html and twig in twig files
syntax on
