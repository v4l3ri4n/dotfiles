" VIM Configuration

" Cancel Vi compatibility
set nocompatible

" Activate pathogen
call pathogen#infect()

" Activate NERDTree on start
autocmd vimenter * NERDTree

" Display
set title                 " Enable title update
set number                " Show line numbers
set ruler                 " Show the position of the cursor
set wrap                  " Wrap lines

set scrolloff=3           " Scroll offset around cursor

" Search
set ignorecase            " Ignore case in search patterns
set smartcase             " If a search pattern contains a uppercase, activate case sensitivity
set incsearch             " While typing the pattern, highlight matches
set hlsearch              " Highlight search matches

" Beep
set visualbell            " Stop beeping
set noerrorbells          " Stop beeping

" Activate normal behaviour of backspace key
set backspace=indent,eol,start

" A buffer becomes hidden when it's unloaded
set hidden

" Enable syntax color
syntax enable

" Enable Solarized theme with dark background
let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

set guifont=DejaVu\ Sans\ Mono\ 10
set antialias

" Highlight line and column cursor position
set cursorline
set cursorcolumn

" Detect filetype and enable specific behaviours
filetype on
filetype plugin on
filetype indent on

" Tabs and indent
set expandtab           " Insert spaces when tab is pressed
set tabstop=4           " number of spaces for a TAB
set shiftwidth=4        " number of spaces for indent

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Remap escape key
imap ;; <Esc>
map ;; <Esc>

"
" Plugins configuration
"

" -- ack.vim
let g:ack_default_options = " -H --nocolor --nogroup --column" " ensure compatibility with ack-grep 1.9
