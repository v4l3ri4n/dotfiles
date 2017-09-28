" VIM Configuration

set nocompatible             " Cancel Vi compatibility

" -----------------------------------------------------------
" Pathogen
" -----------------------------------------------------------

let g:pathogen_disabled = [] " To disable a plugin, add it's bundle name to the following list
let s:php_version = substitute(system("php -v | grep -Eo '^PHP ([0-9|\.]){3}' | cut -d ' ' -f 2"), ".", "", "g")
if (executable("php")<1 || (s:php_version + 0)<54)
    " disable phpcd if php is not present or below 5.4
    call add(g:pathogen_disabled, 'phpcd.vim')
endif

call pathogen#infect()       " Activate pathogen

" -----------------------------------------------------------
" General
" -----------------------------------------------------------

autocmd vimenter * NERDTree  " Activate NERDTree on start
autocmd VimEnter * wincmd w  " jump to main pane

let mapleader=","              " use comma as leader
set timeoutlen=500             " lower timeout for leader key

set backspace=indent,eol,start " Activate normal behaviour of backspace key
set hidden                     " A buffer becomes hidden when it's unloaded
set autoread                   " Reload files changed outside vim"
set history=1000               " Store lots of :cmdline history

" Beep
set visualbell            " Stop beeping
set noerrorbells          " Stop beeping

" Search
set ignorecase            " Ignore case in search patterns
set smartcase             " If a search pattern contains a uppercase, activate case sensitivity
set incsearch             " While typing the pattern, highlight matches
set hlsearch              " Highlight search matches
nnoremap <leader><space> :noh<CR> " Turn off search highlight
nnoremap <leader><space><space> :pclose<CR> " Close preview window

" auto reload the config file after modifications
autocmd BufWrite $MYVIMRC source $MYVIMRC

:nnoremap <leader>ev :vsplit $MYVIMRC<cr> " edit vimrc mapping
:nnoremap <leader>sv :source $MYVIMRC<cr> " reload vimrc mapping

" -----------------------------------------------------------
" Swap files & backups & undo
" -----------------------------------------------------------

set noswapfile            " Swap file contains undo/redo history and more
"set nobackup             " Backup is a file containg content before file is edited
"set nowritebackup        " changes the default save behavior of Vim (writes buffer directly to file)

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
set undolevels=1000

" -----------------------------------------------------------
" Colors & Display
" -----------------------------------------------------------

" Display
set title                 " Enable title update
set number                " Show line numbers
set ruler                 " Show the position of the cursor
set wrap                  " Wrap lines
set scrolloff=3           " Scroll offset around cursor

syntax enable             " Enable syntax color
set term=screen-256color  " enable colors on term and to be sync with tmux conf

" Enable Solarized theme with dark background
let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

set guifont=DejaVu\ Sans\ Mono\ 10
set antialias

" Highlight line and column cursor position
set cursorline
set cursorcolumn

" -----------------------------------------------------------
" Code syntax
" -----------------------------------------------------------

" Detect filetype and enable specific behaviours
filetype on
filetype plugin on
filetype indent on

" Tabs and indent
set expandtab           " Insert spaces when tab is pressed
set tabstop=4           " number of spaces for a TAB
set shiftwidth=4        " number of spaces for indent

" Remove trailing whitespaces and ^M chars
autocmd FileType php,js,css,html,xml,yaml,vim autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Do not auto insert comment chars on newline in insert mode when ENTER
"autocmd FileType * setlocal formatoptions-=r

" -----------------------------------------------------------
" Navigation
" -----------------------------------------------------------

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Faster scrolling
nnoremap <C-h> 3h
nnoremap <C-j> 3j
nnoremap <C-k> 3k
nnoremap <C-l> 3l
vnoremap <C-h> 3h
vnoremap <C-j> 3j
vnoremap <C-k> 3k
vnoremap <C-l> 3l

" Remap escape key
imap ,, <Esc>
map ,, <Esc>

" -----------------------------------------------------------
" Selection
" -----------------------------------------------------------

" keep selection in visual mode after a right or left shift
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]''`]`'

" -----------------------------------------------------------
" Plugins configuration
" -----------------------------------------------------------

" NERDTree ______________________________________

map <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

" vim-airline ___________________________________

let g:airline#extensions#tagbar#enabled = 0 " remove tag from status line

" ack.vim _______________________________________

let g:ack_default_options = " -H --nocolor --nogroup --column" " ensure compatibility with ack-grep 1.9

" Syntastic _____________________________________

let g:syntastic_check_on_open = 0 " syntastic will run syntax checks when buffers are first loaded and saved
let g:syntastic_check_on_wq = 0   " skip check on :wq
let g:syntastic_error_symbol = "\ue0b0"
let g:syntastic_warning_symbol = ">"
let g:syntastic_style_error_symbol = "\ue0b0"
let g:syntastic_style_warning_symbol = ">"

" neocomplete ___________________________________

let g:neocomplete#enable_at_startup = 1                  " Use neocomplete
let g:neocomplete#enable_smart_case = 1                  " Use smartcase
let g:neocomplete#sources#syntax#min_keyword_length = 3  " Set minimum syntax keyword length

" Define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
    \ }

" Reset sorters
"call neocomplete#custom#source('_', 'sorters', [])

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Key mappings
inoremap <silent> <CR> <C-r>=<SID>ClosePopupAndSaveIndent()<CR>
function! <SID>ClosePopupAndSaveIndent()
    " return neocomplete#close_popup() . "\<CR>"
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

inoremap <expr><C-f> neocomplete#start_manual_complete('omni')

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" Omni-Completion tip window to close when a selection is made,
" these lines close it on movement in insert mode or when leaving insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" php.vim ________________________________________

" Need to be in .vimrc
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" tagbar _________________________________________

nmap <leader>t :TagbarToggle<CR>

" -----------------------------------------------------------
" Load specific project configuration file
" -----------------------------------------------------------

"If there's a .vimlocal file automatically source it
function! SourceVimLocal()
    if filereadable(".vimlocal")
        source .vimlocal
    endif
endfunction
call SourceVimLocal()

