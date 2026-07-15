" ==============================================================================
" Vim-Plug Configuration and Plugin Settings
" ==============================================================================

" --- VIM-PLUG DECLARATION -----------------------------------------------------
call plug#begin('~/.vim/plugged')

" --- General & UI ---
Plug 'mhinz/vim-startify'
Plug 'voldikss/vim-translator'
Plug 'ghifarit53/tokyonight-vim'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/Colorizer'
" Plug 'liuchengxu/vim-which-key' — removed, infrautilizado

" --- File & Project Navigation ---
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

" --- Editing Enhancements ---
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'kshenoy/vim-signature'
Plug 'chrisbra/unicode.vim'

" --- Git Integration ---
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" --- Language Intelligence & Completion ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

" --- Language Specific & Syntax ---
Plug 'editorconfig/editorconfig-vim'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
Plug 'zah/nim.vim'
Plug 'rust-lang/rust.vim'

" --- Notes & Markdown ---
Plug 'vimwiki/vimwiki'
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': ['markdown', 'vimwiki'] }
Plug 'mattn/calendar-vim'
Plug 'tyru/open-browser.vim'

call plug#end()
" --- VIM-PLUG END -------------------------------------------------------------

" ==============================================================================
" Plugin Configurations
" ==============================================================================

" --- UI & Theme ---
if has('termguicolors')
    set termguicolors
endif

let g:tokyonight_style = 'night'
let g:tokyonight_transparent_background = 0
colorscheme tokyonight

" --- Lightline Integration ---
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'coc_status', 'gitbranch' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'coc_status': 'coc#status'
      \ }
      \ }

set guifont=DroidSansMono\ Nerd\ Font\ 14

" --- FZF (Fuzzy Finder) ---
let g:fzf_vim = {}
let g:fzf_vim.command_prefix = 'Fzf'
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
let g:fzf_vim.maps_options = '--no-preview'
let g:fzf_vim.buffers_jump = 1

runtime! ftplugin/man.vim
function! FzfManPages()
    let l:cmd = 'man -k . | sed "s/ *\([^ ]*\) *\([^)]*\)) *- *\(.*\)/\1 [\2] - \3/"'
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
    let l:section = substitute(l:parts[1], '[\\\[\\\]]', '', 'g')
    execute 'Man ' . l:section . ' ' . l:page
endfunction

command! FzfMan call FzfManPages()

nnoremap <silent> <leader>sf :FzfFiles<CR>
nnoremap <silent> <leader>sb :FzfBuffers<CR>
nnoremap <silent> <leader>sg :FzfRg<CR>
nnoremap <silent> <leader>so :FzfHistory:<CR>
nnoremap <silent> <leader>sk :FzfMaps<CR>
nnoremap <silent> <leader>sm :FzfMarks<CR>
nnoremap <silent> <leader>st :FzfTags<CR>
nnoremap <silent> <leader>sT :FzfBTags<CR>
nnoremap <silent> <leader>sG :FzfGFiles<CR>
nnoremap <silent> <leader>sK :FzfMan<CR>
" No f-prefix aliases — only s-prefix like Neovim's Telescope.

" Insert-mode FZF completions are defined in mappings.vim — removed here
" to avoid duplication.

" --- Language Specific Formatting ---
" C / C++ — formatting via clang-format (Linux kernel style).
" local_plugins/c.vim is deployed to ~/.vim/ftplugin/c.vim by setup_vim.sh
" and provides FormatC command + F3 mapping.
" Python
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 

" Rust
let g:rustfmt_autosave = 1

" Codeium
let g:codeium_filetypes = {
  \ 'bash': v:true,
  \ 'lua': v:true,
  \ 'python': v:true,
  \ 'c': v:true,
  \ 'go': v:true,
  \ }

" --- NERDTree ---
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" --- Tagbar ---
let g:tagbar_autofocus = 1

" --- Vim-Signify (git/hg/svn gutter signs) ---
let g:signify_disable_by_default = 0

" --- EditorConfig ---
" Reads .editorconfig on BufRead to apply per-project indent/tab/EOL rules.
" No mappings. Runs silently on file open.
let g:editorconfig_preserve_formatoptions = 1

" --- WebDevIcons ---
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" --- Vimwiki ---
let g:vimwiki_list = [
            \ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/personalwiki/', 'syntax': 'markdown', 'ext': '.md'}
            \ ]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0
let g:calendar_diary=$HOME.'/vimwiki/diary'
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
  autocmd!
  autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

" ToggleMarkdown and <C-N> mapping are defined in mappings.vim — this
" copy is removed to avoid duplication.

" --- Markdown Preview ---
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0

" --- Startify ---
let g:startify_commands = [
    \ [ 'Find Files - <leader>sf',     'FzfFiles' ],
    \ [ 'Find Buffers - <leader>sb',   'FzfBuffers' ],
    \ [ 'Find Git Files - <leader>sG', 'FzfGFiles' ],
    \ [ 'Ripgrep - <leader>sg',        'FzfRg' ],
    \ [ 'History - <leader>so',       'FzfHistory:' ],
    \ [ 'Maps - <leader>sk',          'FzfMaps' ],
    \ [ 'Marks - <leader>sm',          'FzfMarks' ],
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

" --- Translator ---
let g:translator_target_lang = 'es'
let g:translator_default_engines = ['google']
let g:translator_window_type = 'popup'
let g:translator_window_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
nmap <Leader>gt <Plug>TranslateW
vmap <Leader>gt <Plug>TranslateWV

" --- General Settings & Commands ---
set path+=**
command! MakeTags !ctags -R .
