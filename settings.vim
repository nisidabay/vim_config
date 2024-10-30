"------------------------------------------------------------------------------
" Settings
"------------------------------------------------------------------------------
" Language settings
" language messages en_US.UTF-8
" set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencodings=utf-8,latin1
  
" ZSH
set shell=/bin/zsh

" Keypressed speed
set timeoutlen=500

" Vim required
set nocompatible              

" Set foldmethod
set foldenable
set foldmethod=syntax

" Settings for diff
" Always use vertical splits
set diffopt+=vertical  

" Find the next match as we type the search.This is enabled by default though
set incsearch

" Highlight searches by default
set hlsearch

" Makes search case sensitive when the search term contains an uppercase
" letter, and case insensitive when the search term does not contain any
" uppercase letters. 
set smartcase
set noignorecase

" Prevents the creation of a swap file when editing a file
set noswapfile 

" option prevents the creation of backup files
set nobackup

" only prevents the creation of the backup file for the current buffer
set nowb

" Syntax highlighting for the current buffer
syntax on

" Smart auto indentation
filetype plugin indent on    

" Default encoding
set encoding=utf-8

" Set the backspace for deletion
set backspace=indent,eol,start

" Highlight the current line in every window
set cursorline

" Show line numbers on the side bar
set number

" Show relative numbers on the side bar
set relativenumber

" Show color column
setlocal colorcolumn=80

" Flash the screen instead of beeping on errors
set visualbell

" Enable mouse for scrolling and resizing
set mouse=a

" Set the window's title of current file being edited
set title

" When indenting with > use 4 spaces width
set shiftwidth=4

" Show existing tab with 4 spaces width
set tabstop=4
set softtabstop=4

" On pressing tab, insert 4 spaces
set expandtab

" New lines inherit the indentation of previous lines
set autoindent
set smartindent

" Set history of executed commands
set history=1000

" Show commands at the bottom
set showcmd

" Show current mode at the bottom
set showmode

" Automatically re-read files if unmodified outside Vim
set autoread

" Move between buffers without saving
set hidden

" Can modified buffers
set modifiable 

" Always display the status bar
set laststatus=2

" Always show cursor position
set ruler

" Display all matching files when we tab complete
set wildmenu

" Customize the wildmenu and command line completions
set wildoptions=pum

" Don't show this files
set wildignore=*.swp,*.bak,.git,*.pyc

" Maximum number of tab pages that can be opened from command line
set tabpagemax=40

" Linebreak at 80 chars
set textwidth=80

" Avoid wrapping a line in the middle of a word
set linebreak

" Number of screen lines above and below cursor
set scrolloff=3

" Number of screen columns to show on both sides
set sidescrolloff=5

" Split
set splitbelow
set splitright

" Fixes mouse issues using Alacritty terminal
set ttymouse=sgr

" Load termdebug
packadd! termdebug

" Set the terminal position
augroup TerminalWindow
  autocmd!
  autocmd TerminalOpen * if &buftype == 'terminal' | wincmd L | endif
augroup END
command! TermRight vertical terminal

" Function to generate Figlet ASCII art
function! s:figlet(text)
    return split(system('figlet -f standard ' . shellescape(a:text)), '\n')
endfunction

" Startify configuration
let g:startify_custom_header = s:figlet('V i m')
    \ + ['', 'Vim is not just a text editor, it''s a way of life!','']

let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   Recent Files']   },
    \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ ]

let g:startify_bookmarks = [
    \ { 'b': '~/bin' },
    \ { 's': '~/mac_dotfiles/.bash_aliases' },
    \ { 'v': '~/.vimrc' },
    \ { 'z': '~/mac_dotfiles/.zshrc' },
    \ { 'p': '~/Downloads/Refactor/curso_c'},
    \ ]

let g:startify_custom_footer = [
    \ '',
    \ '   Vim is not just a text editor, it''s a way of life!',
    \ ]
