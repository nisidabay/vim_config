
"------------------------------------------------------------------------------
" Vundle configuration 
"------------------------------------------------------------------------------ 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin Manager
Plugin 'VundleVim/Vundle.vim'


" Syntax and Language Support
Plugin 'https://github.com/NLKNguyen/c-syntax.vim'
Plugin 'rust-lang/rust.vim'

" Code Formatting and Linting
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'rhysd/vim-clang-format'
Plugin 'vim-autoformat/vim-autoformat'

" File Navigation and Project Management
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" Visual Enhancements
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'

" Editing Enhancements
Plugin 'Raimondi/delimitMate'
Plugin 'kshenoy/vim-signature'

" Utilities
Plugin 'instant-markdown/vim-instant-markdown'
Plugin 'mattn/calendar-vim'
Plugin 'chrisbra/unicode.vim'

" Integration and Navigation
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'puremourning/vimspector'

call vundle#end()
call glaive#Install()       

"------------------------------------------------------------------------------
"  configuration 
"------------------------------------------------------------------------------
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')


"" Startify Vim
Plug 'mhinz/vim-startify'


" Codeium
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
let g:codeium_filetypes = {
  \ 'bash': v:true,
  \ 'lua': v:true,
  \ 'python': v:true,
  \ 'c': v:true,
  \ 'go': v:true,
  \ }

" Open Browser 
Plug 'tyru/open-browser.vim'
" Code Navigation
" Plug 'bfrg/vim-cpp-modern'
"Plug 'ludovicchabant/vim-gutentags'

" Themes
Plug 'sainnhe/everforest'

" Note-taking and Wiki
Plug 'vimwiki/vimwiki'

" Code Completion and Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" File Icons
Plug 'ryanoasis/vim-devicons'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Undo Tree
Plug 'mbbill/undotree'

" Text Manipulation
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Language Support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Markdown Support
Plug 'dhruvasagar/vim-table-mode'

" Shell Formatting
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" Git Integration
Plug 'airblade/vim-gitgutter'

" Documentation
" Plug 'sunaku/vim-dasht'
call plug#end()

"------------------------------------------------------------------------------
" Plugin Configurations
"------------------------------------------------------------------------------

" vim-gutentags Configuration
"let g:gutentags_ctags_extra_args = ['-c', '.ctags.cnf']

" Git Gutter Configuration
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline_section_b = '%{getcwd()}'  " Current directory in section B
let g:airline_section_c = '%t'  " Just the tail of the filename
let g:airline_section_x = '%{&filetype}'  " Filetype in section X
let g:airline_section_y = '%{strftime("%H:%M")}'  " Current time in section Y
let g:airline_section_z = 'ln:%l/%L col:%c'  " Custom line/column display
let g:airline#extensions#ale#enabled = 1  " Show ALE errors in airline
let g:airline#extensions#branch#enabled = 1  " Show git branch
let g:airline#extensions#tagbar#enabled = 1  " Show tagbar integration
let g:airline_powerline_fonts = 1 
let g:airline_theme='everforest' " Match your colorscheme


" Color Scheme Configuration
if has('termguicolors')
    set termguicolors
endif

set background=dark
" Configuration for everforest
" " Everforest settings - important: set transparency BEFORE loading colorscheme
let g:everforest_background = 'soft'
let g:everforest_better_performance = 1
let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 1
let g:everforest_transparent_background = 2  " Changed from 1 to 2 for full transparency
let g:everforest_sign_column_background = 'none'

" Load colorscheme after settings
colorscheme everforest


" " Force transparency after colorscheme
"highlight Normal guibg=NONE ctermbg=NONE

" Font settings. Patched italic font, set in st terminal
set guifont=Fisa\ Code:h14


" UltiSnips Configuration
let g:UltiSnipsExpandTrigger="<c-l>"

" Python formatting
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 

" C formatting
let g:codefmt_enabled = 0
" Define the Linux kernel style (used by ftplugin/c.vim)
let g:linux_kernel_style = 
    \ '{BasedOnStyle: LLVM, ' .
    \ 'IndentWidth: 8, ' .
    \ 'UseTab: Always, ' .
    \ 'TabWidth: 8, ' .
    \ 'ContinuationIndentWidth: 8, ' .
    \ 'BreakBeforeBraces: Linux, ' .
    \ 'AllowShortIfStatementsOnASingleLine: Never, ' .
    \ 'AllowShortLoopsOnASingleLine: false, ' .
    \ 'AllowShortFunctionsOnASingleLine: None, ' .
    \ 'AllowShortBlocksOnASingleLine: Never, ' .
    \ 'IndentCaseLabels: false, ' .
    \ 'AlignAfterOpenBracket: DontAlign, ' .
    \ 'DerivePointerAlignment: false, ' .
    \ 'PointerAlignment: Right, ' .
    \ 'SpaceBeforeParens: ControlStatements, ' .
    \ 'MaxEmptyLinesToKeep: 2, ' .
    \ 'KeepEmptyLinesAtTheStartOfBlocks: false, ' .
    \ 'AlignTrailingComments: false, ' .
    \ 'ReflowComments: false, ' .
    \ 'SortIncludes: Never, ' .
    \ 'ColumnLimit: 80}'

" Ensure proper indentation settings
augroup c_cpp_settings
    autocmd!
    " C files use Linux kernel style
    autocmd FileType c setlocal tabstop=8 shiftwidth=8 noexpandtab softtabstop=8
augroup END

" NERDTree Configuration
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv[0] | wincmd p | ene | endif

" devicons Configuration
set guifont=DroidSansMono\ Nerd\ Font\ 14

" Vimwiki Configuration
let g:vimkwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
  autocmd!
  autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end
let g:vimwiki_list = [
            \ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/personalwiki/', 'syntax': 'markdown', 'ext': '.md'}
            \ ]

let g:calendar_diary=$HOME.'/vimwiki/diary'
let g:instant_markdown_autostart = 0
let g:vimwiki_global_ext = 0

" Markdown Toggle Function
function! ToggleMarkdown()
  if &filetype == 'vimwiki'
    set ft=markdown
  elseif &filetype == 'markdown'
    set ft=vimwiki
  endif
endfunction
map <silent> <C-N> :call ToggleMarkdown()<CR>

" FZF Configuration
" Initialize the main dictionary for fzf.vim settings
let g:fzf_vim = {}

" Use the fzf.vim command prefix 'Fzf' for all commands (e.g., FzfFiles)
let g:fzf_vim.command_prefix = 'Fzf'

" Configure the preview window. fzf.vim will automatically use a smart
" previewer script for files, grep results, etc. Toggles with CTRL-/
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

" For :FzfMaps, disable the preview window since the output is not a file.
let g:fzf_vim.maps_options = '--no-preview'

" [Buffers] Jump to the existing window if possible
let g:fzf_vim.buffers_jump = 1

" Command to call the FzfManPages function
" Ensure Man command is available
runtime! ftplugin/man.vim

" A pure man-page finder that searches for files directly.
function! FzfManPages()
    let l:cmd = 'man -k . | sed "s/ *\([^ ]*\) *(\([^)]*\)) *- *\(.*\)/\1 [\2] - \3/"'
    call fzf#run({
        \ 'source': l:cmd,
        \ 'sink': function('s:OpenManPage'),
        \ 'options': '--ansi --preview "echo {1} {2} | sed \"s/\[//;s/\]//\" | xargs man -P cat" '
        \            . '--preview-window=right:60%:wrap'
        \ })
endfunction

function! s:OpenManPage(selection)
    let l:parts = split(a:selection)
    let l:page = l:parts[0]
    let l:section = substitute(l:parts[1], '[\[\]]', '', 'g')
    execute 'Man ' . l:section . ' ' . l:page
endfunction

command! FzfMan call FzfManPages()

" Mappings to trigger Fzf commands
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

" Insert mode completion mappings for fzf
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" File Finding Configuration
set path+=**
command! MakeTags !ctags -R .

" Rust Configuration
let g:rustfmt_autosave = 1
