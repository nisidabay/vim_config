"------------------------------------------------------------------------------
" Settings
"------------------------------------------------------------------------------
" Language settings
" language messages en_US.UTF-8
" set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencodings=utf-8,latin1
  
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


" Mapping to open Startify from any buffer
nnoremap <silent> <leader>fk :FzfMan<CR>
nnoremap <silent> <leader>ff :FzfFiles<CR>
nnoremap <silent> <leader>fb :FzfBuffers<CR>
nnoremap <silent> <leader>ft :FzfTags<CR>
nnoremap <silent> <leader>fT :FzfBTags<CR>
nnoremap <silent> <leader>fh :FzfHistory:<CR>
nnoremap <silent> <leader>fg :FzfGFiles<CR>
nnoremap <silent> <leader>rg :FzfRg<CR>
nnoremap <silent> <leader>fm :FzfMarks<CR>
nnoremap <silent> <leader>fM :FzfMaps<CR>

" Mapping to open Startify from any buffer
nnoremap <silent> <leader>ss :Startify<CR>

" --- Startify Helper Functions ---

" Function to generate Figlet ASCII art
function! s:figlet(text)
  if executable('figlet')
    return split(system('figlet -f standard ' . shellescape(a:text)), '\n')
  else
    return [ '-> Figlet command not found. Please install it. <-', '' ]
  endif
endfunction

" Function to get the current Git branch
function! s:get_git_branch()
  let branch = system('git branch --show-current 2>/dev/null')
  if v:shell_error == 0 && !empty(branch)
    return ['   Git Branch: ' . trim(branch), '']
  endif
  return []
endfunction

" Function to get the current time
function! s:get_current_time()
    return ['   ' . strftime('%a %d %b %Y, %I:%M %p'), '']
endfunction

" Function to get a random quote, wrapped to 80 columns
" REQUIRES you to create a file at ~/.vim/quotes.txt
function! s:get_random_quote()
  let quotes_file = expand('~/.vim/quotes.txt')
  if filereadable(quotes_file)
    let lines = readfile(quotes_file)
    if !empty(lines)
      let random_line = lines[localtime() % len(lines)]
      " Wrap the quote text to about 65 characters to fit within 80 columns
      let wrapped_quote = system('echo ' . shellescape(random_line) . ' | fold -s -w 65')
      let quote_lines = split(wrapped_quote, '\n')
      " Prepend the first line with 'Quote:' and indent subsequent lines
      let quote_lines[0] = '   Quote: ' . quote_lines[0]
      for i in range(1, len(quote_lines) - 1)
        let quote_lines[i] = '' . quote_lines[i]
      endfor
      return quote_lines + ['']
    endif
  endif
  return []
endfunction

" --- Startify Configuration ---

" Build the custom header by combining elements
let g:startify_custom_header = s:figlet('V i m')
    \ + [ '--------------------------------------------------------------------------', '' ]
    \ + s:get_current_time()
    \ + s:get_git_branch()
    \ + s:get_random_quote()
    \ + ['Vim is not just a text editor, it''s a way of life!']
    \ + [ 'With Vim, you are not a user; you are a master of your text domain.', '' ]
    \ + [ '--------------------------------------------------------------------------', '' ]

" Define the custom commands for the FZF list
let g:startify_commands = [
    \ [ 'Find Files - <leader>ff',     'FzfFiles' ],
    \ [ 'Find Buffers - <leader>fb',   'FzfBuffers' ],
    \ [ 'Find Git Files - <leader>fg', 'FzfGFiles' ],
    \ [ 'Ripgrep - <leader>rg',        'FzfRg' ],
    \ [ 'History - <leader>fh',       'FzfHistory:' ],
    \ [ 'Maps - <leader>fM',          'FzfMaps' ],
    \ [ 'Marks - <leader>fm',         'FzfMarks' ],
    \ ]

" Define the lists to display
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']          },
    \ { 'type': 'files',     'header': ['   Recent Files']      },
    \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
    \ { 'type': 'commands',  'header': ['   FZF Search']        },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']         },
    \ ]

" Your existing bookmarks
let g:startify_bookmarks = [
    \ { 'b': '~/bin' },
    \ { 'd': '~/_dotfiles' },
    \ { 'g': '~/Downloads/Refactor/go_practice'},
    \ { 'p': '~/proyectos_git' },
    \ { 'r': '~/Downloads/Refactor/curso_c'},
    \ { 'v': '~/.vimrc' },
    \ ]
