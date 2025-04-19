"------------------------------------------------------------------------------
" Vundle configuration 
"------------------------------------------------------------------------------ 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin Manager
Plugin 'VundleVim/Vundle.vim'

" dash-vim
Plugin 'rizzatti/dash.vim'

" Syntax and Language Support
Plugin 'udalov/kotlin-vim'
Plugin 'fwcd/kotlin-language-server'
Plugin 'https://github.com/NLKNguyen/c-syntax.vim'
Plugin 'rust-lang/rust.vim'

" Code Formatting and Linting
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'dense-analysis/ale'
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


" Vim-ai
Plug 'madox2/vim-ai' 

" Ollama Integration - Simple Final Version
" -----------------

" Function to send text to Ollama and display the response
function! OllamaGenerate(prompt, model)
  " Create a temporary file for the prompt
  let l:prompt_file = tempname()
  call writefile([a:prompt], l:prompt_file)
  
  " Create a temporary file for the output
  let l:output_file = tempname()
  
  " Use a simpler shell command that correctly extracts the response
  let l:cmd = "curl -s 'http://localhost:11434/api/generate' "
  let l:cmd .= "-d '{\"model\":\"" . a:model . "\",\"prompt\":\"" . escape(a:prompt, '"\') . "\"}' > " . l:output_file
  
  " Run the command
  call system(l:cmd)
  
  " Process the output file
  let l:output = readfile(l:output_file)
  let l:response = ""
  
  " Process each line to extract the response text
  for l:line in l:output
    let l:match = matchstr(l:line, '"response":"[^"]*"')
    if !empty(l:match)
      let l:text = substitute(l:match, '"response":"', '', '')
      let l:text = substitute(l:text, '"$', '', '')
      let l:response .= l:text
    endif
  endfor
  
  " Create a new buffer for the response
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal filetype=markdown
  
  " Set the content - split by newlines properly
  call setline(1, split(l:response, '\n'))
  
  " Set buffer name
  execute "file Ollama_Response"
  
  " Clean up temporary files
  call delete(l:prompt_file)
  call delete(l:output_file)
endfunction

" Function to send selected text to Ollama
function! OllamaGenerateSelection() range
  let l:model = get(g:, 'ollama_model', 'llama3.2')
  let l:selection = getline(a:firstline, a:lastline)
  let l:text = join(l:selection, "\n")
  call OllamaGenerate(l:text, l:model)
endfunction

" Function to prompt for input and send to Ollama
function! OllamaPrompt()
  let l:model = get(g:, 'ollama_model', 'llama3.2')
  let l:prompt = input("Ollama (" . l:model . "): ")
  if l:prompt != ""
    call OllamaGenerate(l:prompt, l:model)
  endif
endfunction

" Model change function
function! OllamaChangeModel()
  let l:models = []
  let l:default_models = ['llama3.2', 'deepseek-coder']
  
  " Try to get the real model list but fall back to defaults if it fails
  let l:raw = system("curl -s 'http://localhost:11434/api/tags'")
  if v:shell_error == 0 && l:raw =~ '"name"'
    let l:start = 0
    while 1
      let l:name_pos = match(l:raw, '"name":"', l:start)
      if l:name_pos == -1
        break
      endif
      
      let l:name_start = l:name_pos + 8
      let l:name_end = match(l:raw, '"', l:name_start)
      let l:model_name = l:raw[l:name_start:l:name_end-1]
      call add(l:models, l:model_name)
      
      let l:start = l:name_end
    endwhile
  else
    let l:models = l:default_models
  endif
  
  if empty(l:models)
    echo "No models found, using defaults"
    let l:models = l:default_models
  endif
  
  let l:choice = inputlist(['Select Ollama model:'] + l:models)
  if l:choice > 0 && l:choice <= len(l:models)
    let g:ollama_model = l:models[l:choice-1]
    echo "Model set to: " . g:ollama_model
  endif
endfunction

" Set default model
let g:ollama_model = "llama3.2"

" Commands
command! -nargs=1 Ollama call OllamaGenerate(<q-args>, g:ollama_model)
command! OllamaModel call OllamaChangeModel()

" Key mappings - using <leader>ll to avoid conflicts with FZF
nnoremap <leader>ll :call OllamaPrompt()<CR>
vnoremap <leader>ll :call OllamaGenerateSelection()<CR>
nnoremap <leader>lm :OllamaModel<CR>


" Codeium
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
let g:codeium_filetypes = {
  \ 'bash': v:true,
  \ 'lua': v:true,
  \ 'python': v:true,
  \ 'c': v:true,
  \ }

" Open Browser 
Plug 'tyru/open-browser.vim'
" Code Navigation
Plug 'bfrg/vim-cpp-modern'
"Plug 'ludovicchabant/vim-gutentags'

" Themes
Plug 'sainnhe/everforest'
Plug 'ghifarit53/tokyonight-vim'

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

" ALE Configuration
let g:ale_linters = {'c': ['clangd']}
let g:ale_fixers = {'c': ['clang-format', 'clangtidy']}
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic'
let g:ale_fix_on_save = 1
let g:ale_lsp_suggestions = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_c_clangd_options = '--background-index --compile-commands-dir=' . getcwd()
let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_virtualtext_cursor = 'current'
let g:ale_c_parse_compile_commands = 1
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '🔎 '
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" ALE Mappings
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> <leader>d :ALEDetail<CR>
nmap <silent> <leader>f <Plug>(ale_fix)


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

"let g:airline_theme='tokyonight' " Match your colorscheme

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


" Configuration for tokyonight
" let g:tokyonight_style = 'night'  " Available: storm, day, night
" let g:tokyonight_enable_italic = 1
" let g:tokyonight_enable_bold = 1
" let g:tokyonight_disable_italic_comment = 1
" let g:tokyonight_transparent_background = 1  " Values 0 or 1
" let g:tokyonight_transparent_sidebar = 1  " Values 0 or 1
" let g:tokyonight_current_word = 'bold'

" colorscheme tokyonight

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

" Disable ALE's auto-formatting
let g:ale_fix_on_save = 0

" NERDTree Configuration
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

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
            \{'path': '~/personalwiki/', 'syntax': 'markdown', 'ext': '.md'}
            \]

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
function! s:my_fzf_preview_command()
  let l:preview_command = 'bat --color=always --style=plain --line-range=:100 {}'
  return l:preview_command
endfunction
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ['right:60%:wrap', 'ctrl-/']
let g:fzf_action = {'enter': 'edit'}
let $FZF_DEFAULT_OPTS = '--preview-window=right:60%:wrap --preview ' . shellescape(s:my_fzf_preview_command())
let g:fzf_colors = { 'fg':      ['fg', 'Normal'],
                   \ 'bg':      ['bg', 'Normal'],
                   \ 'hl':      ['fg', 'Comment'],
                   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                   \ 'hl+':     ['fg', 'Statement'],
                   \ 'info':    ['fg', 'PreProc'],
                   \ 'border':  ['fg', 'Ignore'],
                   \ 'prompt':  ['fg', 'Conditional'],
                   \ 'pointer': ['fg', 'Exception'],
                   \ 'marker':  ['fg', 'Keyword'],
                   \ 'spinner': ['fg', 'Label'],
                   \ 'header':  ['fg', 'Comment'] }

" Command to call the FzfManPages function
" Ensure Man command is available
runtime! ftplugin/man.vim

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
nnoremap <silent> <leader>fk :FzfMan<CR>

" Mapping to trigger FzfMan
nnoremap <silent> <leader>fk :FzfMan<CR>
nnoremap <silent> <leader>ff :FzfFiles<CR>
nnoremap <silent> <leader>fb :FzfBuffers<CR> 
nnoremap <silent> <leader>fl :FzfLines<CR> 
nnoremap <silent> <leader>ft :FzfTags<CR> 
nnoremap <silent> <leader>fT :FzfBTags<CR> 
nnoremap <silent> <leader>fh :FzfHistory:<CR> 
nnoremap <silent> <leader>fg :FzfGFiles<CR> 
nnoremap <silent> <leader>rg :FzfRg<CR> 
nnoremap <silent> <leader>fm :FzfMarks<CR> 
nnoremap <silent> <leader>fM :FzfMaps<CR> 

" File Finding Configuration

set path+=**
command! MakeTags !ctags -R .

" Kotlin Configuration
autocmd BufReadPost *.kt setlocal filetype=kotlin
let g:LanguageClient_serverCommands = { 'kotlin': ["kotlin-language-server"] }

" Rust Configuration
let g:rustfmt_autosave = 1

" Dasht Configuration
nmap <Leader>k <Plug>DashSearch
nmap <Leader>kk <Plug>DashSearch

" Translate selected text
" Map in visual mode to translate selected text using Google Translate
vnoremap <leader>tw y:call OpenInBrowser()<CR>

function! OpenInBrowser()
    let selected_text = @"
    " Remove trailing newlines and whitespace
    let clean_text = substitute(selected_text, '\n\+$', '', 'g')
    " Replace spaces with %20 for basic URL encoding
    let encoded_text = substitute(clean_text, ' ', '%20', 'g')
    " Build the URL
    let url = "https://translate.google.com/?sl=auto&tl=en&text=" . encoded_text
    " Open the URL in the default browser
    execute "silent !xdg-open '" . url . "'"
endfunction

