" VIM Configuration

" -----------------------------------------------------------
" General
" -----------------------------------------------------------

set nocompatible            " Cancel Vi compatibility
call pathogen#infect()      " Activate pathogen
autocmd vimenter * NERDTree " Activate NERDTree on start

let mapleader=","              " use comma as leader
set backspace=indent,eol,start " Activate normal behaviour of backspace key
set hidden                     " A buffer becomes hidden when it's unloaded

" Beep
set visualbell            " Stop beeping
set noerrorbells          " Stop beeping

" Search
set ignorecase            " Ignore case in search patterns
set smartcase             " If a search pattern contains a uppercase, activate case sensitivity
set incsearch             " While typing the pattern, highlight matches
set hlsearch              " Highlight search matches
nnoremap <leader><space> :noh<CR> " Turn off search highlight

" auto reload the config file after modifications
autocmd BufWrite $MYVIMRC source $MYVIMRC

:nnoremap <leader>ev :vsplit $MYVIMRC<cr> " edit vimrc mapping
:nnoremap <leader>sv :source $MYVIMRC<cr> " reload vimrc mapping

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

" Do not auto insert comment chars on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

" Remap escape key
imap ,, <Esc>
map ,, <Esc>

" -----------------------------------------------------------
" Plugins configuration
" -----------------------------------------------------------

" ack.vim
let g:ack_default_options = " -H --nocolor --nogroup --column" " ensure compatibility with ack-grep 1.9

" php.vim
" This must be put at the end of vimrc
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

