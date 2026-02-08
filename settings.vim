"------------------------------------------------------------------------------
" Settings
"------------------------------------------------------------------------------
" Language settings
set encoding=utf-8
set fileencodings=utf-8
  
" Undodirectory
set undodir=$HOME/.vim/undodir
set undofile

" ZSH
set shell=/bin/zsh

" Keypressed speed
set timeoutlen=500

" Vim required
set nocompatible              
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

" Save the folds
augroup remember_folds
autocmd! 
autocmd BufWinLeave, BufLeave ?* silent! mkview
autocmd BufWinEnter *.* silent! loadview 
augroup END

" option prevents the creation of backup and swap files
set nobackup
set noswapfile
set nowritebackup
" only prevents the creation of the backup file for the current buffer
set nowb

" Syntax highlighting for the current buffer
syntax on

" Smart auto indentation
filetype plugin indent on    

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
set wildignore=*.swp,*.bak,.git,*.pyc,*/tmp/*,*.so,*.zip,*.db,*.sqlite,*node_modules/

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

" Display the match number of the search
set shortmess-=S

" Load termdebug
packadd! termdebug

" 1. Command to open terminal on the RIGHT
" Usage: :TermRight
command! TermRight vertical terminal

" 2. Command to open terminal at the BOTTOM
" Usage: :TermBottom
command! TermBottom belowright terminal


" ------------------------------------------------------------------------------
" --- Startify Configuration
" ------------------------------------------------------------------------------

let g:startify_commands = [
    \ [ 'Find Files - <leader>ff',     'FzfFiles' ],
    \ [ 'Find Buffers - <leader>fb',   'FzfBuffers' ],
    \ [ 'Find Git Files - <leader>fg', 'FzfGFiles' ],
    \ [ 'Ripgrep - <leader>rg',        'FzfRg' ],
    \ [ 'History - <leader>fh',       'FzfHistory:' ],
    \ [ 'Maps - <leader>fM',          'FzfMaps' ],
    \ [ 'Marks - <leader>fm',          'FzfMarks' ],
    \ ]

let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']          },
    \ { 'type': 'files',     'header': ['   Recent Files']      },
    \ { 'type': 'commands',  'header': ['   FZF Search']        },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']         },
    \ ]

let g:startify_bookmarks = [
    \ { 'D': '~/Downloads'},
    \ { 'b': '~/bin' },
    \ { 'd': '~/dotfiles' },
    \ { 'n': '~/nim_projects' },
    \ { 'r': '~/Downloads/Refactor'},
    \ { 't': '~/temp' },
    \ { 'v': '~/.vimrc' },
    \ { 'z': '~/Downloads/zlibrary/' },
    \ ]
