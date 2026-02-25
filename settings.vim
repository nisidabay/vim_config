" ==============================================================================
" Core Settings
" ==============================================================================

" --- Encoding & Shell ---
set encoding=utf-8
set fileencodings=utf-8
set shell=/bin/zsh

" --- General Mechanics ---
set nocompatible              
set timeoutlen=500
set history=1000
set autoread                  " Automatically re-read files if unmodified outside Vim
set hidden                    " Move between buffers without saving
set modifiable 

" --- Clipboard ---
set clipboard=unnamedplus

" --- UI & Rendering ---
syntax on
set cursorline                " Highlight the current line in every window
set number                    " Show line numbers on the side bar
set relativenumber            " Show relative numbers on the side bar
set colorcolumn=80            " Show 80-character limit column
set visualbell                " Flash the screen instead of beeping on errors
set title                     " Set the window's title to the current file
set laststatus=2              " Always display the status bar
set ruler                     " Always show cursor position
set scrolloff=3               " Number of screen lines above and below cursor
set sidescrolloff=5           " Number of screen columns to show on both sides
set shortmess-=S              " Display the match number of the search

" --- Interactions ---
set mouse=a                   " Enable mouse for scrolling and resizing
set ttymouse=sgr              " Fixes mouse issues using Alacritty terminal

" --- Indentation & Formatting ---
filetype plugin indent on    
set expandtab                 " On pressing tab, insert 4 spaces
set shiftwidth=4              " When indenting with >, use 4 spaces
set tabstop=4                 " Show existing tab with 4 spaces width
set softtabstop=4
set autoindent                " New lines inherit the indentation of previous lines
set smartindent
set backspace=indent,eol,start " Set the backspace behavior for deletion
set textwidth=80              " Linebreak at 80 chars
set linebreak                 " Avoid wrapping a line in the middle of a word

" --- Windows & Splitting ---
set splitbelow                " Split horizontal panes to the bottom
set splitright                " Split vertical panes to the right

" --- Command Line & Tabbing ---
set showcmd                   " Show commands at the bottom
set showmode                  " Show current mode at the bottom
set wildmenu                  " Display all matching files when we tab complete
set wildoptions=pum           " Customize the wildmenu and command line completions
set wildignore=*.swp,*.bak,.git,*.pyc,*/tmp/*,*.so,*.zip,*.db,*.sqlite,*node_modules/
set tabpagemax=40             " Maximum number of tab pages opened from CLI

" --- Undo & Backups ---
set undodir=$HOME/.vim/undodir
set undofile
set nobackup                  " Prevent creation of backup and swap files
set noswapfile
set nowritebackup
set nowb

" --- Folds ---
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

" --- Terminal Commands ---
" 1. Command to open terminal on the RIGHT
command! TermRight vertical terminal

" 2. Command to open terminal at the BOTTOM
command! TermBottom belowright terminal
