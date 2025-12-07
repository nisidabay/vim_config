" vim: set foldmethod=marker:
"
" ==============================================================================
"  This file has been refactored to use a single plugin manager (vim-plug)
"  and incorporates best-practice configurations for your setup.
" ==============================================================================

" --- VIM-PLUG START -----------------------------------------------------------
call plug#begin('~/.vim/plugged')

"----[ General & UI ]----------------------------------------------------------
Plug 'mhinz/vim-startify'


" Open Browser 
Plug 'tyru/open-browser.vim'
" Code Navigation
" Plug 'bfrg/vim-cpp-modern'
"Plug 'ludovicchabant/vim-gutentags'

" Themes
" Plug 'sainnhe/everforest'
Plug 'wadackel/vim-dogrun'

" Note-taking and Wiki
Plug 'vimwiki/vimwiki'

" Code Completion and Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" File Icons
=======
Plug 'itchyny/lightline.vim'
Plug 'wadackel/vim-dogrun' " Your theme
>>>>>>> bc68056 (Modify plugins.vim)
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/Colorizer'

"----[ File & Project Navigation ]---------------------------------------------
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"----[ Editing Enhancements ]--------------------------------------------------
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
Plug 'kshenoy/vim-signature'

"----[ Git Integration ]-------------------------------------------------------
Plug 'airblade/vim-gitgutter'
" The best Git wrapper for Vim
Plug 'tpope/vim-fugitive'

"----[ Language Intelligence & Completion ]------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

"----[ Language Specific ]-----------------------------------------------------
" C & C++
Plug 'NLKNguyen/c-syntax.vim'
" Bash
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
" Nim (Official language support)
Plug 'zah/nim.vim'
" Rust
Plug 'rust-lang/rust.vim'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"----[ Notes & Markdown ]------------------------------------------------------
Plug 'vimwiki/vimwiki'
Plug 'dhruvasagar/vim-table-mode'
" Modern Markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mattn/calendar-vim'

"----[ Utilities ]-------------------------------------------------------------
Plug 'tyru/open-browser.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/unicode.vim'

call plug#end()
" --- VIM-PLUG END -------------------------------------------------------------


" ==============================================================================
" --- Plugin Configurations {{{ 
" ==============================================================================

" --- UI & Theme ----------------------------------------------------------- {{{ 
if has('termguicolors')
    set termguicolors
endif
set background=dark
colorscheme dogrun

" Lightline configuration with Git and CoC integration
let g:lightline = {
      \ 'colorscheme': 'dogrun',
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
" }}} 
" --- FZF (Fuzzy Finder) --------------------------------------------------- {{{ 
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

" Your existing FZF mappings are great.
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

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}} 
" --- Language Specific Settings ------------------------------------------- {{{ 
" C / C++
" Using clang-format via coc.nvim is recommended (see coc-settings.json).
let g:linux_kernel_style = '{BasedOnStyle: LLVM, ' 
    \ . 'IndentWidth: 8, ' 
    \ . 'UseTab: Always, ' 
    \ . 'TabWidth: 8, ' 
    \ . 'ContinuationIndentWidth: 8, ' 
    \ . 'BreakBeforeBraces: Linux, ' 
    \ . 'AllowShortIfStatementsOnASingleLine: Never, ' 
    \ . 'AllowShortLoopsOnASingleLine: false, ' 
    \ . 'AllowShortFunctionsOnASingleLine: None, ' 
    \ . 'AllowShortBlocksOnASingleLine: Never, ' 
    \ . 'IndentCaseLabels: false, ' 
    \ . 'AlignAfterOpenBracket: DontAlign, ' 
    \ . 'DerivePointerAlignment: false, ' 
    \ . 'PointerAlignment: Right, ' 
    \ . 'SpaceBeforeParens: ControlStatements, ' 
    \ . 'MaxEmptyLinesToKeep: 2, ' 
    \ . 'KeepEmptyLinesAtTheStartOfBlocks: false, ' 
    \ . 'AlignTrailingComments: false, ' 
    \ . 'ReflowComments: false, ' 
    \ . 'SortIncludes: Never, ' 
    \ . 'ColumnLimit: 80}'

augroup c_cpp_settings
    autocmd!
    autocmd FileType c setlocal tabstop=8 shiftwidth=8 noexpandtab softtabstop=8
augroup END

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
" }}} 
" --- Other Plugin Settings ------------------------------------------------ {{{ 
" Git Gutter
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv[0] | wincmd p | ene | endif

" Vimwiki
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

function! ToggleMarkdown()
  if &filetype == 'vimwiki'
    set ft=markdown
  elseif &filetype == 'markdown'
    set ft=vimwiki
  endif
endfunction
map <silent> <C-N> :call ToggleMarkdown()<CR>

" Markdown Preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0

" UltiSnips (if you decide to use it over CoC snippets)
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger="<c-l>"
" }}} 
" ==============================================================================
" --- General Settings & Commands {{{ 
" ==============================================================================
set path+=**
command! MakeTags !ctags -R .
" }}} 
" ==============================================================================
" --- End of File
" ==============================================================================
